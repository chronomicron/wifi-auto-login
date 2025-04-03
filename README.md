# WiFi Auto Login Script

This project automates logging into the `ccomtlGuest` WiFi network on Ubuntu, bypassing the captive portal login page automatically.

## Features
- Detects connection to the WiFi network
- Automates login by accepting terms and clicking the login button
- Runs periodically using a cron job

## Tools Used
- **Python** – Main scripting language
- **Selenium** – Automates browser interactions
- **Requests** – Handles network requests
- **Cron** – Runs the script automatically

## Setup
1. Install dependencies:  
   ```bash
   pip install selenium requests
