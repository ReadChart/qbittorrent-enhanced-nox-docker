FROM qbittorrentofficial/qbittorrent-nox:latest
# Install necessary tools
RUN apk update && apk add curl jq unzip

# Fetch the latest release tag from GitHub API
RUN LATEST_TAG=$(curl -s https://api.github.com/repos/c0re100/qBittorrent-Enhanced-Edition/releases/latest | jq -r .tag_name) && \
    wget https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/download/${LATEST_TAG}/qbittorrent-enhanced-nox_x86_64-linux-musl_static.zip -O /usr/bin/qbittorrent-enhanced-nox.zip

# Unzip and replace the existing qbittorrent-nox binary
RUN rm -rf /usr/bin/qbittorrent-nox && \
    unzip /usr/bin/qbittorrent-enhanced-nox.zip -d /usr/bin && \
    chmod +x /usr/bin/qbittorrent-nox

# Clean up
RUN apk del unzip jq curl && \
    rm -rf /var/cache/apk/* /usr/bin/qbittorrent-enhanced-nox.zip
