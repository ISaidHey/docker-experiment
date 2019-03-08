FROM nginx:latest

# Create sites-enabled directory
RUN mkdir /etc/nginx/sites-enabled

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY templates/ /etc/nginx/sites-templates/
COPY docker-entrypoint.sh /docker-entrypoint.sh

# Make the entrypoint executable.
RUN chmod +x /docker-entrypoint.sh

VOLUME /code

CMD ["/bin/bash", "-c", "/docker-entrypoint.sh"]
