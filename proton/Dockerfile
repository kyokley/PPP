FROM python:3.10-alpine
# protonvpn-cli needs access to width
ENV COLUMNS 80

ARG PROTONVPN_USER PROTONVPN_PASSWORD PROTONVPN_PLAN=2 PROTONVPN_PROTOCOL=1

RUN apk update && apk add --no-cache curl openvpn expect iptables && \
    pip install protonvpn-cli

COPY ./vpn-setup.exp /tmp/

RUN expect /tmp/vpn-setup.exp && \
    rm /tmp/vpn-setup.exp

RUN sed -i 's/killswitch.*/killswitch = 2/' /root/.pvpn-cli/pvpn-cli.cfg
RUN sed -i 's/dns_leak_protection.*/dns_leak_protection = 0/' /root/.pvpn-cli/pvpn-cli.cfg
RUN sed -i 's/custom_dns.*/custom_dns = 172.20.128.3/' /root/.pvpn-cli/pvpn-cli.cfg

CMD ["/bin/sh"]
