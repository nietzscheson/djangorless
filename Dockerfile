FROM python:3.8

ENV PYTHONUNBUFFERED 1

RUN pip3 install --no-cache-dir --upgrade pip

WORKDIR /app

COPY requirements.txt .

RUN pip install awslambdaric

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod 755 entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "handler.handler" ]