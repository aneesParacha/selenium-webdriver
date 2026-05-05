FROM python:3.8-slim

WORKDIR /app

ENV CHROME_VERSION=147.0.7727.137

RUN apt update && apt install -y \
    wget \
    unzip \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    && wget https://storage.googleapis.com/chrome-for-testing-public/${CHROME_VERSION}/linux64/chrome-linux64.zip \
    && unzip chrome-linux64.zip \
    && mv chrome-linux64 /opt/chrome \
    && ln -s /opt/chrome/chrome /usr/bin/google-chrome \
    && wget https://storage.googleapis.com/chrome-for-testing-public/${CHROME_VERSION}/linux64/chromedriver-linux64.zip \
    && unzip chromedriver-linux64.zip \
    && mv chromedriver-linux64/chromedriver /usr/bin/chromedriver \
    && chmod +x /usr/bin/chromedriver \
    && pip install selenium \
    && rm -rf chrome-linux64.zip chromedriver-linux64.zip chromedriver-linux64 \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY firsttest.py .
COPY index.html .

CMD ["python", "firsttest.py"]
