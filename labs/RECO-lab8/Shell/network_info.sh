#!/bin/bash

display_menu() {
  clear
  echo "Network Information Menu - Slackware"
  echo "-------------------------------------"
  echo "1) Display Network Interfaces (ifconfig/ip)"
  echo "2) Display Network Statistics (netstat)"
  echo "3) Display Bandwidth Usage (vnstat)"
  echo "4) Display Routing Table (route/ip route)"
  echo "5) Display Ethernet Information (ethtool/ip link)"
  echo "6) Exit"
  echo "-------------------------------------"
  read -p "Select an option (1-6): " choice
}

execute_command() {
  case $1 in
    1)
      echo -e "\n*** Network Interfaces ***"
      if command -v ifconfig &>/dev/null; then
        ifconfig -a
      else
        ip addr show
      fi
      ;;
    2)
      echo -e "\n*** Network Statistics ***"
      netstat -i
      ;;
    3)
      echo -e "\n*** Bandwidth Usage ***"
      vnstat -i "$(ip route | grep default | awk '{print $5}')" || echo "vnstat is not installed."
      ;;
    4)
      echo -e "\n*** Routing Table ***"
      if command -v route &>/dev/null; then
        route -n
      else
        ip route show
      fi
      ;;
    5)
      echo -e "\n*** Ethernet Information ***"
      if command -v ethtool &>/dev/null; then
        ethtool "$(ip route | grep default | awk '{print $5}')"
      else
        ip link show
      fi
      ;;
    6)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid option. Please try again."
      ;;
  esac
}

while true; do
  display_menu
  execute_command "$choice"
  read -p "Press Enter to continue..."
done
