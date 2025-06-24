#!/bin/bash

# Load environment variables
if [ -f ".env" ]; then
    source .env
    echo "Loaded environment variables from .env file"
fi

# Check if MODULE_FILE_DETAILS is set
if [ -z "$MODULE_FILE_DETAILS" ]; then
    echo "Error: MODULE_FILE_DETAILS environment variable is not set."
    echo "Please set this variable in your .env file with the format:"
    echo "MODULE_FILE_DETAILS=file_id1:filename1.zip,file_id2:filename2.zip,..."
    echo "See .env.example for a sample configuration."
    exit 1
fi

echo "Downloading External Modules..."

# Parse MODULE_FILE_DETAILS into an associative array
declare -A files
IFS=',' read -ra MODULE_ENTRIES <<< "$MODULE_FILE_DETAILS"
for entry in "${MODULE_ENTRIES[@]}"; do
    # Split each entry by colon to get file_id and filename
    IFS=':' read -ra PARTS <<< "$entry"
    if [ ${#PARTS[@]} -eq 2 ]; then
        file_id=${PARTS[0]}
        filename=${PARTS[1]}
        files[$file_id]=$filename
    else
        echo "Warning: Invalid entry format: $entry. Expected format: file_id:filename"
    fi
done

# Download each file
if [ ${#files[@]} -eq 0 ]; then
    echo "No modules to download. Please check your MODULE_FILE_DETAILS environment variable."
    exit 1
fi

for fileid in "${!files[@]}"; do
    filename="${files[$fileid]}"
    echo "Downloading ${filename}"
    curl -L -o "${filename}" "https://drive.google.com/uc?export=download&id=${fileid}"
    
    # Check if download was successful
    if [ $? -eq 0 ] && [ -f "${filename}" ]; then
        echo "Successfully downloaded ${filename}"
        unzip -o -q "${filename}"
        rm "${filename}"
    else
        echo "Failed to download ${filename}"
    fi
done

echo "All downloads completed"