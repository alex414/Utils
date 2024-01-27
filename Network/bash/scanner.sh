#!/bin/bash
#Indentify all hosts on your subnet within a given range and update the arp cache

network_id=$(ip -4 addr show eth0 | grep inet | awk -F" " {' print $2 '} | awk -F"." {'
print $1"."$2"."$3 '})

echo -n "Starting IP: $network_id."
read startip
echo -n "Ending IP: $network_id."
read endip

echo "Searching for hosts on $network_id.$startip-$endip..."

for (( i=startip; i<=endip; i++ )); do
ping -c 1 -w 1 "$network_id.$i"
done

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
