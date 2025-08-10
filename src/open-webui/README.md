# 🌐 Open WebUI

A modular Docker Compose configuration system for Open WebUI with support for multiple environments and extensions.

## 🏗️ Project Structure

```sh
src/open-webui/
├── components/                              # Source compose components
│   ├── base/                               # Base components
│   │   ├── docker-compose.yml              # Main Open WebUI service
│   │   └── .env.example                    # Base environment variables
│   ├── environments/                       # Environment components
│   │   ├── devcontainer/
│   │   │   ├── docker-compose.yml          # DevContainer environment
│   │   │   └── .env.example                # DevContainer variables
│   │   ├── letsencrypt/
│   │   │   ├── docker-compose.yml          # Let's Encrypt SSL
│   │   │   └── .env.example                # Let's Encrypt variables
│   │   └── step-ca/
│   │       ├── docker-compose.yml          # Step CA SSL
│   │       └── .env.example                # Step CA variables
│   ├── extensions/                         # Extension components
│   │   ├── oidc/
│   │   │   ├── docker-compose.yml          # OIDC authentication
│   │   │   └── .env.example                # OIDC variables
│   │   ├── openai-edge-tts/
│   │   │   ├── docker-compose.yml          # OpenAI Edge TTS
│   │   │   └── .env.example                # OpenAI Edge TTS variables
│   │   └── openedai-speech/
│   │       ├── docker-compose.yml          # OpenedAI Speech
│   │       └── .env.example                # OpenedAI Speech variables
├── extensions.yml                          # Extension compatibility configuration
├── build/                        # Generated configurations (auto-generated)
│   ├── devcontainer/
│   │   ├── base/                           # DevContainer + base
│   │   ├── oidc/                           # DevContainer + OIDC
│   │   ├── openai-edge-tts/                # DevContainer + OpenAI Edge TTS
│   │   ├── openedai-speech/                # DevContainer + OpenedAI Speech
│   │   ├── step-ca-trust/                  # DevContainer + Step CA trust
│   │   ├── oidc+step-ca-trust/             # DevContainer + OIDC + Step CA trust
│   │   ├── oidc+openai-edge-tts/           # DevContainer + OIDC + OpenAI Edge TTS
│   │   ├── oidc+openedai-speech/           # DevContainer + OIDC + OpenedAI Speech
│   │   ├── oidc+openai-edge-tts+step-ca-trust/  # DevContainer + OIDC + OpenAI Edge TTS + Step CA trust
│   │   └── oidc+openedai-speech+step-ca-trust/  # DevContainer + OIDC + OpenedAI Speech + Step CA trust
│   ├── letsencrypt/
│   │   ├── base/                           # Let's Encrypt + base
│   │   ├── oidc/                           # Let's Encrypt + OIDC
│   │   ├── openai-edge-tts/                # Let's Encrypt + OpenAI Edge TTS
│   │   ├── openedai-speech/                # Let's Encrypt + OpenedAI Speech
│   │   ├── step-ca-trust/                  # Let's Encrypt + Step CA trust
│   │   ├── oidc+step-ca-trust/             # Let's Encrypt + OIDC + Step CA trust
│   │   ├── oidc+openai-edge-tts/           # Let's Encrypt + OIDC + OpenAI Edge TTS
│   │   ├── oidc+openedai-speech/           # Let's Encrypt + OIDC + OpenedAI Speech
│   │   ├── oidc+openai-edge-tts+step-ca-trust/  # Let's Encrypt + OIDC + OpenAI Edge TTS + Step CA trust
│   │   └── oidc+openedai-speech+step-ca-trust/  # Let's Encrypt + OIDC + OpenedAI Speech + Step CA trust
│   └── step-ca/
│       ├── base/                           # Step CA + base
│       ├── oidc/                           # Step CA + OIDC
│       ├── openai-edge-tts/                # Step CA + OpenAI Edge TTS
│       ├── openedai-speech/                # Step CA + OpenedAI Speech
│       ├── oidc+step-ca-trust/             # Step CA + OIDC + Step CA trust
│       ├── oidc+openai-edge-tts/           # Step CA + OIDC + OpenAI Edge TTS
│       └── oidc+openedai-speech/           # Step CA + OIDC + OpenedAI Speech
├── build.sh                      # Build script
└── README.md                     # This file
```

## 🚀 Quick Start

### 1. Build Configurations

Run the build script to generate all possible combinations:

```bash
./build.sh
```

This will create all combinations in the `build/` directory.

### 2. Choose Your Configuration

Navigate to the desired configuration directory:

```bash
# For development with DevContainer
cd build/devcontainer/base/

# For production with Let's Encrypt SSL
cd build/letsencrypt/base/

# For production with Let's Encrypt + OpenedAI Speech
cd build/letsencrypt/openedai-speech/

# For production with Let's Encrypt + OIDC + OpenAI Edge TTS
cd build/letsencrypt/oidc+openai-edge-tts/

# For production with Step CA + OIDC + Step CA trust
cd build/step-ca/oidc+step-ca-trust/

# For production with Step CA + Step CA trust
cd build/step-ca/step-ca-trust/

# For production with Let's Encrypt + OIDC + OpenAI Edge TTS + Step CA trust
cd build/letsencrypt/oidc+openai-edge-tts+step-ca-trust/
```

### 3. Configure Environment

Copy and edit the environment file:

```bash
cp .env.example .env
# Edit .env with your values
```

### 4. Deploy

Start the services:

```bash
docker-compose up -d
```

## 🗄️ Database Management

### Copying and Updating Database

For manual operations like linking existing accounts with SSO accounts, you can copy the database from the container, modify it, and copy it back:

```bash
# Copy database from container to host
docker cp open-webui:/app/backend/data/webui.db .

# After making changes to the database file
docker cp webui.db open-webui:/app/backend/data/webui.db
```

**Important**: After updating the database, restart the container for changes to take effect:

```bash
docker-compose restart open-webui
```

## 🔧 Available Configurations

### Environments

- **devcontainer**: Development environment with workspace network
- **letsencrypt**: Production with Let's Encrypt SSL certificates
- **step-ca**: Production with Step CA SSL certificates

### Extensions

- **oidc**: OAuth2/OIDC authentication integration
- **openai-edge-tts**: OpenAI Edge TTS integration
- **openedai-speech**: OpenedAI Speech integration
- **step-ca-trust**: Step CA certificate trust integration

### Generated Combinations

#### Single Extensions

Each environment can be combined with any single extension:

- `devcontainer/base` - Basic development setup
- `devcontainer/oidc` - Development with OIDC authentication
- `devcontainer/openai-edge-tts` - Development with OpenAI Edge TTS
- `devcontainer/openedai-speech` - Development with OpenedAI Speech
- `devcontainer/step-ca-trust` - Development with Step CA certificate trust
- `letsencrypt/base` - Production with Let's Encrypt
- `letsencrypt/oidc` - Production with Let's Encrypt + OIDC authentication
- `letsencrypt/openai-edge-tts` - Production with Let's Encrypt + OpenAI Edge TTS
- `letsencrypt/openedai-speech` - Production with Let's Encrypt + OpenedAI Speech
- `letsencrypt/step-ca-trust` - Production with Let's Encrypt + Step CA certificate trust
- `step-ca/base` - Production with Step CA
- `step-ca/oidc` - Production with Step CA + OIDC authentication
- `step-ca/openai-edge-tts` - Production with Step CA + OpenAI Edge TTS
- `step-ca/openedai-speech` - Production with Step CA + OpenedAI Speech

#### Extension Combinations

When [`extensions.yml`](extensions.yml) is present, additional combinations are generated:

- `devcontainer/oidc+step-ca-trust` - Development with OIDC + Step CA trust
- `devcontainer/oidc+openai-edge-tts` - Development with OIDC + OpenAI Edge TTS
- `devcontainer/oidc+openedai-speech` - Development with OIDC + OpenedAI Speech
- `devcontainer/oidc+openai-edge-tts+step-ca-trust` - Development with OIDC + OpenAI Edge TTS + Step CA trust
- `devcontainer/oidc+openedai-speech+step-ca-trust` - Development with OIDC + OpenedAI Speech + Step CA trust
- `letsencrypt/oidc+step-ca-trust` - Production with Let's Encrypt + OIDC + Step CA trust
- `letsencrypt/oidc+openai-edge-tts` - Production with Let's Encrypt + OIDC + OpenAI Edge TTS
- `letsencrypt/oidc+openedai-speech` - Production with Let's Encrypt + OIDC + OpenedAI Speech
- `letsencrypt/oidc+openai-edge-tts+step-ca-trust` - Production with Let's Encrypt + OIDC + OpenAI Edge TTS + Step CA trust
- `letsencrypt/oidc+openedai-speech+step-ca-trust` - Production with Let's Encrypt + OIDC + OpenedAI Speech + Step CA trust
- `step-ca/oidc+step-ca-trust` - Production with Step CA + OIDC + Step CA trust
- `step-ca/oidc+openai-edge-tts` - Production with Step CA + OIDC + OpenAI Edge TTS
- `step-ca/oidc+openedai-speech` - Production with Step CA + OIDC + OpenedAI Speech

**Note**: TTS extensions (openai-edge-tts and openedai-speech) are mutually exclusive and cannot be combined together. The step-ca-trust extension can be combined with any other extensions to add Step CA certificate trust to containers.

## 🔧 Environment Variables

### Base Configuration

- `COMPOSE_PROJECT_NAME`: Project name for Docker Compose
- `OPENAI_API_BASE_URL`: OpenAI API base URL
- `OPENAI_API_KEY`: OpenAI API key
- `WEBUI_SECRET_KEY`: Secret key for WebUI
- `WEBUI_DOCKER_TAG`: Docker image tag (default: main)
- `DEFAULT_LOCALE`: Default locale for the interface (default: en)
- `ENABLE_EVALUATION_ARENA_MODELS`: Enable evaluation arena models (default: False)
- `ENABLE_OLLAMA_API`: Enable Ollama API integration (default: False)
- `TASK_MODEL_EXTERNAL`: External task model configuration
- `DEFAULT_MODELS`: Default models for the interface

### Let's Encrypt Configuration

- `VIRTUAL_PORT`: Port for nginx-proxy (default: 8080)
- `VIRTUAL_HOST`: Domain for nginx-proxy
- `LETSENCRYPT_HOST`: Domain for SSL certificate
- `LETSENCRYPT_EMAIL`: Email for certificate registration

### Step CA Configuration

- `VIRTUAL_PORT`: Port for nginx-proxy (default: 8080)
- `VIRTUAL_HOST`: Domain for nginx-proxy
- `LETSENCRYPT_HOST`: Domain for SSL certificate
- `LETSENCRYPT_EMAIL`: Email for certificate registration

### OpenAI Edge TTS Configuration

- `AUDIO_TTS_OPENAI_API_BASE_URL`: OpenAI Edge TTS API URL
- `AUDIO_TTS_OPENAI_API_KEY`: API key for OpenAI Edge TTS
- `AUDIO_TTS_ENGINE`: Text-to-Speech engine
- `AUDIO_TTS_VOICE`: Default voice for TTS
- `WHISPER_MODEL`: Whisper model for audio processing

### OpenedAI Speech Configuration

- `AUDIO_TTS_ENGINE`: Text-to-Speech engine
- `AUDIO_TTS_OPENAI_API_BASE_URL`: OpenedAI Speech API URL
- `AUDIO_TTS_API_KEY`: API key (dummy value)
- `AUDIO_TTS_VOICE`: Default voice for TTS

### OIDC Configuration

- `ENABLE_OAUTH_SIGNUP`: Enable OAuth2/OIDC login (default: true)
- `OAUTH_CLIENT_ID`: OIDC client ID for Open WebUI
- `OAUTH_CLIENT_SECRET`: OIDC client secret
- `OPENID_PROVIDER_URL`: OIDC discovery document URL
- `OAUTH_PROVIDER_NAME`: SSO button label (default: OIDC)
- `OPENID_REDIRECT_URI`: OAuth callback URL

For detailed setup instructions, see: [OIDC Integration](https://docs.openwebui.com/features/sso/)

### Step CA Trust Configuration

- `STEP_CA_TRUST`: Enable Step CA certificate trust (default: true)
- `STEP_CA_TRUST_RESTART`: Restart container when trust configuration changes (default: true)
- `REQUESTS_CA_BUNDLE`: Path to CA bundle for Python requests library (default: /etc/ssl/certs/ca-certificates.crt)
- `SSL_CERT_FILE`: Path to SSL certificate file for SSL verification (default: /etc/ssl/certs/ca-certificates.crt)

The step-ca-trust extension automatically configures containers to trust certificates issued by Step CA, enabling secure communication with Step CA-protected services. The `REQUESTS_CA_BUNDLE` and `SSL_CERT_FILE` environment variables ensure that Python applications and SSL libraries use the correct certificate bundle that includes Step CA certificates.

## 🔗 Extension Combinations

### Configuration File

Extension combinations are configured via [`extensions.yml`](extensions.yml). This file defines:

- **Groups**: Extensions that conflict with each other (e.g., TTS services)
- **Combinations**: Valid extension combinations to generate
- **Compatibility**: Rules for which extensions can work together

### Example Configuration

```yaml
# Extension compatibility configuration
version: "1.0"

# Extension groups - extensions in same group conflict with each other
groups:
  tts:
    description: "Text-to-Speech services (mutually exclusive)"
    extensions:
      - openai-edge-tts
      - openedai-speech
  
  auth:
    description: "Authentication services"
    extensions:
      - oidc

  step-ca:
    description: "Step CA certificate trust"
    extensions:
      - step-ca-trust

# Valid combinations
combinations:
  - name: "oidc+openai-edge-tts"
    extensions: ["oidc", "openai-edge-tts"]
    description: "Authentication with OpenAI Edge TTS"
  
  - name: "oidc+openedai-speech"
    extensions: ["oidc", "openedai-speech"]
    description: "Authentication with OpenedAI Speech"

  - name: "oidc+step-ca-trust"
    extensions: ["oidc", "step-ca-trust"]
    description: "Authentication with Step CA trust"

  - name: "oidc+openai-edge-tts+step-ca-trust"
    extensions: ["oidc", "openai-edge-tts", "step-ca-trust"]
    description: "Authentication with OpenAI Edge TTS and Step CA trust"
  
  - name: "oidc+openedai-speech+step-ca-trust"
    extensions: ["oidc", "openedai-speech", "step-ca-trust"]
    description: "Authentication with OpenedAI Speech and Step CA trust"
```

### Backward Compatibility

- **Without `extensions.yml`**: Only single extensions are generated (legacy behavior)
- **With `extensions.yml`**: Both single extensions and combinations are generated
- **Existing configurations**: Remain unchanged and fully compatible

## 🛠️ Development

### Adding New Components

1. **New Environment**: Create directory in `components/environments/` with `docker-compose.yml` and optional `.env.example` file
2. **New Extension**: Create directory in `components/extensions/` with `docker-compose.yml` and optional `.env.example` file
3. **Update Combinations**: Add new extension to [`extensions.yml`](extensions.yml) if it should be part of combinations
4. **Rebuild**: Run `./build.sh` to generate new combinations

### Adding Extension Combinations

1. **Edit Configuration**: Modify [`extensions.yml`](extensions.yml)
2. **Define Groups**: Add extensions to appropriate groups if they conflict
3. **Add Combinations**: Specify valid extension combinations
4. **Rebuild**: Run `./build.sh` to generate new combinations

Example of adding a new extension to combinations:

```yaml
# Add to existing group or create new group
groups:
  monitoring:
    description: "Monitoring services"
    extensions:
      - prometheus
      - grafana

# Add new combinations
combinations:
  - name: "oidc+prometheus"
    extensions: ["oidc", "prometheus"]
    description: "Authentication with monitoring"
  
  - name: "oidc+prometheus+step-ca-trust"
    extensions: ["oidc", "prometheus", "step-ca-trust"]
    description: "Authentication with monitoring and Step CA trust"
```

### File Naming Convention

All component files follow the standard Docker Compose naming convention (`docker-compose.yml`) for:

- **VS Code compatibility**: Full support for Docker Compose language features and IntelliSense
- **IDE integration**: Proper syntax highlighting and validation in all major editors
- **Tool compatibility**: Works with Docker Compose plugins and extensions
- **Standard compliance**: Follows official Docker Compose file naming patterns

### Modifying Existing Components

1. Edit the component files in `components/`
2. Run `./build.sh` to regenerate configurations
3. The `build/` directory will be completely recreated

## 📝 Notes

- The `build/` directory is automatically generated and should not be edited manually
- Environment variables in generated files use `$VARIABLE_NAME` format for proper interpolation
- Each generated configuration includes a complete `docker-compose.yml` and `.env.example`
- Missing `.env.*` files for components are handled gracefully by the build script
- Extension combinations are only generated when [`extensions.yml`](extensions.yml) exists
- The build script maintains full backward compatibility - existing workflows continue to work unchanged
- Extension conflicts are automatically validated during the build process
- User `.env` files are preserved during rebuilds
