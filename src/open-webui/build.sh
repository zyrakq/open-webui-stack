#!/bin/bash

# Open WebUI Build Script
set -e

COMPONENTS_DIR="components"
BUILD_DIR="build"

# Function to merge YAML files
merge_yaml() {
    local output="$1"
    shift
    local files=("$@")
    
    # Start with empty file
    > "$output"
    
    # Concatenate all files with proper section handling
    for file in "${files[@]}"; do
        if [[ -f "$file" ]]; then
            cat "$file" >> "$output"
            echo "" >> "$output"
        fi
    done
}

# Create build directory if it doesn't exist
mkdir -p "$BUILD_DIR"

# Get environments and extensions
environments=($(ls $COMPONENTS_DIR/environments/*.yml | xargs -n1 basename | sed 's/\.yml$//' | sort))
extensions=($(ls $COMPONENTS_DIR/extensions/*.yml | xargs -n1 basename | sed 's/\.yml$//' | sort))

echo "Building configurations..."

# Build base configurations for each environment
for env in "${environments[@]}"; do
    build_dir="$BUILD_DIR/$env/base"
    mkdir -p "$build_dir"
    
    # Merge compose files using yq
    yq eval-all 'select(fileIndex == 0) *+ select(fileIndex == 1)' \
        "$COMPONENTS_DIR/base/base.yml" \
        "$COMPONENTS_DIR/environments/$env.yml" > "$build_dir/docker-compose.yml"
    
    # Merge env files
    cat $COMPONENTS_DIR/base/.env.base > "$build_dir/.env.example"
    [ -f "$COMPONENTS_DIR/environments/.env.$env" ] && echo "" >> "$build_dir/.env.example" && cat "$COMPONENTS_DIR/environments/.env.$env" >> "$build_dir/.env.example"
    
    echo "Built: $env/base"
done

# Build configurations with extensions
for env in "${environments[@]}"; do
    for ext in "${extensions[@]}"; do
        build_dir="$BUILD_DIR/$env/$ext"
        mkdir -p "$build_dir"
        
        # Merge compose files using yq
        yq eval-all 'select(fileIndex == 0) *+ select(fileIndex == 1) *+ select(fileIndex == 2)' \
            "$COMPONENTS_DIR/base/base.yml" \
            "$COMPONENTS_DIR/environments/$env.yml" \
            "$COMPONENTS_DIR/extensions/$ext.yml" > "$build_dir/docker-compose.yml"
        
        # Merge env files
        cat $COMPONENTS_DIR/base/.env.base > "$build_dir/.env.example"
        [ -f "$COMPONENTS_DIR/environments/.env.$env" ] && echo "" >> "$build_dir/.env.example" && cat "$COMPONENTS_DIR/environments/.env.$env" >> "$build_dir/.env.example"
        [ -f "$COMPONENTS_DIR/extensions/.env.$ext" ] && echo "" >> "$build_dir/.env.example" && cat "$COMPONENTS_DIR/extensions/.env.$ext" >> "$build_dir/.env.example"
        
        echo "Built: $env/$ext"
    done
done

echo "Build completed! Generated configurations in: $BUILD_DIR"