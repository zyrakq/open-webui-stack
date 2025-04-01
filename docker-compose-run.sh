#!/bin/bash

# Запуск docker-compose с основным файлом и файлом прокси
docker-compose -f docker-compose.yml -f docker-compose.proxy.yml up -d --build
