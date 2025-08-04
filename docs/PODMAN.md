# Using AutoClaude with Podman

AutoClaude fully supports Podman as a drop-in replacement for Docker. Podman offers several advantages including rootless containers, daemonless architecture, and better security defaults.

## Installation

### macOS
```bash
brew install podman
podman machine init
podman machine start
```

### Linux
```bash
# Fedora/RHEL/CentOS
sudo dnf install podman

# Ubuntu/Debian
sudo apt-get update
sudo apt-get install podman

# Arch Linux
sudo pacman -S podman
```

### Optional: Install podman-compose
```bash
pip3 install podman-compose
# or
brew install podman-compose  # macOS
```

## Configuration

AutoClaude automatically detects Podman and uses it when Docker is not available. No additional configuration is required.

### Rootless Mode (Default)

Podman runs rootless by default, which is more secure:

```bash
# Verify rootless mode
podman info | grep rootless
```

### Using Podman with AutoClaude

1. **Setup**: The setup script automatically detects Podman
   ```bash
   ./scripts/setup.sh
   ```

2. **Building Images**: Works the same as Docker
   ```bash
   cd docker
   podman build -t autoclaude/sandbox:latest .
   # or with podman-compose
   podman-compose build
   ```

3. **Running Containers**: AutoClaude handles the differences automatically
   ```bash
   ./scripts/launch-autonomous.sh "Your project description"
   ```

## Podman-Specific Features

### 1. **Rootless Containers**
- No daemon running as root
- Better security isolation
- User namespace mapping

### 2. **Pod Support**
Create a pod for grouped containers:
```bash
podman pod create --name autoclaude-pod
podman run --pod autoclaude-pod autoclaude/sandbox:latest
```

### 3. **Systemd Integration**
Generate systemd service files:
```bash
podman generate systemd --new --name autoclaude-dev > ~/.config/systemd/user/autoclaude.service
systemctl --user enable autoclaude.service
```

### 4. **SELinux Support**
Podman handles SELinux contexts automatically. If you encounter issues:
```bash
# Add :Z flag to volumes for automatic relabeling
-v /path/to/data:/data:Z
```

## Differences from Docker

### Command Compatibility
Most Docker commands work identically:
```bash
# Docker
docker run -it ubuntu bash

# Podman (identical)
podman run -it ubuntu bash
```

### Compose Support
```bash
# Using podman-compose
podman-compose up -d

# Using podman directly with compose file
podman play kube docker-compose.yml
```

### Registry Configuration
Podman uses `/etc/containers/registries.conf`:
```toml
unqualified-search-registries = ["docker.io", "quay.io"]
```

## Troubleshooting

### 1. **Permission Issues**
```bash
# Fix storage permissions
podman unshare chown -R $UID:$GID ~/.local/share/containers/storage
```

### 2. **Network Issues**
```bash
# Reset Podman networking
podman system reset
```

### 3. **Volume Mounting on macOS**
```bash
# Ensure Podman machine has access
podman machine ssh
sudo mkdir -p /Users
sudo mount -t 9p -o trans=virtio,version=9p2000.L,msize=512000 host-mount /Users
```

### 4. **Compose Compatibility**
If podman-compose has issues, use the Podman-specific compose file:
```bash
podman-compose -f docker/podman-compose.yml up
```

## Environment Variables

Set these in your `.env` file:

```bash
# Force Podman usage even if Docker is available
AUTOCLAUDE_CONTAINER_RUNTIME=podman

# Podman-specific options
PODMAN_USERNS=keep-id
PODMAN_CPUS=2
PODMAN_MEMORY=4g
```

## Best Practices

1. **Use Fully Qualified Image Names**
   ```bash
   # Good
   docker.io/library/ubuntu:latest
   
   # May require registry configuration
   ubuntu:latest
   ```

2. **Rootless Considerations**
   - Ports below 1024 require special configuration
   - Use `podman unshare` for permission fixes
   - Volume permissions may need adjustment

3. **Resource Limits**
   ```bash
   # Set in containers.conf
   [containers]
   pids_limit = 2048
   ```

4. **Security**
   - Podman runs without root by default
   - Each container has its own user namespace
   - SELinux policies are enforced

## Migration from Docker

To migrate existing Docker workflows:

1. **Export Docker images**:
   ```bash
   docker save autoclaude/sandbox:latest | podman load
   ```

2. **Convert docker-compose.yml**:
   - Most compose files work without changes
   - Use `podman-compose` for compatibility

3. **Update scripts** (AutoClaude does this automatically):
   - Replace `docker` with `podman`
   - Adjust volume mount flags if needed

## Performance Tuning

```bash
# Increase Podman resources on macOS
podman machine stop
podman machine set --cpus 4 --memory 8192
podman machine start

# Configure storage driver
# Edit ~/.config/containers/storage.conf
[storage]
driver = "overlay"
```

## Additional Resources

- [Podman Documentation](https://docs.podman.io/)
- [Podman vs Docker](https://podman.io/whatis.html)
- [Rootless Containers](https://rootlesscontaine.rs/)
- [Podman Compose](https://github.com/containers/podman-compose)