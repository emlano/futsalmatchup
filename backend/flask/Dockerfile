FROM python:3.10

WORKDIR /app

COPY requirements.txt /app

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . ./app

EXPOSE 8080

CMD [ "python3", "-m", "flask", "run", "--host=0.0.0.0", "--port=8080" ]