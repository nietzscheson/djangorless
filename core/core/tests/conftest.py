import pytest
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

@pytest.fixture
def selenium(selenium):

    selenium.implicitly_wait(10)
    selenium.maximize_window()

    return selenium
