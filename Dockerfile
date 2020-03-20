FROM nginx/unit:1.16.0-php7.3

RUN apt update &&\
	apt install php7.3-ldap php7.3-xml php7.3-xmlrpc &&\
	rm -rf /var/lib/apt/lists/*

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

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080
