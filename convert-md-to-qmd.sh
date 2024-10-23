#!/bin/bash
while IFS= read -r file; do
    # Loop over all .md files in the repository
    for file in $(find . -type f -name "*.md"); do
        filename=$(basename "$file" .md)
        newfile="${file%.md}.qmd"
        
        # Get the file's creation date (falling back to git log if necessary)
        if command -v stat > /dev/null 2>&1; then
            file_creation_date=$(stat -c %w "$file" 2>/dev/null || stat -c %y "$file" | cut -d' ' -f1)
        else
            file_creation_date=$(git log --format=%aI "$file" | tail -n 1 | cut -d'T' -f1)
        fi

        # Simulate an API request (for demo purposes, we’ll use the filename as the subtitle)
        subtitle="$filename"  # Replace this line with actual API call logic if needed.

        # Create or modify the header in the new .qmd file
        {
            # Add the YAML header
            echo "---"
            echo "title: $filename"
            echo "subtitle: $subtitle"
            echo "date: $file_creation_date"
            echo "---"
            # Append the original content
            cat "$file"
        } > "$newfile"

        # Remove the original .md file (optional, based on your needs)
        rm "$file"
done < <(find ./ -type f -name "*.md")