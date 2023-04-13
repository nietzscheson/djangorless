import pytest
from urllib.parse import urlparse
import time
from selenium.webdriver.common.by import By
from apps.user.factories import UserFactory
from django.urls import reverse


def test_backends_cognito_user_exists(selenium, live_server):

    """
    As a superuser with valid credentials, I should gain
    access to the Django admin.
    """

    email = "admin@example.com"
    password = "p3s8Word_123"

    user = UserFactory.create(email=email, password=password, is_active=True, is_staff=True)

    print(user)
#    selenium.get(live_server + reverse("admin:index"))
#
#    selenium.find_element(By.NAME, "username").send_keys(email)
#    selenium.find_element(By.NAME, "password").send_keys(password)
#    selenium.find_element(By.XPATH, '//input[@value="Log in"]').click()
#
#    assert selenium.title == "Site administration | Django site admin"
#
#    path = urlparse(selenium.current_url).path
#
#    assert reverse("admin:index") == path
#
#    body_text = selenium.find_element(By.TAG_NAME, "body").text
#
#    assert f"WELCOME, {str(user.email).upper()}." in body_text

