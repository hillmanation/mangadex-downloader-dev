FROM python:3.11-alpine

COPY . /app
WORKDIR /app

# Setup dependencies including curl
RUN apk add --no-cache \
    jpeg-dev \
    zlib-dev \
    build-base \
    python3-dev \
    freetype-dev \
    curl

# Install mangadex-downloader
RUN pip install --upgrade pip
RUN pip install .

WORKDIR /downloads

ENTRYPOINT [ "mangadex-downloader" ]

CMD [ "--help" ]