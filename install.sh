#!/usr/bin/env bash

# --- Color Codes for Installer UI ---
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo -e "${CYAN}▲ Starting Neon Package Manager Installer...${NC}\n"

# 1. Environment & Dependency Checks
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[Error]${NC} This installer needs to be run with sudo or root privileges."
    echo -e "        Please run: ${YELLOW}sudo ./install.sh${NC}"
    exit 1
fi

if ! command -v xbps-install &> /dev/null; then
    echo -e "${RED}[Error]${NC} XBPS package manager not detected."
    echo -e "        Neon is a wrapper designed specifically for Void Linux."
    exit 1
fi

if [ ! -f "./neon" ]; then
    echo -e "${RED}[Error]${NC} Core 'neon' script file not found in this folder."
    echo -e "        Please ensure you are running this installer inside the repository directory."
    exit 1
fi

# 2. Deploying System Binary
echo -e "${CYAN}[1/3]${NC} Installing system binary..."
chmod +x ./neon
cp ./neon /usr/local/bin/neon

if [ $? -eq 0 ]; then
    echo -e "      ${GREEN}✓${NC} Successfully deployed to /usr/local/bin/neon"
else
    echo -e "      ${RED}✗${NC} Failed to copy system binary."
    exit 1
fi

# 3. Provisioning Global/User Configurations
echo -e "${CYAN}[2/3]${NC} Set up deployment configurations..."
if [ -n "$SUDO_USER" ]; then
    # Intelligently target the real human home directory under sudo
    REAL_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
    CONFIG_DIR="$REAL_HOME/.config/neon"
    CONFIG_FILE="$CONFIG_DIR/neon.conf"

    if [ ! -f "$CONFIG_FILE" ]; then
        mkdir -p "$CONFIG_DIR"
        cat << 'EOF' > "$CONFIG_FILE"
# --- Neon Package Manager Configuration ---

# Style theme colors
# Options: CYAN, MAGENTA, GREEN, RED, YELLOW, BLUE
THEME_COLOR="CYAN"
ACCENT_COLOR="MAGENTA"
EOF
        # Transfer folder ownership from root to your real regular user account
        chown -R "$SUDO_USER:" "$CONFIG_DIR"
        echo -e "      ${GREEN}✓${NC} Created personal profile at: ~/.config/neon/neon.conf"
    else
        echo -e "      ${YELLOW}!${NC} Pre-existing profile skipped at: ~/.config/neon/neon.conf"
    fi
else
    echo -e "      ${YELLOW}!${NC} Root execution mode: user profile skipped."
fi

# 4. Final Validation Check
echo -e "${CYAN}[3/3]${NC} Running validation check..."
if command -v neon &> /dev/null; then
    echo -e "      ${GREEN}✓${NC} Binary path validation confirmed."
else
    echo -e "      ${RED}✗${NC} Warning: /usr/local/bin/ is not in your current environment PATH layout."
fi

echo -e "\n${GREEN}➔ Neon installation complete!${NC} Try typing: ${CYAN}neon${NC}"
