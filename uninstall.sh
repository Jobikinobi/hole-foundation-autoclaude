#!/bin/bash
# AutoClaude Uninstaller

echo "Uninstalling AutoClaude..."

# Remove command
if [ -f "/usr/local/bin/autoclaude" ]; then
    sudo rm -f "/usr/local/bin/autoclaude"
elif [ -f "$HOME/.local/bin/autoclaude" ]; then
    rm -f "$HOME/.local/bin/autoclaude"
fi

# Ask about config
read -p "Remove configuration files? (y/n): " remove_config
if [[ "$remove_config" =~ ^[Yy]$ ]]; then
    rm -rf "$HOME/.autoclaude"
fi

echo "✅ AutoClaude uninstalled"
