FROM python:3.10

WORKDIR /app

COPY requirements.txt .

RUN pip3 install -r requirements.txt --verbose

COPY . .

EXPOSE 8080

CMD [ "python3", "app.py" ]