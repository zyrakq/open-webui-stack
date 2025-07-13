# 🎤 OpenAI Edge TTS

This project provides a container for using OpenAI Edge TTS. Below is a description of the environment variables used in `docker-compose.yml`:

## 🔧 Environment Variables

- `TZ`: Container timezone (e.g., `UTC`).
- `API_KEY`: API key for request authentication.
- `PORT`: Port on which the service runs (default `5050`).
- `DEFAULT_VOICE`: Default voice used (e.g., `ru-RU-DmitryNeural`).
- `DEFAULT_RESPONSE_FORMAT`: Response format (e.g., `mp3`).
- `DEFAULT_SPEED`: Speech speed (e.g., `1.0`).
- `DEFAULT_LANGUAGE`: Default language used (e.g., `ru-RU`).
- `REQUIRE_API_KEY`: Whether to require API key for requests (`True` or `False`).
- `REMOVE_FILTER`: Whether to remove filters (e.g., `False`).
- `EXPAND_API`: Whether to expand API for additional capabilities (`True` or `False`).

## 🚀 Running

To start the service, use the command:

```sh
docker-compose up -d
```

Make sure you specify correct values for environment variables in `docker-compose.yml`.
