FROM python:3.8-alpine

ENV PYTHONUNBUFFERED 1

RUN apk add --no-cache --virtual .build-deps \
    nodejs yarn nodejs-npm \ 
    && rm -rf /var/cache/apk/*

RUN yarn global add serverless@2.41.1 serverless-python-requirements@5.1.1 serverless-wsgi@1.7.7 -g

RUN pip3 install --upgrade pip

RUN pip3 install awscli --upgrade --user --no-warn-script-location

RUN cp /root/.local/bin/aws /usr/bin/aws && chmod -R a+w /usr/bin/aws

COPY requirements.txt .

RUN pip install -r requirements.txt
