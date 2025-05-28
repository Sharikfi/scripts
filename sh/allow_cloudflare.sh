#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Checking UFW installation...${NC}"
if ! command -v ufw &> /dev/null; then
    echo -e "${BLUE}Installing UFW...${NC}"
    sudo apt-get update > /dev/null
    sudo apt-get install ufw -y > /dev/null
fi

echo -e "${BLUE}Resetting UFW rules...${NC}"
sudo ufw --force reset > /dev/null

echo -e "${BLUE}Setting default policies...${NC}"
sudo ufw default deny incoming > /dev/null
sudo ufw default allow outgoing > /dev/null

echo -e "${BLUE}Allowing SSH (port 22)...${NC}"
sudo ufw allow 22 > /dev/null

echo -e "${BLUE}Downloading Cloudflare IP ranges...${NC}"
v4_ips=$(curl -s https://www.cloudflare.com/ips-v4)
v6_ips=$(curl -s https://www.cloudflare.com/ips-v6)

echo -e "${BLUE}Allowing Cloudflare IPs...${NC}"
for ip in $v4_ips; do
    sudo ufw allow from "$ip" to any port 80 proto tcp > /dev/null
    sudo ufw allow from "$ip" to any port 443 proto tcp > /dev/null
done
for ip in $v6_ips; do
    sudo ufw allow from "$ip" to any port 80 proto tcp > /dev/null
    sudo ufw allow from "$ip" to any port 443 proto tcp > /dev/null
done

echo -e "${BLUE}Enabling UFW...${NC}"
echo "y" | sudo ufw enable > /dev/null

echo -e "${GREEN}Firewall configured: Cloudflare IPs allowed on 80/443, SSH open on 22${NC}"
