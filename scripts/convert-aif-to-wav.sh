#!/bin/bash

# Script to recursively convert .aif files to .wav using ffmpeg
# Usage: ./convert_aif_to_wav.sh [directory]
# If no directory is specified, it will use the current directory

# Set the target directory (use argument or current directory)
TARGET_DIR="${1:-.}"

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed or not in PATH"
    exit 1
fi

# Check if target directory exists
if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Directory '$TARGET_DIR' does not exist"
    exit 1
fi

echo "Converting .aif files to .wav in: $TARGET_DIR"
echo "----------------------------------------"

# Counter for converted files
converted_count=0

# Find all .aif files recursively and convert them
while IFS= read -r -d '' file; do
    # Get the directory and filename without extension
    dir=$(dirname "$file")
    filename=$(basename "$file" .aif)
    
    # Create output path with .wav extension
    output_file="$dir/$filename.wav"
    
    echo "Converting: $file"
    echo "       to: $output_file"
    
    # Convert using ffmpeg
    if ffmpeg -i "$file" "$output_file" -y -loglevel error; then
        echo "✓ Success"
        ((converted_count++))
    else
        echo "✗ Failed to convert $file"
    fi
    
    echo ""
    
done < <(find "$TARGET_DIR" -name "*.aif" -type f -print0)

echo "----------------------------------------"
echo "Conversion complete! Converted $converted_count files."

# Optional: Ask if user wants to remove original .aif files
read -p "Do you want to remove the original .aif files? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Removing original .aif files..."
    find "$TARGET_DIR" -name "*.aif" -type f -delete
    echo "Original .aif files removed."
fi
