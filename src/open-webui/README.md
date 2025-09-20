# 🌐 Open WebUI

A modular Docker Compose configuration system for Open WebUI with support for multiple environments and extensions.

## 🚀 Quick Start

### 1. Build Configurations

Generate all configurations using [stackbuilder](https://github.com/zyrakq/stackbuilder):

```bash
sb build
```

This creates ready-to-use Docker Compose configurations in the `build/` directory.

### 2. Deploy

Navigate to your chosen configuration and deploy:

```bash
# Example: deploy with Let's Encrypt SSL and OIDC
cd build/letsencrypt/oidc/
cp .env.example .env
# Edit .env with your values
docker compose up --build -d
```

## 📁 Project Structure

- **`components/`** - Source Docker Compose components
  - `base/` - Core Open WebUI service
  - `environments/` - Environment configurations (devcontainer, letsencrypt, step-ca)
  - `extensions/` - Extension components (oidc, tts services, step-ca-trust)
- **`build/`** - Generated configurations (created by `sb build`)
- **`stackbuilder.toml`** - Build configuration for stackbuilder

## 🔧 Available Configurations

### Environments

- **devcontainer** - Development environment with workspace network
- **letsencrypt** - Production with Let's Encrypt SSL certificates
- **step-ca** - Production with Step CA SSL certificates

### Extensions

- **oidc** - OAuth2/OIDC authentication integration
- **openai-edge-tts** - OpenAI Edge TTS integration
- **openedai-speech** - OpenedAI Speech integration
- **step-ca-trust** - Step CA certificate trust integration

Generated combinations are available in the `build/` directory after running `sb build`.

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

## 🗄️ Database Management

For manual database operations:

```bash
# Copy database from container to host
docker cp open-webui:/app/backend/data/webui.db .

# After making changes to the database file
docker cp webui.db open-webui:/app/backend/data/webui.db
docker compose restart open-webui
```

## 🛠️ Development

### Adding New Components

1. **New Environment**: Create directory in `components/environments/` with `docker-compose.yml` and optional `.env.example`
2. **New Extension**: Create directory in `components/extensions/` with `docker-compose.yml` and optional `.env.example`
3. **Update Configuration**: Modify [`stackbuilder.toml`](stackbuilder.toml) to include new components
4. **Rebuild**: Run `sb build` to regenerate configurations

### Modifying Components

1. Edit files in `components/`
2. Run `sb build` to regenerate all configurations
3. The `build/` directory will be completely recreated

## 📝 Notes

- The `build/` directory is automatically generated - do not edit manually
- User `.env` files are preserved during rebuilds
- All configurations are built from [`stackbuilder.toml`](stackbuilder.toml) specification
- Extension conflicts and combinations are managed via stackbuilder configuration
