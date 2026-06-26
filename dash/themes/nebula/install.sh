#!/bin/bash

# Theme Installer for Nebula Space
THEME_NAME="Nebula Space"
THEME_ID="nebula"

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${CYAN}====================================================${NC}"
echo -e "${CYAN}          ${THEME_NAME} Theme Installer          ${NC}"
echo -e "${CYAN}====================================================${NC}"

# Find dashboard root directory
if [ -f "../../app.js" ] && [ -d "../../config" ]; then
    DASHBOARD_ROOT="../.."
elif [ -f "app.js" ] && [ -d "config" ]; then
    DASHBOARD_ROOT="."
elif [ -f "dash/app.js" ] && [ -d "dash/config" ]; then
    DASHBOARD_ROOT="dash"
else
    echo -e "${YELLOW}[!] Warning: Could not locate hosting dashboard root directory.${NC}"
    echo -e "Please run this script from the theme directory or the dashboard root."
    exit 1
fi

echo -e "${GREEN}[✓] Detected dashboard root directory at: ${DASHBOARD_ROOT}${NC}"

# Ensure configuration directory exists
mkdir -p "${DASHBOARD_ROOT}/config"

# Activate the theme in config/theme.json
CONFIG_PATH="${DASHBOARD_ROOT}/config/theme.json"
echo -e "${CYAN}[*] Activating theme '${THEME_ID}' in config...${NC}"

if [ -f "$CONFIG_PATH" ]; then
    # Simple JSON replacement or recreation
    echo -e "{\n  \"active\": \"${THEME_ID}\"\n}" > "$CONFIG_PATH"
else
    echo -e "{\n  \"active\": \"${THEME_ID}\"\n}" > "$CONFIG_PATH"
fi

echo -e "${GREEN}[✓] ${THEME_NAME} has been activated successfully!${NC}"
echo -e "${GREEN}[✓] Please refresh your browser or restart the dashboard to see changes.${NC}"
echo -e "${CYAN}====================================================${NC}"
