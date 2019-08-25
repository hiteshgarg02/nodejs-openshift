FROM openshift/origin-node:v3.11.0
ENV PORT=3080
EXPOSE 3080
WORKDIR /app
COPY . /app
RUN npm install
CMD [ "npm", "start"]
