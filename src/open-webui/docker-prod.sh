#!/bin/bash

# Запуск docker-compose с основным файлом, OpenedAI Speech и prod-конфигурацией
docker-compose -f docker-compose.yml -f docker-compose.openedai-speech.yml -f docker-compose.cert.yml up -d --build
