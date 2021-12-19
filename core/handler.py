from core.wsgi import application
import serverless_wsgi
import os


def handler(event, context):
    return serverless_wsgi.handle_request(application, event, context)
