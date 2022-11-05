from core.settings import COGNITO_USER_POOL_ID, COGNITO_CLIENT_ID, COGNITO_CLIENT_SECRET
from pycognito import Cognito

class CognitoService(object):

    def __new__(cls, **kwargs):
        cognito = Cognito(COGNITO_USER_POOL_ID, COGNITO_CLIENT_ID, client_secret=COGNITO_CLIENT_SECRET, **kwargs)
        return cognito
