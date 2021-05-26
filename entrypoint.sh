#!/bin/sh
if [ -z "${AWS_LAMBDA_RUNTIME_API}" ]; then
    exec "$@"
else
    exec /usr/local/bin/python -m awslambdaric $1
fi
