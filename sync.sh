#!/bin/bash

folder_path=~/GitHub/brave-traveler

cd "$folder_path" || exit 1  # Exit with error if folder doesn't exist

if [[ $(git status --porcelain) ]]; then
    echo "Staging unstaged files..."
    git add .
    commit_message="$(date +'%A, %Y-%m-%d %H:%M:%S')"
    echo "Committing changes..."
    git commit -m "$commit_message"
    echo "Pushing commits..."
    git push origin linuxsync
else
    echo "Working tree is clean, pushing commits..."
    git push origin linuxsync
    
fi
