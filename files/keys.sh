#!/bin/bash

if [ -f /etc/openvpn/keys/ca.crt ]; then
	echo -e "\e[31mServer files exists. Skip building certificates.\e[0m"
else
	cd /usr/share/easy-rsa/easyrsa3/
	./easyrsa init-pki
	echo -en "\n" | ./easyrsa build-ca nopass
	./easyrsa gen-dh
	./easyrsa build-server-full server nopass
	openvpn --genkey --secret pki/ta.key

	mkdir -p /etc/openvpn/keys
	cp pki/ca.crt /etc/openvpn/keys
	cp pki/issued/server.crt /etc/openvpn/keys
	cp pki/private/server.key /etc/openvpn/keys
	cp pki/dh.pem /etc/openvpn/keys
	cp pki/ta.key /etc/openvpn/keys
fi
