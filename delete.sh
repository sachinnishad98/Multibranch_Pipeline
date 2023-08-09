#!/bin/bash

# Get the current date in seconds since the epoch
current_date=$(date +%s)

# Calculate the timestamp for 30 days ago
thirty_days_ago=$((current_date - 1 * 24 * 60 * 60))  # 30 days in seconds

# Iterate through local branches and delete those older than 30 days
for branch in $(git branch --format='%(refname:short)'); do
    last_commit_date=$(git log -n 1 --format="%at" "$branch")
    if [ $last_commit_date -lt $thirty_days_ago ]; then
        git branch -D "$branch"
        echo "Deleted branch $branch"
    fi
done
