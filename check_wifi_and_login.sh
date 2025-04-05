#!/bin/bash

# -------------------------
# CONFIGURATION SECTION
# -------------------------

# Name of the WiFi network to check
WIFI_SSID="ccomtlGuest"

# Path to your Python auto-login script
PYTHON_SCRIPT_PATH="/home/grou/workspace/wifi-auto-login/auto_login.py"

# Path to the log file
LOG_FILE="/home/grou/workspace/wifi-auto-login/wifi_auto_login.log"

# Max lines to keep in the log file
MAX_LOG_LINES=200

# -------------------------
# FUNCTIONAL SECTION
# -------------------------

# Check if currently connected to the desired WiFi network
CURRENT_SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)

# Timestamp for log entries
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Function to log messages
log_message() {
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

# If connected to the desired SSID
if [ "$CURRENT_SSID" == "$WIFI_SSID" ]; then
    # Check if we have internet access by pinging Google DNS
    if ping -q -c 1 -W 2 8.8.8.8 > /dev/null; then
        log_message "Connected to $WIFI_SSID and internet is working. No action needed."
    else
        log_message "Connected to $WIFI_SSID but no internet. Running login script..."
        python3 "$PYTHON_SCRIPT_PATH"
        if [ $? -eq 0 ]; then
            log_message "Login script ran successfully."
        else
            log_message "Login script failed to run properly."
        fi
    fi
else
    log_message "Not connected to $WIFI_SSID. Current SSID: $CURRENT_SSID"
fi

# -------------------------
# LOG MAINTENANCE SECTION
# -------------------------

# Trim log file to last $MAX_LOG_LINES lines to avoid log bloat
tail -n "$MAX_LOG_LINES" "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
