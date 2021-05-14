FROM public.ecr.aws/lambda/python:3.8

RUN yum install -y python-pip python-devel postgresql-server postgresql-devel postgresql-contrib gcc

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD ["app.handler"]