#!/bin/bash

FILE=$1

WAN_IP=$(curl -s api.ipify.org)

if ! [ -x "$(command -v curl)" ]; then
echo 'Error: curl is not installed. If you use a Debian based distribution, "apt-get install curl". If it is a redhat based distribution. "yum install curl"' >&2
exit 1
fi

if [ -z "$FILE" ]; then
	echo "We need a client name... Please provide one like: "addclient.sh client1""
else

	mkdir -p keys/$FILE
	docker exec -i openvpn /bin/bash -c "cd usr/share/easy-rsa/easyrsa3 && ./easyrsa gen-req $FILE nopass && ./easyrsa sign-req client $FILE" 
	
	docker cp openvpn:usr/share/easy-rsa/easyrsa3/pki/private/$FILE.key keys/$FILE/
	docker cp openvpn:/etc/openvpn/keys/ca.crt keys/$FILE/
	docker cp openvpn:usr/share/easy-rsa/easyrsa3/pki/issued/$FILE.crt keys/$FILE/
	docker cp openvpn:/etc/openvpn/keys/ta.key keys/$FILE/	

cat <<EOT >> keys/$FILE/client.ovpn
client
dev tun
proto tcp
remote $WAN_IP 1194
resolv-retry infinite
nobind
persist-key
persist-tun

ca ca.crt
cert $FILE.crt
key $FILE.key

auth-nocache
remote-cert-tls server
tls-auth ta.key 1
EOT

		if [ -f keys/$FILE/$FILE.crt ]; then
			echo -e "\e[32mClient certificates created! These are stored with the client config file in a directory in this folder with the name of the certificate\e[0m" 
			else
			rm -rf keys/$FILE
			echo -e "\e[31mSomething went wrong! please run this script again!\e[0m"
		fi
fi
