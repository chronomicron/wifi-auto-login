#!/bin/bash

# check_wifi_and_login.sh
# ------------------------
# This script is meant to be run by a cron job every minute.
# It checks if the device is connected to a specific WiFi network
# and whether it has internet access. If it's connected but no internet,
# it launches the captive portal auto-login Python script.

# --- CONFIGURATION SECTION ---

# Name of the WiFi network that has the captive portal
TARGET_SSID="ccomtlGuest"

# Path to the Python script that handles the captive portal login
PYTHON_SCRIPT_PATH="/home/grou/workspace/wifi-auto-login/auto_login.py"

# Path to the log file to write script status messages
LOG_FILE="/home/grou/workspace/wifi-auto-login/wifi_login.log"

# --- END CONFIGURATION SECTION ---

# Function to get current connected WiFi SSID
get_current_ssid() {
    nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2
}

# Function to check if internet is available
has_internet() {
    ping -q -w 5 -c 1 8.8.8.8 > /dev/null 2>&1
}

# Main execution starts here
{
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    CURRENT_SSID=$(get_current_ssid)

    if [[ "$CURRENT_SSID" != "$TARGET_SSID" ]]; then
        echo "[$TIMESTAMP] Not connected to $TARGET_SSID. Current SSID: $CURRENT_SSID"
    else
        if has_internet; then
            echo "[$TIMESTAMP] Connected to $TARGET_SSID and internet is working. No action needed."
        else
            echo "[$TIMESTAMP] Connected to $TARGET_SSID but no internet. Running login script..."
            python3 "$PYTHON_SCRIPT_PATH" && echo "[$TIMESTAMP] Login script ran successfully." || echo "[$TIMESTAMP] Login script failed."
        fi
    fi

    # Keep only the last 200 lines of the log file to prevent bloat
} >> "$LOG_FILE" 2>&1
tail -n 200 "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"