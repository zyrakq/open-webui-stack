#!/bin/bash

# Запуск docker-compose с основным файлом, файлом прокси, файлом OpenAI Edge TTS, OpenedAI Speech и dev-конфигурацией
docker-compose -f docker-compose.yml -f docker-compose.proxy.yml -f docker-compose.openedai-speech.yml -f docker-compose.dev.yml up -d --build
