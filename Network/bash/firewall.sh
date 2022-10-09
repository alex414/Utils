#!/bin/bash

 #Quickly put up a firewall to block all incoming/outgoing communication excpet for the connections passed as arguments to the script.

 #Allow for a help argument that desribes the script
if [ "$1" = '-h' ]; then
echo "firewall.sh is a quick saftey precaution that will close out all incoming outgoing connections."
echo "It will allow communication with ip addresses passed as arugments to the script."
echo "Multiple ip addresses may be passed if they are seperated by a space."
echo
echo "Usage: firewall.sh"
echo " firewall.sh [ip_address]"
echo " firewall.sh [ip_address] [ip_address] [ip_address]..."
echo " firewall.sh -h"
else
#User wants to set up the wall. Flush current iptable and drop all incoming/ outoing connections
iptables -F
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
echo "Firewall is set. NO COMMUNICATION IS ALLOWED..."

#Loop through all command line arguments with $@ and add communication back with each ip
for ip in $@; do
iptables -I INPUT -s "$ip" -j ACCEPT
iptables -I OUTPUT -d "$ip" -j ACCEPT
echo "Firewall adjusted. Communication allowed with $ip"
done

#Show the updated firewall
echo
echo "Updated firewall:"
iptables -L
fi