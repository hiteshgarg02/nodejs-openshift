FROM openshift/origin-node:v3.11.0
ENV PORT=3080
EXPOSE 3080
WORKDIR /app
COPY . /app
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y nodejs
RUN npm install
CMD [ "npm", "start"]
