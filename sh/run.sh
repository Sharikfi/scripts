#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Downloading firewall scripts...${NC}"
curl -sSL https://raw.githubusercontent.com/Sharikfi/scripts/main/sh/allow_cloudflare.sh -o allow.sh
curl -sSL https://raw.githubusercontent.com/Sharikfi/scripts/main/sh/censys_block.sh -o block.sh
chmod +x allow.sh block.sh

echo -e "${BLUE}Executing allow_cloudflare.sh...${NC}"
./allow.sh

echo -e "${BLUE}Executing censys_block.sh...${NC}"
./block.sh

rm allow.sh block.sh
echo -e "${GREEN}Firewall configuration completed!${NC}"
