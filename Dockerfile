# build phase
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# launch phase
FROM nginx

# --from=build: indicates copying from the build phase
# static service from: /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
