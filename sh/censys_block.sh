#!/bin/bash
set -e

echo -e "\033[0;31mBlocking Censys IPs...\033[0m"

# censys ips
BLOCKED_IPS=(
66.132.159.0/24
162.142.125.0/24
167.94.138.0/24
167.94.145.0/24
167.94.146.0/24
167.248.133.0/24
199.45.154.0/24
199.45.155.0/24
206.168.34.0/24
206.168.35.0/24
2602:80d:1000:b0cc:e::/80
2620:96:e000:b0cc:e::/80
2602:80d:1003::/112
2602:80d:1004::/112
)

# block
for ip in "${BLOCKED_IPS[@]}"; do
  ufw deny from "$ip" comment 'Censys' >/dev/null 2>&1
done

echo -e "\033[0;31mBlocked ${#BLOCKED_IPS[@]} Censys IP ranges.\033[0m"
