from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import time

# Launch headless Chrome
options = Options()
options.add_argument("--headless")
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1920x1080")

driver = webdriver.Chrome(options=options)

try:
    # Attempt to trigger the captive portal page
    driver.get("http://neverssl.com")  # Will redirect to captive portal if not authenticated

    time.sleep(3)  # Give it a moment to redirect and render

    # Try to find and click the checkbox (label may vary)
    checkbox = driver.find_element(By.ID, "checkbox")  # <-- placeholder, we'll need to adjust based on real HTML
    checkbox.click()

    time.sleep(1)

    # Find and click the login/submit button
    login_btn = driver.find_element(By.ID, "submitBtn")  # <-- placeholder, update based on HTML
    login_btn.click()

    print("Successfully logged in through captive portal.")

except Exception as e:
    print(f"Error during login process: {e}")

finally:
    driver.quit()
