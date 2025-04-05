# 📡 WiFi Auto Login for Captive Portals (Ubuntu / Raspberry Pi)

This project automates login to public WiFi networks with captive portals (e.g., "ccomtlGuest"). It automatically accepts terms and clicks the "Log In" button using a headless browser (Firefox), so your Raspberry Pi or Ubuntu machine can get online without manual input.
Remember to replace YOUR_USERNAME with your own local path!
happened to me more than once!
---

## ✅ Features

- Detects WiFi connection to a specified SSID.
- Checks for working internet access.
- Auto-opens the captive portal page and logs in.
- Headless operation via Firefox and Selenium.
- Smart logging with automatic pruning (keeps last 200 lines).
- Designed to run as a cron job every minute.

---

## 📦 Requirements

### 1. System Requirements
- Ubuntu or Raspberry Pi OS
- Firefox browser installed
- Internet access (for initial setup)

### 2. Python Dependencies

Install Python packages:

```bash
pip install selenium
3. Geckodriver (for Firefox automation)
Install using apt:

bash
Copy
Edit
sudo apt install firefox-geckodriver
Or manually download from:
https://github.com/mozilla/geckodriver/releases

🔧 Installation & Setup
1. Clone the Repository
bash
Copy
Edit
git clone https://github.com/chronomicron/wifi-auto-login.git
cd wifi-auto-login
2. Configure WiFi SSID and Paths
Edit the file check_wifi_and_login.sh:

bash
Copy
Edit
nano check_wifi_and_login.sh
Update these variables at the top:

bash
Copy
Edit
WIFI_NAME="ccomtlGuest"
LOG_FILE="/home/YOUR_USERNAME/wifi-auto-login/wifi_login.log"
PYTHON_SCRIPT_PATH="/home/YOUR_USERNAME/wifi-auto-login/auto_login.py"
Replace /home/YOUR_USERNAME/ with your actual path.

Make the script executable:

bash
Copy
Edit
chmod +x check_wifi_and_login.sh
🕒 Setup Cron Job
Edit your crontab:

bash
Copy
Edit
crontab -e
Add the following line to run the script every minute:

bash
Copy
Edit
* * * * * /home/YOUR_USERNAME/wifi-auto-login/check_wifi_and_login.sh
Replace the path as needed. Save and exit the editor.

🧠 How It Works
Every minute, the cron job runs the bash script.

The script checks if the device is connected to the specified WiFi SSID.

It then checks if the internet is accessible via ping.

If there's no internet, it triggers auto_login.py.

The Python script uses Selenium with Firefox to:

Open http://neverssl.com (to force captive portal redirect).

Tick the “I accept terms” checkbox.

Click the "Log In" button.

Logs are written to wifi_login.log and automatically pruned.

📄 Log File
Located at the path you specified (wifi_login.log).

Keeps the last 200 lines only.

Sample log output:

text
Copy
Edit
[2025-04-05 17:14:27] Not connected to ccomtlGuest. Current SSID: Meguro
[2025-04-05 17:18:01] Connected to ccomtlGuest but no internet. Running login script...
[2025-04-05 17:18:01] Login form submitted.
[2025-04-05 17:22:01] Connected to ccomtlGuest and internet is working. No action needed.
🧪 Testing
Disconnect from all networks.

Connect manually to the target WiFi (e.g., ccomtlGuest) — but don’t log in via the portal.

The system should detect the lack of internet and run the auto-login script.

Check your log output:

bash
Copy
Edit
tail -f wifi_login.log
💡 Tips
Use a Raspberry Pi with an external USB WiFi adapter for better compatibility.

To test the captive portal trigger manually, visit http://neverssl.com.

If the portal layout changes, update the element IDs in auto_login.py.

🛠 Troubleshooting
Geckodriver errors: Ensure Firefox and geckodriver versions are compatible.

Element not found: Confirm the checkbox and button IDs match the HTML of the login page.

No login triggered: Make sure the script runs with the correct permissions.

🤖 License
MIT License. Do what you want, but no guarantees!

👤 Author
Created by Robert Grou
Forks and contributions welcome!