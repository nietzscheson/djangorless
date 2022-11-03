import factory
from django.contrib.auth import get_user_model

from django.db.models.signals import post_save

from faker import Faker

fake = Faker()


@factory.django.mute_signals(post_save)
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
