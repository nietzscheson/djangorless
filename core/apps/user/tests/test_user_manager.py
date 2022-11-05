from apps.user.factories import UserFactory
from django.contrib.auth import get_user_model
import pytest

@pytest.mark.django_db
def test_create_user():
    """
    Method to show how create a User with the Manager
    """
    userFactory = UserFactory.build()

    User = get_user_model()
    user = User.objects.create_user(
        email=userFactory.email, password=userFactory.password
    )

    assert user.email == userFactory.email
    assert user.is_active == True
    assert user.is_staff == False
    assert user.is_superuser == False

    try:
        assert user.username == None
    except AttributeError:
        pass
    with pytest.raises(TypeError):
        User.objects.create_user()
    with pytest.raises(TypeError):
        User.objects.create_user(email="")
    with pytest.raises(ValueError):
        User.objects.create_user(email="", password="foo")

@pytest.mark.django_db
def test_create_superuser():
    """
    Method to show how create a Superuser with the Manager
    """
    userFactory = UserFactory.build()

    User = get_user_model()
    user = User.objects.create_superuser(
        email=userFactory.email, password=userFactory.password
    )

    assert user.email == userFactory.email
    assert user.is_active == True
    assert user.is_staff == True
    assert user.is_superuser == True

    try:
        assert user.username == None
    except AttributeError:
        pass
    with pytest.raises(ValueError):
        User.objects.create_superuser(
            email="super@user.com", password="foo", is_superuser=False)
