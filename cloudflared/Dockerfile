FROM --platform=linux/amd64 ubuntu

RUN apt-get update && \
        apt-get install -y \
            dnsutils \
            wget && \
        wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
        dpkg -i ./cloudflared-linux-amd64.deb && \
        rm cloudflared-linux-amd64.deb && \
        mkdir -p /etc/cloudflared && \
        echo ' \n\
proxy-dns: true \n\
proxy-dns-port: 5353 \n\
proxy-dns-upstream: \n\
  - https://1.1.1.1/dns-query \n\
  - https://1.0.0.1/dns-query' > /etc/cloudflared/config.yml

EXPOSE 5353 5353/udp

CMD ["cloudflared"]
