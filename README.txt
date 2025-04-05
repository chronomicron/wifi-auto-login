WiFi Auto Login for Captive Portals on Ubuntu
=============================================

This project allows your Ubuntu system to automatically log in to a WiFi network
with a captive portal, such as a public guest network that requires clicking an
"I Accept" checkbox and a "Log In" button.

How It Works
------------
1. A bash script runs every minute via cron.
2. If you're connected to a specified WiFi network (e.g. "ccomtlGuest"), it checks
   if internet access is available (by pinging 8.8.8.8).
3. If no internet is available, a Python script (that you'll configure) auto-submits
   the captive portal login using browser automation (Selenium).

Setup Instructions
------------------

1. Clone this repository or create your local project folder.

2. Place `check_wifi_and_login.sh` in the project directory.

3. Make the script executable:

   ```bash
   chmod +x check_wifi_and_login.sh
