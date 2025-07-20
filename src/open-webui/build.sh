#!/bin/bash

# Universal Docker Compose Build Script
# Supports modular component architecture with optional extensions and additional files
set -e

COMPONENTS_DIR="components"
BUILD_DIR="build"

# Check for required tools
if ! command -v yq &> /dev/null; then
    echo "Error: yq is required but not installed. Please install yq first."
    echo "Installation: https://github.com/mikefarah/yq#install"
    exit 1
fi

# Check if components directory exists
if [ ! -d "$COMPONENTS_DIR" ]; then
    echo "Error: $COMPONENTS_DIR directory not found!"
    echo "This script should be run from a directory containing a '$COMPONENTS_DIR' folder."
    exit 1
fi

# Check if base components exist
if [ ! -f "$COMPONENTS_DIR/base/docker-compose.yml" ]; then
    echo "Error: Base component not found at $COMPONENTS_DIR/base/docker-compose.yml"
    exit 1
fi

# Function to copy additional files (excluding compose and env files)
copy_additional_files() {
    local src_dir="$1"
    local dest_dir="$2"
    
    if [ -d "$src_dir" ]; then
        # Find all files except docker-compose.yml and .env.example
        find "$src_dir" -type f ! -name "docker-compose.yml" ! -name ".env.example" | while read -r file; do
            # Get relative path from source directory
            rel_path="${file#$src_dir/}"
            dest_file="$dest_dir/$rel_path"
            
            # Create destination directory if needed
            mkdir -p "$(dirname "$dest_file")"
            
            # Copy file
            cp "$file" "$dest_file"
            echo "    Copied: $rel_path"
        done
    fi
}

# Backup existing user .env files
backup_dir="/tmp/build_backup_$$"
echo "Backing up user .env files..."
if [ -d "$BUILD_DIR" ]; then
    mkdir -p "$backup_dir"
    # Find and backup all .env files (not .env.example)
    find "$BUILD_DIR" -name ".env" -type f | while read -r env_file; do
        # Get relative path from build directory
        rel_path="${env_file#$BUILD_DIR/}"
        backup_file="$backup_dir/$rel_path"
        
        # Create backup directory structure
        mkdir -p "$(dirname "$backup_file")"
        
        # Copy .env file to backup
        cp "$env_file" "$backup_file"
        echo "  Backed up: $rel_path"
    done
fi

# Create build directory if it doesn't exist
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Get environments
if [ ! -d "$COMPONENTS_DIR/environments" ]; then
    echo "Error: No environments directory found at $COMPONENTS_DIR/environments"
    exit 1
fi

environments=($(find "$COMPONENTS_DIR/environments" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort))

if [ ${#environments[@]} -eq 0 ]; then
    echo "Error: No environment components found in $COMPONENTS_DIR/environments/"
    exit 1
fi

# Get extensions (optional)
extensions=()
if [ -d "$COMPONENTS_DIR/extensions" ]; then
    extensions=($(find "$COMPONENTS_DIR/extensions" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort))
fi

echo "Found environments: ${environments[*]}"
if [ ${#extensions[@]} -gt 0 ]; then
    echo "Found extensions: ${extensions[*]}"
else
    echo "No extensions found (optional)"
fi

echo "Building configurations..."

# Build base configurations for each environment
for env in "${environments[@]}"; do
    build_dir="$BUILD_DIR/$env/base"
    mkdir -p "$build_dir"
    
    echo "Building: $env/base"
    
    # Merge compose files using yq
    yq eval-all 'select(fileIndex == 0) *+ select(fileIndex == 1)' \
        "$COMPONENTS_DIR/base/docker-compose.yml" \
        "$COMPONENTS_DIR/environments/$env/docker-compose.yml" > "$build_dir/docker-compose.yml"
    
    # Merge env files
    cat "$COMPONENTS_DIR/base/.env.example" > "$build_dir/.env.example"
    [ -f "$COMPONENTS_DIR/environments/$env/.env.example" ] && echo "" >> "$build_dir/.env.example" && cat "$COMPONENTS_DIR/environments/$env/.env.example" >> "$build_dir/.env.example"
    
    # Copy additional files from base
    copy_additional_files "$COMPONENTS_DIR/base" "$build_dir"
    
    # Copy additional files from environment
    copy_additional_files "$COMPONENTS_DIR/environments/$env" "$build_dir"
    
    echo "  Built: $env/base"
done

# Build configurations with extensions (only if extensions exist)
if [ ${#extensions[@]} -gt 0 ]; then
    for env in "${environments[@]}"; do
        for ext in "${extensions[@]}"; do
            build_dir="$BUILD_DIR/$env/$ext"
            mkdir -p "$build_dir"
            
            echo "Building: $env/$ext"
            
            # Merge compose files using yq
            yq eval-all 'select(fileIndex == 0) *+ select(fileIndex == 1) *+ select(fileIndex == 2)' \
                "$COMPONENTS_DIR/base/docker-compose.yml" \
                "$COMPONENTS_DIR/environments/$env/docker-compose.yml" \
                "$COMPONENTS_DIR/extensions/$ext/docker-compose.yml" > "$build_dir/docker-compose.yml"
            
            # Merge env files
            cat "$COMPONENTS_DIR/base/.env.example" > "$build_dir/.env.example"
            [ -f "$COMPONENTS_DIR/environments/$env/.env.example" ] && echo "" >> "$build_dir/.env.example" && cat "$COMPONENTS_DIR/environments/$env/.env.example" >> "$build_dir/.env.example"
            [ -f "$COMPONENTS_DIR/extensions/$ext/.env.example" ] && echo "" >> "$build_dir/.env.example" && cat "$COMPONENTS_DIR/extensions/$ext/.env.example" >> "$build_dir/.env.example"
            
            # Copy additional files from base
            copy_additional_files "$COMPONENTS_DIR/base" "$build_dir"
            
            # Copy additional files from environment
            copy_additional_files "$COMPONENTS_DIR/environments/$env" "$build_dir"
            
            # Copy additional files from extension
            copy_additional_files "$COMPONENTS_DIR/extensions/$ext" "$build_dir"
            
            echo "  Built: $env/$ext"
        done
    done
fi

# Restore user .env files
echo "Restoring user .env files..."
if [ -d "$backup_dir" ]; then
    # Restore all backed up .env files
    find "$backup_dir" -name ".env" -type f | while read -r backup_file; do
        # Get relative path from backup directory
        rel_path="${backup_file#$backup_dir/}"
        target_file="$BUILD_DIR/$rel_path"
        
        # Create target directory if needed
        mkdir -p "$(dirname "$target_file")"
        
        # Restore .env file
        cp "$backup_file" "$target_file"
        echo "  Restored: $rel_path"
    done
    
    # Clean up backup directory
    rm -rf "$backup_dir"
fi

echo ""
echo "Build completed! Generated configurations in: $BUILD_DIR"
echo ""
echo "Available configurations:"
for env in "${environments[@]}"; do
    echo "  - $env/base"
    if [ ${#extensions[@]} -gt 0 ]; then
        for ext in "${extensions[@]}"; do
            echo "  - $env/$ext"
        done
    fi
done