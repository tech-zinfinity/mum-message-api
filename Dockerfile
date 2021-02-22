# FROM node:12.13-alpine As development

# WORKDIR /app

# COPY package*.json ./

# RUN npm install --only=development

# COPY . .

# RUN npm run build

# FROM node:12.13-alpine as production

# ARG NODE_ENV=production
# ENV NODE_ENV=${NODE_ENV}

# WORKDIR /app

# COPY package*.json ./

# RUN npm install --only=production

# COPY . .

# COPY --from=development /app/dist ./dist

# CMD ["node", "dist"]

FROM node:12
WORKDIR /app
ADD package.json /app/package.json
RUN npm install
ADD . /app
EXPOSE 8080
CMD ["npm", "run", "start"]