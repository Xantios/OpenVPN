#!/bin/bash

docker volume create ovpnkeys
docker build . -t vpnserver/2.0
docker rm -f openvpn
docker run --restart=always --name openvpn -v ovpnkeys:/etc/openvpn/keys -p 1194:1194/tcp --cap-add=NET_ADMIN --device=/dev/net/tun -t vpnserver/2.0
