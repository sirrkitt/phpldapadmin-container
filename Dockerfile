FROM nginx/unit:1.16.0-php7.3
COPY config.json config.json
COPY entrypoint.sh entrypoint.sh
ADD https://github.com/leenooks/phpLDAPadmin/archive/1.2.5.tar.gz /
RUN tar xf /1.2.5.tar.gz
RUN rm 1.2.5.tar.gz
RUN mv phpLDAPadmin-1.2.5/config/config.php.example /config.php.example
RUN mv phpLDAPadmin-1.2.5 /www
RUN mkdir /config
RUN chmod +x /entrypoint.sh
VOLUME /config

ENTRYPOINT entrypoint.sh

EXPOSE 8080
