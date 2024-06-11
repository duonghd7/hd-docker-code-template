FROM --platform=linux/amd64 node:18

#create app directory
WORKDIR /app

# install dependencies 
# A Wildcard to make sure that we will copy both package.json and package-lock.json
COPY package*.json /app/
COPY yarn.lock /app/

RUN yarn install

# Bundle app source
COPY . . 

EXPOSE 8080
CMD ["yarn", "start"]