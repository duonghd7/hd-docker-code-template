FROM --platform=linux/amd64 node:20

#create app directory
WORKDIR /app

# Bundle app source
COPY . . 
RUN rm -rf .env
RUN rm -rf .git
RUN rm -rf k8s
RUN rm -rf node_modules
RUN yarn install

EXPOSE 8080
CMD ["yarn", "start:eks"]