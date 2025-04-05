from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import time

# Set up headless Chrome
options = Options()
options.add_argument("--headless")
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1920x1080")

driver = webdriver.Chrome(options=options)

try:
    # Step 1: Trigger captive portal
    driver.get("http://neverssl.com")
    time.sleep(5)  # Wait to ensure redirection completes

    # Step 2: Find and click the "I accept the terms" checkbox
    checkbox = driver.find_element(By.ID, "ID_formc96db8bd_weblogin_visitor_accept_terms")
    checkbox.click()
    time.sleep(1)

    # Step 3: Wait for submit button to become enabled
    submit_button = driver.find_element(By.ID, "ID_formc96db8bd_weblogin_submit")
    
    # We need to wait until it's no longer disabled
    attempts = 0
    while submit_button.get_attribute("disabled") and attempts < 10:
        time.sleep(1)
        submit_button = driver.find_element(By.ID, "ID_formc96db8bd_weblogin_submit")
        attempts += 1

    if submit_button.get_attribute("disabled"):
        raise Exception("Login button is still disabled after checking the box.")

    # Step 4: Click the submit button
    submit_button.click()
    print("[INFO] Successfully logged in through captive portal.")

except Exception as e:
    print(f"[ERROR] Login failed: {e}")

finally:
    driver.quit()
