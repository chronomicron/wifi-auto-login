# WiFi Auto-Login Script (Ubuntu)

This project allows your Ubuntu machine to automatically log into a WiFi network that uses a captive portal (web-based login screen), like the network `ccomtlGuest`. Once you're connected, the script checks for internet access and performs an automatic login if needed.

---

## 🔧 Tools Used
- **Bash**: Used for network detection and automation logic.
- **Python + Selenium**: Automates the captive portal interaction (accepts checkbox, clicks login).
- **Cron**: Schedules the automation to run every minute.

---

## 📁 Folder Structure
```
wifi-auto-login/
│
├── check_wifi_and_login.sh       # Main bash script run by cron
├── auto_login.py                 # Python Selenium script for portal login
├── login_page.html               # Sample captive portal page (optional)
├── logs/
│   └── wifi_auto_login.log       # Rotating logs of connection attempts
└── README.md                     # This file
```

---

## 🧠 How It Works

1. **The Cron Job** runs every minute.
2. It checks if you're connected to the target WiFi network (`ccomtlGuest`).
3. It then pings `8.8.8.8` to check for internet access.
4. If there is no internet, it launches the `auto_login.py` script.
5. The Python script uses Selenium to:
   - Open the captive portal page.
   - Click the "I accept" checkbox.
   - Click the "Log In" button.
6. All actions are logged, but the log is rotated to prevent bloating.

---

## ✅ Setup Instructions

### 1. Clone the Repo & Enter the Directory
```bash
git clone git@github.com:yourusername/wifi-auto-login.git
cd wifi-auto-login
```

### 2. Install Required Packages

Ensure `selenium` and `chromium-driver` are installed:
```bash
sudo apt update
sudo apt install python3-pip chromium-chromedriver -y
pip3 install selenium
```

> 💡 You may also need to install `cron` if it's not already installed:
```bash
sudo apt install cron
```

---

### 3. Make the Bash Script Executable

```bash
chmod +x check_wifi_and_login.sh
```

---

### 4. Set Up Cron Job

Open the cron editor:
```bash
crontab -e
```

Add the following line at the end (update the path as needed):
```cron
* * * * * /home/yourusername/path/to/wifi-auto-login/check_wifi_and_login.sh
```

This runs the script every minute.

---

### 5. (Optional) Check Cron Logs

If something isn't working, you can inspect cron logs:
```bash
grep CRON /var/log/syslog
```

---

## 🪵 Logging

Logs are written to `logs/wifi_auto_login.log`. The script will:
- Write a new entry **only when a login is attempted** or an error occurs.
- **Automatically rotate** the log file when it exceeds 1MB:
  - Old logs are saved as `wifi_auto_login.log.1`, `.2`, etc.
  - Keeps up to 5 log files (configurable).

You don’t need to clean the logs manually.

---

## 🛠️ Debugging Tips

- If cron reports `Permission denied`, run:
  ```bash
  chmod +x check_wifi_and_login.sh
  ```
- Ensure that the full path to the Python script and Chrome driver are correct.
- Always test the Python script independently first:
  ```bash
  python3 auto_login.py
  ```

---

## 💬 Future Improvements

- Detect and support more networks
- GUI setup wizard for easy onboarding
- Optional notification if login fails repeatedly