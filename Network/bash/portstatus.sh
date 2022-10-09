#!/bin/bash

 #Monitor either tcp or udp ports and alert user when there is a change in status.

 echo -n "Enter (1) for tcp, (2) for udp, or (3) for both: "
 read option
 echo -n "Enter time interval in seconds to scan: "
 read time

 #Set flags for the ss command
 if [ "$option" -eq 1 ]; then
 state=tan
 p=TCP
 elif [ "$option" -eq 2 ]; then
 state=uan
 p=UDP
 else
 state=tuan
 p="TCP and UDP"
 fi

 #Run scans indenfietly
 echo "Monitoring $p"
 while true; do
        ss -"$state" > current
        sort current > sorted_current
        sleep "$time"
        ss -"$state" > updated
        sort updated > sorted_updated
        diff sorted_current sorted_updated > results

 #There was a change in scan, port status has been changed
 if [ -s results ]; then
 zenity --warning --text "Alert! Change in port status!"
 echo
 ss -"$state"
 echo
 echo -n "Continue monitoring (y/n): "
 read choice
 if [ "$choice" != 'y' ]; then
 rm current sorted_current updated sorted_updated results
 break
 fi
 else
 echo "No change in port status..."
 fi
 done