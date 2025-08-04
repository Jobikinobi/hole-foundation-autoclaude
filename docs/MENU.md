# AutoClaude Interactive Menu Guide

The AutoClaude interactive menu provides a user-friendly interface for managing all aspects of your autonomous development projects.

## Installation

```bash
./install.sh
```

This installs the `autoclaude` command globally, allowing you to access the menu from anywhere.

## Menu Structure

### Main Menu
```
1) Start New Project      - Create a new AutoClaude project
2) Open Existing Project  - Work with existing projects
3) Setup AutoClaude      - Run initial setup and configuration
4) Check System Status   - Verify dependencies and environment
5) Configuration         - Adjust settings and preferences
6) Help & Documentation  - Access guides and documentation
0) Exit
```

### Project Management

#### Creating New Projects

When creating a new project, you'll be asked for:

1. **Project Name**: Alphanumeric with hyphens/underscores
2. **Description**: Brief description of the project's purpose
3. **Location**: Where to create the project
   - Default workspace (`~/autoclaude-projects`)
   - Current directory
   - Custom location

The menu automatically:
- Creates project directory structure
- Copies AutoClaude hooks and scripts
- Initializes CLAUDE.md with project information
- Registers the project for easy access

#### Opening Existing Projects

The menu maintains a registry of all your AutoClaude projects. Select from the list to:
- Launch autonomous development
- Resume previous sessions
- Check project status
- Manage Git operations
- Control containers

### Project Actions

Once in a project, you have access to:

1. **Launch Autonomous Development**
   - Provide a mission description
   - AutoClaude handles the rest autonomously

2. **Resume Previous Session**
   - Continues from where you left off
   - Preserves context and progress

3. **Interactive Claude Session**
   - Direct interaction with Claude Code
   - Manual control over development

4. **View Project Status**
   - Git status and recent commits
   - Implementation progress from CLAUDE.md
   - Recent activity logs

5. **Run Tests**
   - Execute project test suite
   - View test results

6. **Git Operations**
   - Commit with AutoClaude attribution
   - Push/pull from remote
   - Create and switch branches
   - View commit history

7. **Container Management**
   - Start/stop sandbox containers
   - View container logs
   - Shell into running containers
   - Build/rebuild images

## Configuration

The menu stores configuration in `~/.autoclaude/config`:

- **Workspace Path**: Default location for new projects
- **Container Runtime**: Auto, Docker, or Podman preference
- **Auto-commit**: Enable automatic Git commits
- **Sandbox Usage**: Enable/disable container isolation

Project registry is maintained in `~/.autoclaude/projects`.

## Keyboard Shortcuts

While in menus:
- Number keys: Select options
- `0`: Return to previous menu
- `Ctrl+C`: Exit immediately

## Tips and Tricks

### Project Organization

1. Use descriptive project names
2. Keep related projects in the same workspace
3. Use the import feature for existing codebases

### Workflow Optimization

1. Set environment variables in `.env` before launching
2. Use auto-commit for continuous progress tracking
3. Check system status regularly to ensure dependencies

### Container Management

1. Start sandbox before autonomous development
2. Use shell access for debugging
3. Rebuild images after Dockerfile changes

## Troubleshooting

### Menu Not Found
```bash
# Ensure installation completed
./install.sh

# Check PATH includes installation directory
echo $PATH
```

### Projects Not Listed
```bash
# Check registry file
cat ~/.autoclaude/projects

# Import existing project from menu
```

### Container Issues
```bash
# Use check status option
# Run container management → List Containers
# Check logs for errors
```

## Advanced Usage

### Command Line Arguments

While the menu is interactive, you can pass arguments:

```bash
autoclaude new              # Jump to new project
autoclaude open             # Jump to project list
autoclaude help             # Show help
```

### Environment Variables

Set these before launching:
```bash
export ANTHROPIC_API_KEY="your-key"
export GITHUB_TOKEN="your-token"
export AUTOCLAUDE_WORKSPACE="/custom/path"
```

### Custom Workspace

Change default workspace:
1. Select Configuration from main menu
2. Choose Workspace option
3. Enter new path

### Multiple Configurations

For different environments:
```bash
# Development
AUTOCLAUDE_CONFIG=~/.autoclaude/config.dev autoclaude

# Production
AUTOCLAUDE_CONFIG=~/.autoclaude/config.prod autoclaude
```

## Integration with IDEs

### VS Code
```json
{
  "terminal.integrated.shellArgs.linux": ["autoclaude"],
  "terminal.integrated.shellArgs.osx": ["autoclaude"]
}
```

### Terminal Aliases
```bash
# Add to .bashrc or .zshrc
alias ac="autoclaude"
alias acnew="autoclaude new"
alias acopen="autoclaude open"
```

## Best Practices

1. **Regular Commits**: Use Git operations menu frequently
2. **Project Descriptions**: Be specific about project goals
3. **Session Management**: Resume sessions to preserve context
4. **Container Cleanup**: Stop containers when not in use
5. **Configuration Backup**: Keep a copy of `~/.autoclaude/config`

## Extending the Menu

The menu system is designed to be extensible. To add custom options:

1. Edit `autoclaude.sh`
2. Add new menu items and functions
3. Follow the existing pattern for consistency

Example:
```bash
# Add to main_menu function
echo "7) Custom Action"

# Add to case statement
7) custom_action ;;

# Define function
custom_action() {
    echo "Performing custom action..."
    # Your code here
}
```