FROM nginx:latest
# Take the war and copy to webapps of tomcat
COPY index.html /usr/share/nginx/html/index.html
