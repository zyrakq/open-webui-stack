#!/usr/bin/env bash

UID=${PUID:-1000}

chown "$UID" /var/run/docker.sock