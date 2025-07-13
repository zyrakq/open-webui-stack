#!/bin/bash

# Run docker-compose with main file, OpenedAI Speech and production configuration
docker-compose -f docker-compose.yml -f docker-compose.openedai-speech.yml -f docker-compose.letsencrypt.yml up -d --build
