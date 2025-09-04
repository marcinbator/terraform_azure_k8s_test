FROM nginx:alpine

COPY index.html /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf.template
COPY configure.sh /docker-entrypoint.d/30-configure-frontend.sh

RUN chmod +x /docker-entrypoint.d/30-configure-frontend.sh

CMD ["nginx", "-g", "daemon off;"]
