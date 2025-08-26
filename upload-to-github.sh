#!/bin/bash

# Script to upload the repository to GitHub
# This script uses the GitHub personal access token from environment variables

# Check if GitHub token is available in environment variables
if [ -z "$GITHUB_PAT" ]
then
    echo "GitHub personal access token not found in environment variables"
    echo "Please set GITHUB_PAT environment variable with your GitHub personal access token"
    exit 1
fi

GITHUB_TOKEN=$GITHUB_PAT
USERNAME="cbwinslow"
REPO_NAME="rag-database"

echo "Creating repository $REPO_NAME on GitHub..."

# Create the repository on GitHub
response=$(curl -s -w "%{http_code}" -X POST "https://api.github.com/user/repos" \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    -d "{
        \"name\": \"$REPO_NAME\",
        \"private\": false,
        \"auto_init\": false
    }")

# Extract the HTTP status code (last 3 characters)
http_code=${response: -3}

if [ "$http_code" == "201" ]
then
    echo "Repository created successfully on GitHub!"
    
    # Add GitHub remote
    cd /home/cbwinslow/db
    git remote add github https://$GITHUB_TOKEN@github.com/$USERNAME/$REPO_NAME.git 2>/dev/null || true
    
    # Push to GitHub
    echo "Pushing code to GitHub..."
    git push -u github main
    
    echo "Repository successfully uploaded to GitHub!"
    echo "URL: https://github.com/$USERNAME/$REPO_NAME"
elif [ "$http_code" == "422" ]
then
    echo "Repository already exists on GitHub. Adding remote and pushing..."
    cd /home/cbwinslow/db
    git remote remove github 2>/dev/null || true
    git remote add github https://$GITHUB_TOKEN@github.com/$USERNAME/$REPO_NAME.git
    git push -u github main --force
    
    echo "Repository successfully uploaded to existing GitHub repository!"
    echo "URL: https://github.com/$USERNAME/$REPO_NAME"
else
    echo "Failed to create repository on GitHub. HTTP status code: $http_code"
    echo "Response: ${response%???}"
fi