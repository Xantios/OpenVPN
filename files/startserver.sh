#!/bin/bash

mkdir -p /dev/net
mknod /dev/net/tun c 10 200
iptables -t nat -A POSTROUTING -s 10.10.20.0/24 -o eth0 -j MASQUERADE

openvpn --config /etc/openvpn/openvpn.conf
