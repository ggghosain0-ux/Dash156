#!/bin/bash

# Color definitions for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}===============================================================${NC}"
echo -e "${PURPLE}         VOIDORA CLOUD DASHBOARD - LOCAL DEPLOYMENT SETUP       ${NC}"
echo -e "${CYAN}===============================================================${NC}"

# Detect OS
OS_TYPE="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macos"
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    OS_TYPE="windows"
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${YELLOW}[!] Node.js is not found on your system.${NC}"
    echo -e "Attempting to install Node.js..."

    if [ "$OS_TYPE" == "linux" ]; then
        if command -v apt-get &> /dev/null; then
            echo -e "${BLUE}Installing Node.js via NodeSource on Debian/Ubuntu...${NC}"
            sudo apt-get update && sudo apt-get install -y curl build-essential
            curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
            sudo apt-get install -y nodejs
        elif command -v dnf &> /dev/null; then
            echo -e "${BLUE}Installing Node.js via DNF...${NC}"
            sudo dnf install -y nodejs
        else
            echo -e "${RED}[x] Unsupported Linux package manager. Please install Node.js manually.${NC}"
            exit 1
        fi
    elif [ "$OS_TYPE" == "macos" ]; then
        if command -v brew &> /dev/null; then
            echo -e "${BLUE}Installing Node.js via Homebrew...${NC}"
            brew install node
        else
            echo -e "${RED}[x] Homebrew is not installed. Please install Node.js manually from: https://nodejs.org/${NC}"
            exit 1
        fi
    elif [ "$OS_TYPE" == "windows" ]; then
        echo -e "${RED}[x] Automatic Windows installation is not supported inside this shell.${NC}"
        echo -e "Please download and run the Node.js installer from: https://nodejs.org/"
        exit 1
    else
        echo -e "${RED}[x] Unknown OS. Please install Node.js manually.${NC}"
        exit 1
    fi
fi

# Confirm Node.js & npm versions
echo -e "${GREEN}[✓] Node.js version:${NC} $(node -v)"
echo -e "${GREEN}[✓] npm version:${NC} $(npm -v)"

# Install project dependencies
echo -e "\n${BLUE}[1/3] Installing dependencies via npm...${NC}"
npm install

if [ $? -ne 0 ]; then
    echo -e "${RED}[x] Dependency installation failed. Retrying with --legacy-peer-deps...${NC}"
    npm install --legacy-peer-deps
fi

# Ensure .env exists in the /dash directory
echo -e "\n${BLUE}[2/3] Setting up environment variables...${NC}"
if [ ! -f "dash/.env" ]; then
    echo -e "${YELLOW}[!] dash/.env not found. Creating a default configuration...${NC}"
    mkdir -p dash
    cat <<EOT > dash/.env
RAZORPAY_KEY_ID=rzp_test_1234567890abcdef
RAZORPAY_KEY_SECRET=AbCdEfGhIjKlMnOpQrSt
PORT=3000
EOT
    echo -e "${GREEN}[✓] Created dash/.env with demo configurations.${NC}"
else
    echo -e "${GREEN}[✓] Environment configuration (dash/.env) already exists.${NC}"
fi

# Run database checks if any (SQLite db is local and preloaded)
if [ -f "dash/hosting.db" ]; then
    echo -e "${GREEN}[✓] Found SQLite database: dash/hosting.db${NC}"
else
    echo -e "${YELLOW}[!] SQLite database not found. It will be initialized on startup.${NC}"
fi

# Start Server
echo -e "\n${BLUE}[3/3] Launching local web server...${NC}"
echo -e "${GREEN}===============================================================${NC}"
echo -e "🚀  Your VOIDORA CLOUD DASHBOARD is running locally!"
echo -e "🔗  Access it here: ${CYAN}http://localhost:3000${NC}"
echo -e "🛑  To stop the server, press: ${RED}Ctrl + C${NC}"
echo -e "${GREEN}===============================================================${NC}"

npm start
