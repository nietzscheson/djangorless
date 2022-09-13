FROM python:3.9

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_STORAGE_BUCKET_NAME
ARG USE_S3

ENV PYTHONUNBUFFERED 1
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV AWS_STORAGE_BUCKET_NAME=$AWS_STORAGE_BUCKET_NAME
ENV USE_S3=$USE_S3

RUN apt-get update && apt-get install -y --no-install-recommends \
  gcc \
  g++ \
  make \
  cmake \
  unzip \
  libcurl4-openssl-dev

COPY requirements.txt  .
RUN  pip3 install -r requirements.txt

RUN useradd --create-home core
WORKDIR /home/core
USER core

COPY . ./

ENTRYPOINT [ "sh", "./entrypoint.sh" ]

CMD [ "handler.handler" ]
