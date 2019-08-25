FROM node:8.2
ENV PORT=8080
EXPOSE 8080
WORKDIR /app
COPY . /app
RUN npm install
CMD [ "npm", "start"]
