#!/bin/bash

# Color definitions for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

clear
echo -e "${CYAN}===============================================================${NC}"
echo -e "${PURPLE}            VOIDORA CLOUD DASHBOARD - SETUP WIZARD            ${NC}"
echo -e "${CYAN}===============================================================${NC}"
echo -e "Welcome to the installation menu. Please choose how you want to"
echo -e "deploy the dashboard:"
echo -e ""
echo -e "  ${GREEN}[1] Local Deployment (localhost:3000)${NC}"
echo -e "      Ideal for developers or running locally. Installs node modules"
echo -e "      and spins up the server immediately on http://localhost:3000."
echo -e ""
echo -e "  ${GREEN}[2] VPS Deployment + Cloudflare Routing${NC}"
echo -e "      Ideal for hosting on a VPS (Debian/Ubuntu). Installs Node.js,"
echo -e "      PM2 (to run in background), and Cloudflare Tunnel (cloudflared)"
echo -e "      for secure HTTPS domain routing."
echo -e ""
echo -e "  ${RED}[3] Exit setup${NC}"
echo -e "${CYAN}===============================================================${NC}"

# Ask for user input
read -p "Enter your choice [1-3]: " choice

case $choice in
    1)
        echo -e "\n${BLUE}>> Launching local setup...${NC}"
        if [ -f "./install-local.sh" ]; then
            chmod +x ./install-local.sh
            ./install-local.sh
        else
            echo -e "${RED}[x] Error: ./install-local.sh not found.${NC}"
            exit 1
        fi
        ;;
    2)
        echo -e "\n${BLUE}>> Launching VPS & Cloudflare setup...${NC}"
        if [ -f "./install-vps.sh" ]; then
            chmod +x ./install-vps.sh
            ./install-vps.sh
        else
            echo -e "${RED}[x] Error: ./install-vps.sh not found.${NC}"
            exit 1
        fi
        ;;
    3)
        echo -e "\n${YELLOW}Setup exited.${NC}"
        exit 0
        ;;
    *)
        echo -e "\n${RED}[x] Invalid option. Exiting setup.${NC}"
        exit 1
        ;;
esac
