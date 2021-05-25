FROM python:3.8

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_STORAGE_BUCKET_NAME
ARG USE_S3

ENV PYTHONUNBUFFERED 1
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV AWS_STORAGE_BUCKET_NAME=$AWS_STORAGE_BUCKET_NAME
ENV USE_S3=$USE_S3

RUN pip3 install --no-cache-dir --upgrade pip

WORKDIR /app

COPY requirements.txt .

RUN pip install awslambdaric

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod 755 entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "handler.handler" ]