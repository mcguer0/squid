FROM ubuntu:20.04

# Install Squid and generate SSL certificates
ENV TZ="Europe/Moscow"
RUN apt-get update && apt-get install -y squid openssl
RUN mkdir /etc/squid/ssl
WORKDIR /etc/squid/ssl
RUN openssl genrsa -out squid.key 2048
RUN openssl req -new -key squid.key -out squid.csr -subj "/C=XX/ST=XX/L=squid/O=squid/CN=squid"
RUN openssl x509 -req -days 3650 -in squid.csr -signkey squid.key -out squid.crt
RUN cat squid.key squid.crt | tee squid.pem

# Configure Squid
COPY squid.conf /etc/squid/squid.conf
RUN chmod 644 /etc/squid/squid.conf

# Start Squid
CMD ["squid", "-NYCd", "1"]
