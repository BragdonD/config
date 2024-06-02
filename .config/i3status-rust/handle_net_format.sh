# !/bin/bash

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

if [ "airplane" = $1 ]; then
  # Get the current status of airplane mode (checking Wi-Fi status as a proxy)
  status=$(nmcli -t -f WIFI g)

  if [ "$status" == "enabled" ]; then
      # echo "Enabling Airplane Mode..."
      nmcli radio all off
      disable_network_interfaces
      # echo "Airplane Mode Enabled."
  else
      # echo "Disabling Airplane Mode..."
      nmcli radio all on
      enable_network_interfaces
      # echo "Airplane Mode Disabled."
  fi		
fi

ip=$(hostname -I | awk '{print $1}')
ipv6=$(hostname -I | awk '{print $2}')

if [ -z "$ip" ]; then
  state="Warning"
  ip="No Connection"
else
  state="Good"
fi

if [ $state = "Good" ]; then
  icon='\uf012'  
else
  icon='\uf072'
fi

# Display the IP address
echo "{\"state\":\"${state}\",\"text\":\"${icon} ${ip}\"}"
