# 🌐 Open WebUI

A modular Docker Compose configuration system for Open WebUI with support for multiple environments and extensions.

## 🏗️ Project Structure

```sh
src/open-webui/
├── components/                              # Source compose components
│   ├── base/                               # Base components
│   │   ├── docker-compose.base.yml         # Main Open WebUI service
│   │   └── .env.base                       # Base environment variables
│   ├── environments/                       # Environment components
│   │   ├── docker-compose.devcontainer.yml # DevContainer environment
│   │   ├── docker-compose.letsencrypt.yml  # Let's Encrypt SSL
│   │   ├── docker-compose.step-ca.yml      # Step CA SSL
│   │   ├── .env.letsencrypt                # Let's Encrypt variables
│   │   └── .env.step-ca                    # Step CA variables
│   └── extensions/                         # Extension components
│       ├── docker-compose.openai-edge-tts.yml   # OpenAI Edge TTS
│       ├── docker-compose.openedai-speech.yml   # OpenedAI Speech
│       ├── .env.openai-edge-tts            # OpenAI Edge TTS variables
│       └── .env.openedai-speech            # OpenedAI Speech variables
├── build/                        # Generated configurations (auto-generated)
│   ├── devcontainer/
│   │   ├── base/                 # DevContainer + base
│   │   ├── openai-edge-tts/      # DevContainer + OpenAI Edge TTS
│   │   └── openedai-speech/      # DevContainer + OpenedAI Speech
│   ├── letsencrypt/
│   │   ├── base/                 # Let's Encrypt + base
│   │   ├── openai-edge-tts/      # Let's Encrypt + OpenAI Edge TTS
│   │   └── openedai-speech/      # Let's Encrypt + OpenedAI Speech
│   └── step-ca/
│       ├── base/                 # Step CA + base
│       ├── openai-edge-tts/      # Step CA + OpenAI Edge TTS
│       └── openedai-speech/      # Step CA + OpenedAI Speech
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

- **openai-edge-tts**: OpenAI Edge TTS integration
- **openedai-speech**: OpenedAI Speech integration

### Generated Combinations

Each environment can be combined with any extension:

- `devcontainer/base` - Basic development setup
- `devcontainer/openai-edge-tts` - Development with OpenAI Edge TTS
- `devcontainer/openedai-speech` - Development with OpenedAI Speech
- `letsencrypt/base` - Production with Let's Encrypt
- `letsencrypt/openai-edge-tts` - Production with Let's Encrypt + OpenAI Edge TTS
- `letsencrypt/openedai-speech` - Production with Let's Encrypt + OpenedAI Speech
- `step-ca/base` - Production with Step CA
- `step-ca/openai-edge-tts` - Production with Step CA + OpenAI Edge TTS
- `step-ca/openedai-speech` - Production with Step CA + OpenedAI Speech

## 🔧 Environment Variables

### Base Configuration

- `COMPOSE_PROJECT_NAME`: Project name for Docker Compose
- `OPENAI_API_BASE_URL`: OpenAI API base URL
- `OPENAI_API_KEY`: OpenAI API key
- `WEBUI_SECRET_KEY`: Secret key for WebUI
- `WEBUI_DOCKER_TAG`: Docker image tag (default: main)

### Let's Encrypt Configuration

- `VIRTUAL_HOST`: Domain for nginx-proxy
- `LETSENCRYPT_HOST`: Domain for SSL certificate
- `LETSENCRYPT_EMAIL`: Email for certificate registration

### Step CA Configuration

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

## 🛠️ Development

### Adding New Components

1. **New Environment**: Add `docker-compose.*.yml` file to `components/environments/` and optional `.env.*` file
2. **New Extension**: Add `docker-compose.*.yml` file to `components/extensions/` and optional `.env.*` file
3. **Rebuild**: Run `./build.sh` to generate new combinations

### File Naming Convention

All component files follow the Docker Compose naming convention (`docker-compose.*.yml`) for:

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
