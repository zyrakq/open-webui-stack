# Open WebUI

## Переменные среды

- `AUDIO_TTS_OPENAI_API_BASE_URL`: URL API для взаимодействия с сервисом Text-to-Speech (например, `http://openai-edge-tts:5050`).
- `AUDIO_TTS_OPENAI_API_KEY`: Ключ API для аутентификации запросов к Text-to-Speech.
- `AUDIO_TTS_ENGINE`: Движок Text-to-Speech, используемый по умолчанию (например, `openai`).
- `AUDIO_TTS_VOICE`: Голос, используемый по умолчанию (например, `ru-RU-DmitryNeural`).

## Конфигурация Docker Compose

- Основной файл конфигурации: `docker-compose.yml`
- Dev-конфигурация (для разработки): `docker-compose.dev.yml`
  - Добавляет сеть `open-webui-workspace-network` для взаимодействия с внешними сервисами в dev-среде.

## Запуск

Используйте скрипт `docker-compose-run.sh` для запуска всех сервисов:
```bash
./docker-compose-run.sh
```

Убедитесь, что вы указали корректные значения для всех переменных среды в `docker-compose.yml`.
