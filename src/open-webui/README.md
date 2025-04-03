# Open WebUI

## Переменные среды

### Общие переменные среды

Эти переменные используются всеми конфигурациями:

- `OPENAI_API_BASE_URL`: URL API для взаимодействия с OpenAI API.
- `OPENAI_API_KEY`: Ключ API для аутентификации запросов к OpenAI API.
- `TASK_MODEL_EXTERNAL`: Внешняя модель для задач (например, `google/gemini-2.5-pro-exp-03-25:free`).
- `DEFAULT_MODELS`: Модели, используемые по умолчанию (например, `gemini-2.5-pro-exp-03-25:free`).
- `DEFAULT_LOCALE`: Локаль по умолчанию (например, `ru`).
- `ENABLE_EVALUATION_ARENA_MODELS`: Включить ли модели для оценки (например, `False`).
- `ENABLE_OLLAMA_API`: Включить ли API Ollama (например, `False`).
- `WEBUI_SECRET_KEY`: Секретный ключ для WebUI.

### Переменные среды для OpenAI Edge TTS

Эти переменные используются в конфигурации `docker-compose.openai-edge-tts.yml`:

- `AUDIO_TTS_OPENAI_API_BASE_URL`: URL API для взаимодействия с сервисом OpenAI Edge TTS (например, `http://openai-edge-tts:5050`).
- `AUDIO_TTS_OPENAI_API_KEY`: Ключ API для аутентификации запросов к OpenAI Edge TTS.
- `AUDIO_TTS_ENGINE`: Движок Text-to-Speech, используемый по умолчанию (например, `openai`).
- `AUDIO_TTS_VOICE`: Голос, используемый по умолчанию (например, `ru-RU-DmitryNeural`).
- `WHISPER_MODEL`: Модель Whisper, используемая для обработки аудио (например, `medium`).

## Конфигурация Docker Compose

- Основной файл конфигурации: `docker-compose.yml`
- Dev-конфигурация (для разработки): `docker-compose.dev.yml`
  - Добавляет сеть `open-webui-workspace-network` для взаимодействия с внешними сервисами в dev-среде.
- Конфигурация OpenAI Edge TTS: `docker-compose.openai-edge-tts.yml`
  - Содержит переменные среды и настройки для интеграции OpenAI Edge TTS.

## Запуск

Используйте скрипт `docker-compose-run.sh` для запуска всех сервисов:
```bash
./docker-compose-run.sh
```

Убедитесь, что вы указали корректные значения для всех переменных среды в соответствующих файлах конфигурации Docker Compose.
