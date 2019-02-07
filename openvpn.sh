#!/bin/bash

docker volume create ovpnkeys
docker build . -t vpnserver/1.0
docker run --restart=always --name openvpn -d -v ovpnkeys:/etc/openvpn/keys -p 1194:1194/tcp --cap-add=NET_ADMIN -t vpnserver/1.0
