from email.mime import base
import pytest
import time
from selenium.webdriver.common.by import By
from apps.user.factories import UserFactory

@pytest.mark.django_db(transaction=True)
@pytest.mark.selenium
def test_backends_cognito_user_exists(selenium, live_server, base_url):

    """
    As a superuser with valid credentials, I should gain
    access to the Django admin.
    """
    # selenium.get(live_server.url + "/admin")
    selenium.get("http://core:8000/admin")

    email = "admin@example.com"
    password = "p3s8Word_123"

    UserFactory.create(email=email, password=password)

    selenium.find_element(By.NAME, "username").send_keys(email)
    selenium.find_element(By.NAME, "password").send_keys(password)
    selenium.find_element(By.XPATH, '//input[@value="Log in"]').click()

    assert selenium.title == "Site administration | Django site admin"

