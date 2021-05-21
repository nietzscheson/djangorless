#!/bin/sh
if [ -z "${AWS_LAMBDA_RUNTIME_API}" ]; then
    exec /usr/local/bin/python manage.py runserver 0:8000
else
    exec /usr/local/bin/python -m awslambdaric $1
fi
