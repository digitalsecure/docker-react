#
# Building phase
#
FROM node:alpine 
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build


#
# Deployment phase
#
FROM nginx 

# EXPOSE is required explicitly for AWS Beanstalk to expose port 80 in the container for
# connection from the host. Under normal circumstances, this is not required
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
