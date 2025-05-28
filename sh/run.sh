#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO_URL="https://raw.githubusercontent.com/Sharikfi/scripts/refs/heads/main/sh/"

echo -e "${BLUE}Downloading firewall scripts...${NC}"
curl -sSL "$REPO_URL/allow_cloudflare.sh" -o allow_cloudflare.sh
curl -sSL "$REPO_URL/censys_block.sh" -o censys_block.sh
chmod +x allow_cloudflare.sh censys_block.sh

echo -e "${BLUE}Executing firewall setup...${NC}"
./allow_cloudflare.sh
./censys_block.sh

rm allow_cloudflare.sh censys_block.sh
echo -e "${GREEN}Firewall configuration completed successfully!${NC}"
