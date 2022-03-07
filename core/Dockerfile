FROM python:3.9

RUN pip3 install --no-cache-dir --upgrade pip

WORKDIR /app

RUN pip install awscli --upgrade --user --no-warn-script-location

RUN apt update && apt install nodejs npm -y

RUN npm install -g serverless

RUN cp /root/.local/bin/aws /usr/bin/aws && chmod -R a+w /usr/bin/aws

COPY requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt

### Django
ARG USE_ADMIN
### AWS
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_STORAGE_BUCKET_NAME
ARG USE_S3
### Database
ARG DATABASE_NAME
ARG DATABASE_USER
ARG DATABASE_PASS
ARG DATABASE_HOST
ARG DATABASE_PORT

ENV PYTHONUNBUFFERED 1
### Django
ENV USE_ADMIN=$USE_ADMIN
### AWS
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV AWS_STORAGE_BUCKET_NAME=$AWS_STORAGE_BUCKET_NAME
ENV USE_S3=$USE_S3
### Database
ENV DATABASE_NAME=$DATABASE_NAME
ENV DATABASE_USER=$DATABASE_USER
ENV DATABASE_PASS=$DATABASE_PASS
ENV DATABASE_HOST=$DATABASE_HOST
ENV DATABASE_PORT=$DATABASE_PORT

COPY . ./

RUN chmod 755 entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "handler.handler" ]
