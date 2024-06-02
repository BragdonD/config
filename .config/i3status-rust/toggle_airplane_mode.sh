#!/bin/bash

# Function to bring down all network interfaces except loopback
disable_network_interfaces() {
    for iface in $(nmcli -t -f DEVICE,TYPE d | grep -v loopback | cut -d: -f1); do
        nmcli device disconnect "$iface"
    done
}

# Function to bring up all network interfaces except loopback
enable_network_interfaces() {
    for iface in $(nmcli -t -f DEVICE,TYPE d | grep -v loopback | cut -d: -f1); do
        nmcli device connect "$iface"
    done
}

# Get the current status of airplane mode (checking Wi-Fi status as a proxy)
status=$(nmcli -t -f WIFI g)

if [ "$status" = "enabled" ]; then
    echo "Enabling Airplane Mode..."
    nmcli radio all off
    disable_network_interfaces
    echo "Airplane Mode Enabled."
else
    echo "Disabling Airplane Mode..."
    nmcli radio all on
    enable_network_interfaces
    echo "Airplane Mode Disabled."
fi

