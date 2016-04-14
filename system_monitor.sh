#!/bin/bash
##used for :
# system monitor
##version :
# 1.0
#include system_name system_op system_ip disk_used etc.

reset_terminal=`tput sgr0`

#system hostname
HOSTNAME=$(echo $HOSTNAME)
echo -e "\e[1;31m System hostname is :" $reset_terminal $HOSTNAME

#system opentating system
OPENRATING_SYSTEM=$(cat /etc/issue | head -1 )
echo -e "\e[1;31m System ios is :" $reset_terminal $OPENRATING_SYSTEM

#system type 
SYSTEM_TYPE=$(uname -o)
echo -e "\e[1;31m System type is :" $reset_terminal $SYSTEM_TYPE

#system bits
SYSTEM_BITS=$(uname -m)
echo -e "\e[1;31m System bits is :" $reset_terminal $SYSTEM_BITS

#system kenel
SYSTEM_KENEL=$(uname -r )
echo -e "\e[1;31m System kenel is :" $reset_terminal $SYSTEM_KENEL

#system lan IP
LAN_IP=$(hostname -I)
echo -e "\e[1;31m System local ip is :" $reset_terminal $LAN_IP

#system internet ip
WAN_IP=$(curl -s http://ipecho.net/plain)
echo -e "\e[1;31m System wan ip is :" $reset_terminal $WAN_IP

#dns
DNS=$(cat /etc/resolv.conf | 
        grep -E "\<nameserver" |
            awk '{print $2 }'|
                xargs )
echo -e "\e[1;31m System DNS is " $reset_terminal $DNS

#whether the internet is conneted 
ping -c 2 www.baidu.com &>/dev/null && echo "Connected" || echo "Disconnectd"



