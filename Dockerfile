FROM alpine:3.7

RUN apk update ; apk add openvpn git bash openssl vim iptables
RUN git clone https://github.com/OpenVPN/easy-rsa.git /usr/share/easy-rsa

COPY files/keys.sh /keys.sh
COPY files/server.conf /etc/openvpn/openvpn.conf
COPY files/startserver.sh /startserver.sh

RUN chmod +x /keys.sh /startserver.sh
RUN /keys.sh

EXPOSE 1194/tcp

CMD "/startserver.sh"
