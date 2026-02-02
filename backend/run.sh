#!/bin/bash

# CortexEDR Backend Run Script

# Exit on error
set -e

# Navigate to backend directory if not already there
cd "$(dirname "$0")"

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Virtual environment not found. Please run initial setup first."
    exit 1
fi

# Activate virtual environment
source venv/bin/activate

# Check if .env exists
if [ ! -f ".env" ]; then
    echo ".env file not found. Copying .env.example..."
    cp .env.example .env
    echo "Please update .env with your actual credentials."
fi

# Start FastAPI server
echo "Starting FastAPI server on http://localhost:8000..."
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
