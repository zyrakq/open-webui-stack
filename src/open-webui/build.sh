#!/bin/bash

# Open WebUI Build Script
set -e

COMPONENTS_DIR="components"
BUILD_DIR="build"

# Clean and create build directory
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Get environments and extensions
environments=($(ls $COMPONENTS_DIR/environments/*.yml | xargs -n1 basename | sed 's/\.yml$//' | sort))
extensions=($(ls $COMPONENTS_DIR/extensions/*.yml | xargs -n1 basename | sed 's/\.yml$//' | sort))

echo "Building configurations..."

# Build base configurations for each environment
for env in "${environments[@]}"; do
    build_dir="$BUILD_DIR/$env/base"
    mkdir -p "$build_dir"
    
    # Merge compose files
    docker-compose -f $COMPONENTS_DIR/base/base.yml -f $COMPONENTS_DIR/environments/$env.yml config --no-interpolate > "$build_dir/docker-compose.yml"
    
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
        
        # Merge compose files
        docker-compose -f $COMPONENTS_DIR/base/base.yml -f $COMPONENTS_DIR/environments/$env.yml -f $COMPONENTS_DIR/extensions/$ext.yml config --no-interpolate > "$build_dir/docker-compose.yml"
        
        # Merge env files
        cat $COMPONENTS_DIR/base/.env.base > "$build_dir/.env.example"
        [ -f "$COMPONENTS_DIR/environments/.env.$env" ] && echo "" >> "$build_dir/.env.example" && cat "$COMPONENTS_DIR/environments/.env.$env" >> "$build_dir/.env.example"
        [ -f "$COMPONENTS_DIR/extensions/.env.$ext" ] && echo "" >> "$build_dir/.env.example" && cat "$COMPONENTS_DIR/extensions/.env.$ext" >> "$build_dir/.env.example"
        
        echo "Built: $env/$ext"
    done
done

echo "Build completed! Generated configurations in: $BUILD_DIR"