from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException, TimeoutException, WebDriverException
import time
import sys

# Setup headless Firefox
options = Options()
options.headless = True

try:
    print("[INFO] Launching Firefox in headless mode...")
    driver = webdriver.Firefox(options=options)

    print("[INFO] Trying to load a redirect-trigger page (neverssl.com)...")
    driver.set_page_load_timeout(30)
    driver.get("http://neverssl.com")  # This should trigger captive portal redirect
    time.sleep(5)

    print("[INFO] Looking for checkbox element...")
    checkbox = driver.find_element(By.ID, "ID_formc96db8bd_weblogin_visitor_accept_terms")
    checkbox.click()
    print("[INFO] Terms checkbox clicked.")

    print("[INFO] Looking for login button...")
    login_button = driver.find_element(By.ID, "ID_formc96db8bd_weblogin_submit")
    login_button.click()
    print("[INFO] Login button clicked.")

    time.sleep(3)
    print("[SUCCESS] Captive portal login completed.")

except NoSuchElementException as e:
    print("[ERROR] Could not find a required element on the page:", e)
except TimeoutException:
    print("[ERROR] Page load timed out.")
except WebDriverException as e:
    print("[ERROR] WebDriver exception occurred:", e)
except Exception as e:
    print("[ERROR] An unexpected error occurred:", e)
finally:
    print("[INFO] Closing Firefox browser...")
    try:
        driver.quit()
    except Exception:
        print("[WARN] Failed to close the browser properly.")
    sys.exit()