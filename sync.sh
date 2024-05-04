#!/bin/bash

folder_path=~/GitHub/brave-traveler

cd "$folder_path"

clean=$(git diff-index --quiet HEAD -- && git diff-files --quiet)

if [ $clean -eq 0 ]
then
  echo "Working tree is clean. Skipping commit and pushing changes."
  git push
else
  commit_message="$(date +'%A - %Y-%m-%d %H:%M:%S')"

  git add .
  git commit -m "$commit_message"

  git push
fi
