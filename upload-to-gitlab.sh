#!/bin/bash

# Script to upload the repository to GitLab
# This script uses the GitLab personal access token from environment variables

# Check if GitLab token is available in environment variables
if [ -z "$GITLAB_PAT" ]
then
    echo "GitLab personal access token not found in environment variables"
    echo "Please set GITLAB_PAT environment variable with your GitLab personal access token"
    echo "Usage: export GITLAB_PAT=your_token_here && ./upload-to-gitlab.sh"
    exit 1
fi

GITLAB_TOKEN=$GITLAB_PAT
PROJECT_NAME="rag-database"
USERNAME="cbwinslow"

echo "Creating project $PROJECT_NAME on GitLab..."

# Create the project on GitLab
response=$(curl -s -w "%{http_code}" -X POST "https://gitlab.com/api/v4/projects" \
    -H "PRIVATE-TOKEN: $GITLAB_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
        \"name\": \"$PROJECT_NAME\",
        \"visibility\": \"public\"
    }")

# Extract the HTTP status code (last 3 characters)
http_code=${response: -3}

if [ "$http_code" == "201" ]
then
    echo "Project created successfully!"
    
    # Add GitLab remote
    cd /home/cbwinslow/db
    git remote add gitlab https://oauth2:$GITLAB_TOKEN@gitlab.com/$USERNAME/$PROJECT_NAME.git
    
    # Push to GitLab
    echo "Pushing code to GitLab..."
    git push -u gitlab main
    
    echo "Repository successfully uploaded to GitLab!"
    echo "URL: https://gitlab.com/$USERNAME/$PROJECT_NAME"
else
    echo "Failed to create project. HTTP status code: $http_code"
    echo "Response: ${response%???}"
    
    # Check if project already exists
    if echo "${response%???}" | grep -q "name has already been taken"
    then
        echo "Project already exists. Adding remote and pushing..."
        cd /home/cbwinslow/db
        git remote add gitlab https://oauth2:$GITLAB_TOKEN@gitlab.com/$USERNAME/$PROJECT_NAME.git 2>/dev/null || true
        git push -u gitlab main
        echo "Repository pushed to existing project on GitLab!"
        echo "URL: https://gitlab.com/$USERNAME/$PROJECT_NAME"
    fi
fi