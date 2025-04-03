# OpenedAI Speech Integration

Этот проект предоставляет интеграцию `openedai-speech` с поддержкой NVIDIA GPU и кастомными голосами.

## Настройка

Обновите файл `config/voice_to_speaker.yaml`, добавив пути к вашим аудиофайлам.

## Запуск

Для запуска используйте команду:

```bash
docker-compose up -d
```

Сервис будет доступен по адресу `http://localhost:8000`.

## Подключение NVIDIA GPU

Для использования NVIDIA GPU убедитесь, что установлен [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html). Конфигурация GPU уже включена в `docker-compose.yml`.

## Пример использования

Пример запроса для генерации речи:

```bash
curl -X POST http://localhost:8000/v1/audio/speech \
  -H "Content-Type: application/json" \
  -d '{
    "input": "Пример текста для преобразования в речь.",
    "voice": "custom_voice_1",
    "response_format": "mp3"
  }' --output speech.mp3
```
