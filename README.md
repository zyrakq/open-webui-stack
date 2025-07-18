# 🐳 Open WebUI Docker Stack

This project contains a collection of Docker configurations and compose files for running Open WebUI and related services.

## 🧩 Components

### 🔐 SSL Automation

#### [🔒 Let's Encrypt Manager](src/ssl-automation/letsencrypt-manager)

Automatic SSL certificate management from Let's Encrypt for production deployments. Provides seamless HTTPS integration for Docker containers using nginx-proxy and acme-companion.
[Learn more about Let's Encrypt Manager configuration](src/ssl-automation/letsencrypt-manager/README.md).

#### [🏠 Step CA Manager](src/ssl-automation/step-ca-manager)

Local domain stack with trusted self-signed certificates for virtual network deployments. Includes private CA management and local DNS resolution for development environments.
[Learn more about Step CA Manager configuration](src/ssl-automation/step-ca-manager/README.md).

## � Services

### [🌐 Open WebUI](src/open-webui)

Open WebUI — the main service providing a user interface for AI interactions.  
[Learn more about Open WebUI configuration](src/open-webui/README.md).

### [🗣️ Text-to-Speech](src/text-to-speech)

Text-to-Speech — services for converting text to speech with various TTS engines.  
[Learn more about Text-to-Speech configuration](src/text-to-speech/README.md).

## 🚀 Getting Started

To run the services, use the appropriate `docker-compose.yml` files in the subprojects. Make sure all environment variables are configured correctly.

Each service directory contains:

- 📋 Docker Compose configurations
- 🔧 Environment variable examples
- 📖 Detailed setup instructions
- 🛠️ Helper scripts for development and production

## 🏗️ Project Structure

```sh
├── src/
│   ├── ssl-automation/      # SSL certificate automation
│   │   ├── letsencrypt-manager/ # Let's Encrypt SSL certificate management
│   │   └── step-ca-manager/     # Local CA and trusted certificates
│   ├── open-webui/          # Main Open WebUI service configs
│   └── text-to-speech/      # TTS service configurations
│       ├── openai-edge-tts/ # OpenAI Edge TTS setup
│       └── openedai-speech/ # OpenedAI Speech setup
```

## 📄 License

This project is dual-licensed under:

- [Apache License 2.0](LICENSE-APACHE)
- [MIT License](LICENSE-MIT)
