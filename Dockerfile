FROM node:12.13-alpine As development

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:12.13-alpine as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY package*.json ./

RUN npm install 

# COPY . .

# RUN npm run build

COPY --from=development /app/dist ./dist

CMD ["node", "./dist"]

# FROM node:12.13-alpine
# WORKDIR /app
# ADD package.json /app/package.json
# RUN npm install
# RUN npm run build
# ADD . /app
# COPY  /app/dist ./dist
# # EXPOSE 8080
# CMD ["node", "dist"]