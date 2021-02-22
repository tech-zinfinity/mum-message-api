FROM node:10-alpine As development
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:10-alpine as production
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /app
COPY package*.json ./
RUN npm install 
COPY . .
COPY --from=development /app/dist ./dist
CMD ["node", "dist/main.js"]

# FROM node:10 AS builder
# WORKDIR /app
# COPY ./package.json ./
# RUN npm install
# COPY . .
# RUN npm run build


# FROM node:10-alpine
# WORKDIR /app
# COPY --from=builder /app ./
# CMD ["npm", "run", "start:prod"]