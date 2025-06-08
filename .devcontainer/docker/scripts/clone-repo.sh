#!/usr/bin/env bash

uid=${PUID:-1000}
gid=${PGID:-1000}

cd "$WORKSPACE_FOLDER" || { echo "Error: Failed to change to project directory"; exit 1; }

# Check if the directory is empty (including hidden files)
if [ -n "$(ls -A)" ]; then
    exit 0
fi

# Change the owner of the current directory
if ! sudo chown -R "$uid:$gid" .; then
    echo "Error: Failed to change the owner of the directory"
    exit 1
fi

# Clone the repository (replace the URL with the desired one)
if ! git clone "$REPO_URL" .; then
    echo "Error: Failed to clone repository"
    exit 1
fi

echo "Success: Repository successfully cloned to current directory"