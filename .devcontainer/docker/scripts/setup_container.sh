#!/usr/bin/env bash

uid=${PUID:-1000}

sudo chown "$uid" /var/run/docker.sock