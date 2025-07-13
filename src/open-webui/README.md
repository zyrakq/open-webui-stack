# 🌐 Open WebUI

## 🔧 Environment Variables

### General Environment Variables

These variables are used by all configurations:

- `OPENAI_API_BASE_URL`: API URL for interacting with OpenAI API.
- `OPENAI_API_KEY`: API key for authenticating requests to OpenAI API.
- `TASK_MODEL_EXTERNAL`: External model for tasks (e.g., `google/gemini-2.5-pro-exp-03-25:free`).
- `DEFAULT_MODELS`: Default models used (e.g., `gemini-2.5-pro-exp-03-25:free`).
- `DEFAULT_LOCALE`: Default locale (e.g., `ru`).
- `ENABLE_EVALUATION_ARENA_MODELS`: Whether to enable evaluation models (e.g., `False`).
- `ENABLE_OLLAMA_API`: Whether to enable Ollama API (e.g., `False`).
- `WEBUI_SECRET_KEY`: Secret key for WebUI.

### Environment Variables for OpenAI Edge TTS

These variables are used in the `docker-compose.openai-edge-tts.yml` configuration:

- `AUDIO_TTS_OPENAI_API_BASE_URL`: API URL for interacting with OpenAI Edge TTS service (e.g., `http://openai-edge-tts:5050`).
- `AUDIO_TTS_OPENAI_API_KEY`: API key for authenticating requests to OpenAI Edge TTS.
- `AUDIO_TTS_ENGINE`: Default Text-to-Speech engine used (e.g., `openai`).
- `AUDIO_TTS_VOICE`: Default voice used (e.g., `ru-RU-DmitryNeural`).
- `WHISPER_MODEL`: Whisper model used for audio processing (e.g., `medium`).

## 🐳 Docker Compose Configuration

- Main configuration file: `docker-compose.yml`
- Dev configuration (for development): `docker-compose.dev.yml`
  - Adds `open-webui-workspace-network` network for interaction with external services in dev environment.
- OpenAI Edge TTS configuration: `docker-compose.openai-edge-tts.yml`
  - Contains environment variables and settings for OpenAI Edge TTS integration.
- OpenedAI Speech configuration: `docker-compose.openedai-speech.yml`

## 🚀 Running

Use the `docker-compose-run.sh` script to start all services:

```bash
./docker-compose-run.sh
```

Make sure you specify correct values for all environment variables in the corresponding Docker Compose configuration files.
