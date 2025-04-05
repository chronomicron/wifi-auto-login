# WiFi Auto-Login System for Captive Portals

This project enables a Raspberry Pi or Ubuntu-based system to automatically log in to a WiFi captive portal (e.g., `ccomtlGuest`) without any user interaction.

---

## Features

- Automatically detects when connected to the specified WiFi SSID.
- Checks for internet access.
- If connected but no internet, triggers a Python script to accept the captive portal terms and log in.
- Keeps a rotating log of the last 200 status messages.
- Cron job runs silently every minute.

---

## Requirements

- Python 3
- `nmcli` (usually installed on Ubuntu)
- `ping`
- Raspberry Pi or any Ubuntu-based Linux system
- NetworkManager (used by `nmcli`)

---

## Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/wifi-auto-login.git
cd wifi-auto-login
```

### 2. Modify the configuration

Edit `check_wifi_and_login.sh`:

- Set the correct WiFi SSID:
  ```bash
  TARGET_SSID="ccomtlGuest"
  ```
- Set the full path to your `auto_login.py` script:
  ```bash
  PYTHON_SCRIPT_PATH="/home/grou/workspace/wifi-auto-login/auto_login.py"
  ```

Make the script executable:

```bash
chmod +x check_wifi_and_login.sh
```

### 3. Set up the cron job

Open the crontab editor:

```bash
crontab -e
```

Add the following line to run the script every minute:

```cron
* * * * * /home/grou/workspace/wifi-auto-login/check_wifi_and_login.sh
```

Make sure the path is correct.

### 4. Verify it's working

You can view the log output with:

```bash
tail -f /home/grou/workspace/wifi-auto-login/wifi_login.log
```

It will show messages like:

```
[2025-04-05 17:18:01] Connected to ccomtlGuest but no internet. Running login script...
[2025-04-05 17:18:01] Login script ran successfully.
```

---

## License

MIT License. Feel free to modify and reuse.

## Contributions

Pull requests welcome if you improve the robustness or add support for new types of portals!
