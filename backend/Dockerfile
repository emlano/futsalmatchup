FROM node:21
WORKDIR /app

COPY ./package* /app

RUN npm ci

COPY . /app

EXPOSE 3000

CMD ["npm", "start"]
