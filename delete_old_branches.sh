#!/bin/bash

# Define the age threshold (15 days in seconds: 15 days * 24 hours * 60 minutes * 60 seconds)
age_threshold=$((15 * 24 * 60 * 60))

# Get the current date in seconds since the epoch
current_date=$(date +%s)

# Loop through all branches and delete the ones that are 15 days old or older
for branch in $(git branch --format="%(refname:short)"); do
    # Calculate the branch's last commit date in seconds since the epoch
    last_commit_date=$(git log -1 --format=%at $branch)
    age=$((current_date - last_commit_date))

    if [ $age -ge $age_threshold ]; then
        # Delete the branch
        git branch -D $branch
        echo "Deleted branch '$branch' (last commit was more than 15 days ago)."
    fi
done
