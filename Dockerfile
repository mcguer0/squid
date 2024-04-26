FROM debian:bullseye

# Install Squid
ENV TZ=Europe/Moscow
RUN apt-get update && apt-get install -y tzdata squid

# Configure Squid
COPY squid.conf /etc/squid/squid.conf
RUN chmod 644 /etc/squid/squid.conf

# Start Squid
CMD ["squid", "-NYCd", "1"]
