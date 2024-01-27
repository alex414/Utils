#!/bin/bash
#Indentify all hosts on your subnet within a given range and update the arp cache

network_id=$(ip -4 addr show eth0 | grep inet | awk -F" " {' print $2 '} | awk -F"." {'
print $1"."$2"."$3 '})

echo -n "Starting IP: $network_id."
read startip

echo "Searching for hosts on $network_id.$startip-$endip..."

while(i<=254)
ping -c 1 -w 1 "$192.168.1.$i"
i++;

echo "Search complete..."
arp -e | grep -v incomplete > /root/Documents/arp_cache_$(date +%F)

echo "Current arp cache:"
arp -e

echo -n "Would you like to remove incomplete entries from arp cache (y/n): "
read choice

if [ "$choice" = y ]; then
clear
echo "Updated arp cache:"
grep -v address /root/Documents/arp_cache_$(date +%F) | awk -F" " {' print $1" "$3
'} > /root/Documents/update
ip -s neigh flush all
arp -f /root/Documents/update
rm /root/Documents/update
arp -e
fi
