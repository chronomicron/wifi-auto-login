#!/bin/bash

# --- USER CONFIGURABLE SECTION ---
WIFI_NAME="ccomtlGuest"  # Change this to your target WiFi SSID
LOG_FILE="/home/grou/workspace/wifi-auto-login/wifi_login.log"
PYTHON_SCRIPT_PATH="/home/grou/workspace/wifi-auto-login/auto_login.py"
# ---------------------------------

TIMESTAMP=$(date +"[%Y-%m-%d %H:%M:%S]")

# Get current connected WiFi SSID
SSID=$(iwgetid -r)

if [ "$SSID" != "$WIFI_NAME" ]; then
    echo "$TIMESTAMP Not connected to $WIFI_NAME. Current SSID: $SSID" >> "$LOG_FILE"
    exit 0
fi

# Check if we have working internet access
if ping -c 1 -W 1 1.1.1.1 > /dev/null 2>&1; then
    echo "$TIMESTAMP Connected to $WIFI_NAME and internet is working. No action needed." >> "$LOG_FILE"
else
    echo "$TIMESTAMP Connected to $WIFI_NAME but no internet. Running login script..." >> "$LOG_FILE"
    python3 "$PYTHON_SCRIPT_PATH" >> "$LOG_FILE" 2>&1
    echo "$TIMESTAMP Login script ran successfully." >> "$LOG_FILE"
fi

# --- Log rotation: keep only last 200 lines ---
tail -n 200 "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
