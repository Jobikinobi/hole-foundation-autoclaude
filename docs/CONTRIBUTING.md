# Contributing to AutoClaude

Thank you for your interest in contributing to AutoClaude! This document provides guidelines and instructions for contributing.

## Code of Conduct

Please be respectful and constructive in all interactions. We aim to create a welcoming environment for all contributors.

## How to Contribute

### Reporting Issues

1. Check existing issues to avoid duplicates
2. Use issue templates when available
3. Provide clear reproduction steps
4. Include relevant system information

### Submitting Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Make your changes following our coding standards
4. Write or update tests as needed
5. Update documentation
6. Commit with clear messages
7. Push to your fork
8. Submit a pull request

### Coding Standards

- Follow existing code style and patterns
- Write clear, self-documenting code
- Add comments only when necessary
- Ensure all hooks pass validation
- Test in Docker sandbox when possible

### Testing

Before submitting:

```bash
# Run setup validation
./scripts/test-autoclaude.sh

# Test hooks manually
echo '{"sessionId":"test","workingDirectory":"."}' | ./hooks/session-start/init-sandbox.sh

# Test in Docker sandbox
docker compose -f docker/compose.yml run autoclaude-sandbox
```

### Documentation

- Update README.md for user-facing changes
- Document new hooks in docs/hooks.md
- Add examples for new features
- Keep CLAUDE.md template current

## Development Setup

1. Clone your fork
2. Run `./scripts/setup.sh`
3. Copy `.env.example` to `.env`
4. Add your API keys
5. Test your setup

## Hook Development

When creating new hooks:

1. Follow the existing naming convention
2. Make scripts executable
3. Handle errors gracefully
4. Log appropriately
5. Return proper JSON responses
6. Document hook behavior

Example hook structure:

```bash
#!/bin/bash
set -euo pipefail

INPUT=$(cat)
# Process input...

# Return response
cat <<EOF
{
  "action": "continue",
  "context": "Optional context message"
}
EOF
```

## Areas for Contribution

- Additional hook implementations
- Language-specific project templates
- Documentation improvements
- Testing infrastructure
- Security enhancements
- Performance optimizations
- New autonomous workflows

## Questions?

Open an issue with the "question" label or discuss in existing issues.

Thank you for contributing to AutoClaude!