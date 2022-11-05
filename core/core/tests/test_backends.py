import pytest
from core.backends import CognitoBackend
from apps.user.factories import UserFactory
from core.settings import logger

@pytest.mark.django_db
def test_backends_cognito_user_exists():

    backend = CognitoBackend()

    email = "admin@example.com"
    password = "p3s8Word_123"

    UserFactory.create(email=email, password=password, is_active=True)

    user = backend.authenticate(request=None, username=email, password=password)

    assert user is not None

###########################################
### TODO Raise a pytest.raise Exception ###
###########################################

# @pytest.mark.django_db
# def test_backends_cognito_user_not_exists():
#     backend = CognitoBackend()
#
#     email = "admin@example.com"
#     password = "admin"
#
#     UserFactory.create(email=email, password=password, is_active=True)
#
#     user = backend.authenticate(request=None, username=email, password=password)
#
#     # assert user is None
#
#
