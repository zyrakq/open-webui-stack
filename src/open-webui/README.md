# Open WebUI

## Переменные среды

- `AUDIO_TTS_OPENAI_API_BASE_URL`: URL API для взаимодействия с сервисом Text-to-Speech (например, `http://openai-edge-tts:5050`).
- `AUDIO_TTS_OPENAI_API_KEY`: Ключ API для аутентификации запросов к Text-to-Speech.
- `AUDIO_TTS_ENGINE`: Движок Text-to-Speech, используемый по умолчанию (например, `openai`).
- `AUDIO_TTS_VOICE`: Голос, используемый по умолчанию (например, `ru-RU-DmitryNeural`).

## Запуск

Для запуска используйте команду:

```sh
docker-compose up -d
```

Убедитесь, что вы указали корректные значения для всех переменных среды в `docker-compose.yml`.
