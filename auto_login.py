from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.by import By
import time

# Setup headless Firefox
options = Options()
options.headless = True

try:
    print("[INFO] Starting Firefox in headless mode...")
    driver = webdriver.Firefox(options=options)

    print("[INFO] Opening captive portal login page...")
    driver.get("http://neverssl.com")  # Trigger redirect to captive portal

    time.sleep(3)  # Allow time for redirect

    # Tick the checkbox for accepting terms
    checkbox = driver.find_element(By.ID, "ID_formc96db8bd_weblogin_visitor_accept_terms")
    checkbox.click()
    print("[INFO] Checked the terms checkbox.")

    # Click the "Log In" button
    login_button = driver.find_element(By.ID, "ID_formc96db8bd_weblogin_submit")
    login_button.click()
    print("[INFO] Clicked the login button.")

    time.sleep(2)  # Allow some time for the login to complete
    print("[INFO] Login should be complete.")

except Exception as e:
    print(f"[ERROR] Login failed: {e}")

finally:
    driver.quit()
