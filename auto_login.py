from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.common.exceptions import NoSuchElementException, WebDriverException
import time

# Configure headless Firefox
options = Options()
options.add_argument("--headless")

try:
    driver = webdriver.Firefox(options=options)

    # Open the captive portal login page
    driver.get("http://neverssl.com")  # This triggers captive portals to redirect
    time.sleep(3)  # Wait for redirect and page to load

    try:
        # Find and click the terms acceptance checkbox
        checkbox = driver.find_element("id", "ID_formc96db8bd_weblogin_visitor_accept_terms")
        checkbox.click()

        # Wait for the login button to become enabled (it may depend on JS)
        time.sleep(1)

        # Find and click the login button
        login_button = driver.find_element("id", "ID_formc96db8bd_weblogin_submit")
        login_button.click()

        print("[SUCCESS] Login form submitted.")
    except NoSuchElementException as e:
        print(f"[ERROR] Login failed: {e}")

except WebDriverException as e:
    print(f"[FATAL] Could not launch Firefox WebDriver: {e}")

finally:
    try:
        driver.quit()
    except:
        pass
