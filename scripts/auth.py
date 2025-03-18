import time
from selenium import webdriver
from selenium.webdriver.common.by import By
import yaml

def load_config():
    """Load YAML configuration."""
    with open("config/creds.yaml", "r") as file:
        return yaml.safe_load(file)

config = load_config()

def login_salesforce():
    """Logs into Salesforce without MFA."""
    driver = webdriver.Chrome()
    driver.get("https://login.salesforce.com")

    # Enter username and password
    driver.find_element(By.ID, "username").send_keys(config["salesforce_username"])
    driver.find_element(By.ID, "password").send_keys(config["salesforce_password"])
    driver.find_element(By.ID, "Login").click()
    time.sleep(3)

    return driver