FROM debian:stretch

RUN apt-get update && \
    apt-get install -y wget curl gnupg fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libcairo2 libcups2 libdbus-1-3 libexpat1 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release xdg-utils && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

# Install latest stable Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb

# Install NodeJS 8 and Lighthouse Module
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN npm install -g lighthouse

# see https://github.com/carlesnunez/lighthouse-gh-reporter
RUN npm install -g lighthouse-gh-reporter

# see https://github.com/andreasonny83/lighthouse-ci
RUN npm install -g lighthouse-ci

ENTRYPOINT ["lighthouse"]
