#!/bin/bash
# AutoClaude Setup Script
# Initializes the AutoClaude environment

set -euo pipefail

echo "🚀 AutoClaude Setup"
echo "=================="

# Check dependencies
echo "Checking dependencies..."

# Check for Claude Code
if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code not found. Please install it first:"
    echo "   npm install -g @anthropic-ai/claude-code"
    exit 1
fi

# Check for Docker (optional but recommended)
if command -v docker &> /dev/null; then
    echo "✅ Docker found"
    DOCKER_AVAILABLE=true
else
    echo "⚠️  Docker not found. Sandbox features will be limited."
    echo "   Install Docker from: https://docs.docker.com/get-docker/"
    DOCKER_AVAILABLE=false
fi

# Check for Git
if ! command -v git &> /dev/null; then
    echo "❌ Git not found. Please install Git first."
    exit 1
fi

# Check for GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "⚠️  GitHub CLI not found. Auto-repository creation will not work."
    echo "   Install from: https://cli.github.com/"
fi

# Check for jq
if ! command -v jq &> /dev/null; then
    echo "❌ jq not found. Please install jq:"
    echo "   macOS: brew install jq"
    echo "   Ubuntu: sudo apt-get install jq"
    exit 1
fi

# Create necessary directories
echo -e "\nCreating directory structure..."
mkdir -p .claude-code/{config,logs,state,backups,handoff,temp}
mkdir -p examples/simple-api
mkdir -p docs

# Set up Claude Code configuration
echo -e "\nConfiguring Claude Code hooks..."
cat > .claude-code/config/settings.json <<'EOF'
{
  "hooks": {
    "sessionStart": {
      "command": "./hooks/session-start/init-sandbox.sh"
    },
    "preToolUse": [
      {
        "command": "./hooks/pre-tool-use/validate-safety.sh"
      }
    ],
    "postToolUse": [
      {
        "command": "./hooks/post-tool-use/track-progress.sh"
      }
    ],
    "preCompact": {
      "command": "./hooks/pre-compact/prepare-handoff.sh"
    }
  },
  "memory": {
    "autoSave": true,
    "compressionThreshold": 0.75,
    "location": "./CLAUDE.md"
  },
  "tools": {
    "bash": {
      "requireApproval": false,
      "sandboxed": true
    },
    "write": {
      "requireApproval": false
    },
    "edit": {
      "requireApproval": false
    }
  }
}
EOF

# Build Docker image if available
if [ "$DOCKER_AVAILABLE" = true ]; then
    echo -e "\nBuilding Docker sandbox image..."
    cd docker
    docker compose build --quiet
    cd ..
    echo "✅ Docker sandbox ready"
fi

# Initialize git repository if not already initialized
if [ ! -d .git ]; then
    echo -e "\nInitializing Git repository..."
    git init
    git add .
    git commit -m "Initial AutoClaude setup"
fi

# Create example environment file
if [ ! -f .env ]; then
    echo -e "\nCreating example .env file..."
    cat > .env.example <<'EOF'
# AutoClaude Environment Configuration

# Required for GitHub integration
GITHUB_TOKEN=your-github-token-here

# Required for Claude Code
ANTHROPIC_API_KEY=your-anthropic-api-key-here

# Optional settings
AUTOCLAUDE_SANDBOX_DIR=/tmp/autoclaude-sandbox
AUTOCLAUDE_MAX_CONTEXT_PERCENT=80
AUTOCLAUDE_AUTO_COMMIT=true
AUTOCLAUDE_DEFAULT_LANGUAGE=python
AUTOCLAUDE_DEFAULT_FRAMEWORK=flask

# Docker settings (if using Docker sandbox)
COMPOSE_PROJECT_NAME=autoclaude
SESSION_ID=default
EOF
    echo "⚠️  Please copy .env.example to .env and add your API keys"
fi

# Create a simple test script
echo -e "\nCreating test script..."
cat > scripts/test-autoclaude.sh <<'EOF'
#!/bin/bash
# Test AutoClaude functionality

echo "Testing AutoClaude setup..."

# Test hook execution
if [ -x hooks/session-start/init-sandbox.sh ]; then
    echo "✅ Hooks are executable"
else
    echo "❌ Hooks are not executable"
    exit 1
fi

# Test Docker sandbox (if available)
if command -v docker &> /dev/null; then
    if docker run --rm autoclaude/sandbox:latest echo "Sandbox works"; then
        echo "✅ Docker sandbox functional"
    else
        echo "❌ Docker sandbox failed"
    fi
fi

# Test Claude Code integration
if command -v claude &> /dev/null; then
    echo "✅ Claude Code available"
else
    echo "❌ Claude Code not found"
fi

echo -e "\n✨ AutoClaude is ready to use!"
EOF

chmod +x scripts/test-autoclaude.sh
chmod +x scripts/setup.sh

# Final instructions
echo -e "\n✅ Setup complete!"
echo -e "\nNext steps:"
echo "1. Copy .env.example to .env and add your API keys"
echo "2. Run ./scripts/test-autoclaude.sh to verify installation"
echo "3. Configure Claude Code to use this directory's hooks:"
echo "   claude --config-dir .claude-code/config"
echo -e "\nTo start an autonomous session:"
echo "   ./scripts/launch-autonomous.sh \"Your project description\""