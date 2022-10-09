#!/bin/bash

#Menu
select opt in Scanner Portmonitor Macswap Firewall Portstatus Autosuid Salir; 

do 
	case $opt in 
		Scanner) ./scanner.sh;; 
		Portmonitor) ./portmonitor.sh;; 
		Macswap) ./macswap.sh;; 
		Firewall) ./firewall.sh;; 
		Portstatus) ./portstatus.sh;; 
		Autosuid) ./autosuid.sh;; 
		Salir) break;; 
		*) echo "$REPLY es una opción inválida";; 
	esac 
done