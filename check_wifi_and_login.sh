#!/bin/bash

# -------------------------------------------------------------
# WiFi Auto Login Bash Script for Ubuntu
# -------------------------------------------------------------
# This script is designed to be executed every minute via cron.
# It checks if the system is connected to a specific WiFi network.
# If connected but no internet access is detected, it triggers a
# Python script to automatically log in via a captive portal.
# -------------------------------------------------------------

# === STEP 1: Identify the current connected WiFi network (SSID) ===
# We use 'nmcli' to get the active WiFi SSID.
# NOTE: Make sure your system has 'nmcli' (NetworkManager CLI) installed.

CURRENT_SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)

# === STEP 2: Change this to the name of your target WiFi network ===
TARGET_SSID="ccomtlGuest"

# Check if we are connected to the correct WiFi network
if [ "$CURRENT_SSID" != "$TARGET_SSID" ]; then
    echo "[$(date)] Not connected to $TARGET_SSID, exiting."
    exit 0
fi

# === STEP 3: Check for internet access by pinging a reliable IP ===
# We use Google's public DNS server (8.8.8.8).
# Ping once (-c 1) and timeout quickly (-W 1).

ping -q -c 1 -W 1 8.8.8.8 > /dev/null

if [ $? -eq 0 ]; then
    echo "[$(date)] Internet access already available. No action needed."
    exit 0
fi

# === STEP 4: Call the Python script to perform the captive portal login ===
# CHANGE THIS PATH to where your auto_login.py script is located.
#
# PYTHON_SCRIPT_PATH="/path/to/your/auto_login.py"

PYTHON_SCRIPT_PATH="/home/grou/workspace/wifi-auto-login/auto_login.py"

/usr/bin/python3 "$PYTHON_SCRIPT_PATH"14                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
