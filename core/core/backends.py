from django.contrib.auth.backends import ModelBackend, AllowAllUsersModelBackend
from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import check_password
from core.services.cognito import CognitoService
from core.settings import logger

UserModel = get_user_model()

class CognitoBackend(ModelBackend):
    def authenticate(self, request, username=None, password=None, **kwargs):

        if username is None:
            username = kwargs.get(UserModel.USERNAME_FIELD)
        if username is None or password is None:
            return

        try:
            user = UserModel._default_manager.get_by_natural_key(username)
            cognito = CognitoService(username=user.email)
            cognito.authenticate(password=password)

            if cognito.id_token is None:
                raise get_user_model().DoesNotExist()
        except UserModel.DoesNotExist:
            # Run the default password hasher once to reduce the timing
            # difference between an existing and a nonexistent user (#20760).
            UserModel().set_password(password)
        else:
            if user.check_password(password) and self.user_can_authenticate(user):
                return user

#     def authenticate(self, request, email=None, password=None):
#         user = get_user_model().objects.get(email=email)
#         verify_password = check_password(password, user.password)
#
#         if user and verify_password:
#             try:
#                 cognito = CognitoService(username=user.email)
#                 cognito.authenticate(password=password)
#                 if cognito.id_token is None:
#                     raise get_user_model().DoesNotExist()
#             except Exception:
#                 return
#             return user
#
#     def get_user(self, user_id):
#         try:
#             return get_user_model().objects.get(pk=user_id)
#         except get_user_model.DoesNotExist:
#             return None
#
