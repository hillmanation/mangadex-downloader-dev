FROM python:3.11-alpine

COPY . /app
WORKDIR /app

# Setup dependencies for the downloader and Tor
RUN apk add --no-cache \
    jpeg-dev \
    zlib-dev \
    build-base \
    python3-dev \
    freetype-dev \
    tor \
    torsocks

# Install mangadex-downloader
RUN pip install --upgrade pip
RUN pip install .

# Configure Tor (opens SOCKS proxy on port 9050)
RUN echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc

# Expose the Tor SOCKS port
EXPOSE 9050

WORKDIR /downloads

# Start Tor in the background and then run the downloader
ENTRYPOINT [ "sh", "-c", "tor & mangadex-downloader" ]

CMD [ "--help" ]