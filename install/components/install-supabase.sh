#!/bin/bash

# Supabase installation script

set -e

echo "Installing Supabase..."

# Clone Supabase repository
git clone --depth 1 https://github.com/supabase/supabase.git /opt/databases/supabase

# Navigate to docker directory
cd /opt/databases/supabase/docker

# Create env file
cat > .env << EOF
POSTGRES_PASSWORD=postgres
JWT_SECRET=super-secret-jwt-token-with-at-least-32-characters-long
ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0
SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU
EOF

# Pull docker images
docker-compose pull

# Create log entry
echo "$(date): Supabase installed" >> /var/log/database-install/install.log

echo "Supabase installation completed!"
echo "To start Supabase, navigate to /opt/databases/supabase/docker and run:"
echo "docker-compose up -d"
echo "Supabase will be available at http://localhost:3000"