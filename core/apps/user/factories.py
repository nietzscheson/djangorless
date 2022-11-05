from unicodedata import name
import factory
from django.contrib.auth import get_user_model
# from pytest_factoryboy import register

from django.db.models.signals import post_save

from faker import Faker

fake = Faker()

# @register(name="user_factory")
# @factory.django.mute_signals(post_save)
class UserFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = get_user_model()

    _PASSWORD = "password123!"
    _COMMON_PASSWORD = "password123"

    password = factory.PostGenerationMethodCall("set_password", _PASSWORD)
    email = factory.Faker("email")
    is_active = False
    is_staff = False
    is_superuser = False
