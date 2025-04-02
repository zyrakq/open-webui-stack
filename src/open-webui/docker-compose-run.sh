#!/bin/bash

# Запуск docker-compose с основным файлом, файлом прокси и файлом audio
docker-compose -f docker-compose.yml -f docker-compose.proxy.yml -f docker-compose.audio.yml up -d --build
