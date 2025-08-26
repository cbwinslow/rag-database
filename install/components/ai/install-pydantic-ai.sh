#!/bin/bash

# Pydantic AI installation script

set -e

echo "Installing Pydantic AI..."

# Check if Python is installed
if ! command -v python3 &> /dev/null
then
    echo "Python 3 is not installed. Please install Python 3 first."
    exit 1
fi

# Check if pip is installed
if ! command -v pip3 &> /dev/null
then
    echo "pip3 is not installed. Please install pip3 first."
    exit 1
fi

# Create directory for Pydantic AI
mkdir -p /opt/ai/pydantic-ai
cd /opt/ai/pydantic-ai

# Create a virtual environment
python3 -m venv venv
source venv/bin/activate

# Install Pydantic AI
pip install pydantic-ai

# Create a simple example script
cat > example.py << EOF
from pydantic_ai import Agent, RunContext
from pydantic import BaseModel

class UserInfo(BaseModel):
    name: str
    age: int
    email: str

agent = Agent(
    model='openai:gpt-4',
    result_type=UserInfo,
    system_prompt='You are a helpful assistant that collects user information.'
)

async def main():
    result = await agent.run('I am John, 30 years old, and my email is john@example.com')
    print(result.data)

if __name__ == '__main__':
    import asyncio
    asyncio.run(main())
EOF

# Create requirements file
cat > requirements.txt << EOF
pydantic-ai
EOF

# Create log entry
echo "$(date): Pydantic AI installed" >> /var/log/ai-install/install.log

echo "Pydantic AI installation completed!"
echo "To use Pydantic AI, activate the virtual environment:"
echo "cd /opt/ai/pydantic-ai && source venv/bin/activate"
echo "Then run your Python scripts with Pydantic AI"