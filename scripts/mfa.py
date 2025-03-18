import pyotp
from selenium.webdriver.common.by import By

def get_totp(secret):
    """Generates a TOTP (One-Time Password) using the secret key."""
    return pyotp.TOTP(secret).now()

def extract_totp_secret(driver):
    """Extracts the TOTP secret key during Salesforce MFA setup."""
    try:
        secret_element = driver.find_element(By.XPATH, "//div[contains(@class, 'mfa-qr-code')]/following-sibling::p")
        secret_key = secret_element.text.split()[-1]  # Extract key from text
        print(f"Extracted Secret Key: {secret_key}")
        return secret_key
    except:
        print("Failed to extract TOTP secret key.")
        return None
