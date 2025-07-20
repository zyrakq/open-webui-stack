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
│   │   ├── keycloak/
│   │   │   ├── docker-compose.yml          # Keycloak OAuth2/OIDC
│   │   │   └── .env.example                # Keycloak variables
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
│   │   ├── keycloak/                       # DevContainer + Keycloak
│   │   ├── openai-edge-tts/                # DevContainer + OpenAI Edge TTS
│   │   ├── openedai-speech/                # DevContainer + OpenedAI Speech
│   │   ├── keycloak+openai-edge-tts/       # DevContainer + Keycloak + OpenAI Edge TTS
│   │   └── keycloak+openedai-speech/       # DevContainer + Keycloak + OpenedAI Speech
│   ├── letsencrypt/
│   │   ├── base/                           # Let's Encrypt + base
│   │   ├── keycloak/                       # Let's Encrypt + Keycloak
│   │   ├── openai-edge-tts/                # Let's Encrypt + OpenAI Edge TTS
│   │   ├── openedai-speech/                # Let's Encrypt + OpenedAI Speech
│   │   ├── keycloak+openai-edge-tts/       # Let's Encrypt + Keycloak + OpenAI Edge TTS
│   │   └── keycloak+openedai-speech/       # Let's Encrypt + Keycloak + OpenedAI Speech
│   └── step-ca/
│       ├── base/                           # Step CA + base
│       ├── keycloak/                       # Step CA + Keycloak
│       ├── openai-edge-tts/                # Step CA + OpenAI Edge TTS
│       ├── openedai-speech/                # Step CA + OpenedAI Speech
│       ├── keycloak+openai-edge-tts/       # Step CA + Keycloak + OpenAI Edge TTS
│       └── keycloak+openedai-speech/       # Step CA + Keycloak + OpenedAI Speech
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

# For production with Let's Encrypt + Keycloak + OpenAI Edge TTS
cd build/letsencrypt/keycloak+openai-edge-tts/
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

## 🔧 Available Configurations

### Environments

- **devcontainer**: Development environment with workspace network
- **letsencrypt**: Production with Let's Encrypt SSL certificates
- **step-ca**: Production with Step CA SSL certificates

### Extensions

- **keycloak**: Keycloak OAuth2/OIDC authentication integration
- **openai-edge-tts**: OpenAI Edge TTS integration
- **openedai-speech**: OpenedAI Speech integration

### Generated Combinations

#### Single Extensions

Each environment can be combined with any single extension:

- `devcontainer/base` - Basic development setup
- `devcontainer/keycloak` - Development with Keycloak authentication
- `devcontainer/openai-edge-tts` - Development with OpenAI Edge TTS
- `devcontainer/openedai-speech` - Development with OpenedAI Speech
- `letsencrypt/base` - Production with Let's Encrypt
- `letsencrypt/keycloak` - Production with Let's Encrypt + Keycloak authentication
- `letsencrypt/openai-edge-tts` - Production with Let's Encrypt + OpenAI Edge TTS
- `letsencrypt/openedai-speech` - Production with Let's Encrypt + OpenedAI Speech
- `step-ca/base` - Production with Step CA
- `step-ca/keycloak` - Production with Step CA + Keycloak authentication
- `step-ca/openai-edge-tts` - Production with Step CA + OpenAI Edge TTS
- `step-ca/openedai-speech` - Production with Step CA + OpenedAI Speech

#### Extension Combinations

When [`extensions.yml`](extensions.yml) is present, additional combinations are generated:

- `devcontainer/keycloak+openai-edge-tts` - Development with Keycloak + OpenAI Edge TTS
- `devcontainer/keycloak+openedai-speech` - Development with Keycloak + OpenedAI Speech
- `letsencrypt/keycloak+openai-edge-tts` - Production with Let's Encrypt + Keycloak + OpenAI Edge TTS
- `letsencrypt/keycloak+openedai-speech` - Production with Let's Encrypt + Keycloak + OpenedAI Speech
- `step-ca/keycloak+openai-edge-tts` - Production with Step CA + Keycloak + OpenAI Edge TTS
- `step-ca/keycloak+openedai-speech` - Production with Step CA + Keycloak + OpenedAI Speech

**Note**: TTS extensions (openai-edge-tts and openedai-speech) are mutually exclusive and cannot be combined together.

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

### Keycloak Configuration

- `ENABLE_OAUTH_SIGNUP`: Enable OAuth2/OIDC login (default: true)
- `OAUTH_CLIENT_ID`: Keycloak client ID for Open WebUI
- `OAUTH_CLIENT_SECRET`: Keycloak client secret
- `OPENID_PROVIDER_URL`: OIDC discovery document URL
- `OAUTH_PROVIDER_NAME`: SSO button label (default: Keycloak)
- `OPENID_REDIRECT_URI`: OAuth callback URL

For detailed setup instructions, see: [Keycloak Integration](https://docs.openwebui.com/features/sso/keycloak)

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
      - keycloak

# Valid combinations
combinations:
  - name: "keycloak+openai-edge-tts"
    extensions: ["keycloak", "openai-edge-tts"]
    description: "Authentication with OpenAI Edge TTS"
  
  - name: "keycloak+openedai-speech"
    extensions: ["keycloak", "openedai-speech"]
    description: "Authentication with OpenedAI Speech"
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
  - name: "keycloak+prometheus"
    extensions: ["keycloak", "prometheus"]
    description: "Authentication with monitoring"
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
