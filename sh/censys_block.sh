#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

CENSYS_IPS=(
    "66.132.159.0/24"
    "162.142.125.0/24"
    "167.94.138.0/24"
    "167.94.145.0/24"
    "167.94.146.0/24"
    "167.248.133.0/24"
    "199.45.154.0/24"
    "199.45.155.0/24"
    "206.168.34.0/24"
    "206.168.35.0/24"
    "2602:80d:1000:b0cc:e::/80"
    "2620:96:e000:b0cc:e::/80"
    "2602:80d:1003::/112"
    "2602:80d:1004::/112"
)

echo -e "${BLUE}Blocking Censys IP ranges...${NC}"
for ip in "${CENSYS_IPS[@]}"; do
    sudo ufw deny from "$ip" > /dev/null
done

echo -e "${GREEN}Censys IP ranges blocked${NC}"
