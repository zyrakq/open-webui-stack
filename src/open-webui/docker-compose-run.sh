#!/bin/bash

# Запуск docker-compose с основным файлом, файлом прокси, файлом audio и dev-конфигурацией
docker-compose -f docker-compose.yml -f docker-compose.proxy.yml -f docker-compose.audio.yml -f docker-compose.dev.yml up -d --build
