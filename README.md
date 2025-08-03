# HOLE Foundation AutoClaude

An autonomous Claude Code system that enables fully self-managed software development with minimal human intervention.

## Overview

AutoClaude is a comprehensive framework that transforms Claude Code into a fully autonomous development assistant capable of:

- 🚀 Self-initializing project structures
- 📚 Autonomous documentation research and gathering
- 🔧 Intelligent technology selection based on stability and LLM compatibility
- 🐳 Sandboxed execution environment for safety
- 🔄 Automatic context compression and session continuation
- 📦 Self-managed GitHub repository creation and synchronization
- 🧪 Test-driven development with autonomous testing
- 📝 Intelligent commit messages and PR generation

## Key Features

### 1. **Hook-Based Automation**
Leverages Claude Code's hook system to intercept and enhance every stage of the development process.

### 2. **Sandbox Environment**
Docker-based isolation ensures safe execution of generated code without affecting the host system.

### 3. **Context Management**
Advanced compression strategies enable long-running sessions with up to 32x context reduction.

### 4. **Autonomous Workflow**
Follows the proven pattern: `Explore → Plan → Research → Implement → Test → Commit → Compress`

### 5. **Self-Documentation**
Maintains its own CLAUDE.md with architectural decisions, progress tracking, and discovered patterns.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/Jobikinobi/hole-foundation-autoclaude.git
cd hole-foundation-autoclaude

# Install dependencies
./scripts/setup.sh

# Configure Claude Code hooks
claude --config-dir .claude-code/config

# Launch autonomous mode
./scripts/launch-autonomous.sh "Build a REST API for task management"
```

## Architecture

```
hole-foundation-autoclaude/
├── hooks/                 # Claude Code hook implementations
│   ├── pre-tool-use/     # Security and validation hooks
│   ├── post-tool-use/    # Logging and state tracking
│   ├── session-start/    # Environment initialization
│   └── pre-compact/      # Context compression triggers
├── docker/               # Sandbox environment configs
│   ├── Dockerfile        # Base development image
│   └── compose.yml       # Multi-container setup
├── templates/            # Project templates
│   ├── CLAUDE.md         # Auto-generated memory template
│   └── project-types/    # Language-specific templates
├── examples/             # Example autonomous projects
└── docs/                 # Extended documentation
```

## How It Works

1. **Initialization**: When given a project description, AutoClaude analyzes requirements and selects appropriate technologies.

2. **Research Phase**: Autonomously gathers documentation from official sources, high-quality examples, and trusted resources.

3. **Planning**: Creates a detailed project plan with milestones, storing it in CLAUDE.md for persistence.

4. **Implementation**: Builds the project incrementally, following discovered conventions and best practices.

5. **Testing**: Implements comprehensive tests using TDD principles where applicable.

6. **Context Management**: Monitors context usage and triggers compression or handoff procedures as needed.

7. **GitHub Sync**: Automatically creates repositories and commits progress with meaningful messages.

## Configuration

### Claude Code Settings

Create `.claude-code/settings.json`:

```json
{
  "hooks": {
    "sessionStart": "./hooks/session-start/init-sandbox.sh",
    "preToolUse": "./hooks/pre-tool-use/validate-safety.sh",
    "postToolUse": "./hooks/post-tool-use/track-progress.sh",
    "preCompact": "./hooks/pre-compact/prepare-handoff.sh"
  },
  "memory": {
    "autoSave": true,
    "compressionThreshold": 0.75
  }
}
```

### Environment Variables

```bash
# Required
export GITHUB_TOKEN="your-github-token"
export ANTHROPIC_API_KEY="your-api-key"

# Optional
export AUTOCLAUDE_SANDBOX_DIR="/path/to/sandbox"
export AUTOCLAUDE_MAX_CONTEXT_PERCENT=80
export AUTOCLAUDE_AUTO_COMMIT=true
```

## Safety Features

- **Sandboxed Execution**: All code runs in isolated Docker containers
- **Hook Validation**: Pre-execution checks for dangerous commands
- **Resource Limits**: CPU, memory, and disk usage constraints
- **Network Isolation**: Limited to documentation and GitHub access
- **Audit Logging**: Complete activity tracking in `.claude-code/logs`

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](docs/CONTRIBUTING.md) for guidelines.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Acknowledgments

Built on research from:
- Anthropic's Claude Code best practices
- Reflection AI's Asimov documentation ingestion
- MIT's autonomous coding research
- Community patterns from 2025 AI coding practices

---

**Note**: This is an experimental system. Always review generated code before production use.