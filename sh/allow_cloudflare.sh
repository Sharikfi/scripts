#!/bin/bash
set -e

# colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # no color

echo -e "${YELLOW}Starting firewall configuration...${NC}"

# check ufw
if ! command -v ufw &>/dev/null; then
  echo -e "${YELLOW}UFW not found. Installing UFW...${NC}"
  apt update && apt install -y ufw
  echo -e "${GREEN}UFW installed successfully.${NC}"
else
  echo -e "${GREEN}UFW is already installed.${NC}"
fi

# get cf ips
echo -e "${YELLOW}Fetching Cloudflare IP ranges...${NC}"
CLOUDFLARE_IPS=$(curl -s https://www.cloudflare.com/ips-v4  && curl -s https://www.cloudflare.com/ips-v6 )

# allow 80/443 only for cf
echo -e "${YELLOW}Allowing HTTP/HTTPS from Cloudflare IPs...${NC}"
for ip in $CLOUDFLARE_IPS; do
  ufw allow from "$ip" to any port 80,443 comment 'Cloudflare HTTP/HTTPS' >/dev/null 2>&1
done

# set default policies
echo -e "${YELLOW}Setting default firewall policies...${NC}"
ufw default deny incoming >/dev/null 2>&1
ufw default allow outgoing >/dev/null 2>&1

# enable ufw
echo -e "${YELLOW}Enabling UFW...${NC}"
ufw --force enable >/dev/null 2>&1

echo -e "${GREEN}✅ Firewall configured successfully!${NC}"
echo -e "${YELLOW}UFW status:${NC}"
ufw status verbose
