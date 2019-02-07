#!/bin/bash

FILE=$1

	if [ -z "$FILE" ]
	then
	echo "We need a client name... Please provide one like: "rmclient.sh client1""
else

	docker exec -i openvpn /bin/bash -c "cd usr/share/easy-rsa/easyrsa3 && ./easyrsa revoke $FILE && ./easyrsa gen-crl && cp pki/crl.pem /etc/openvpn/keys && echo "crl-verify /etc/openvpn/keys/crl.pem" >> /etc/openvpn/openvpn.conf" 
	if [ -d "keys/$FILE" ]; then
		rm -rf keys/$FILE
	else
		echo -e "\e[31mClient folder was not detected! Did you remove the client folder yourself perhaps?\e[0m"
		rm -rf keys/$FILE
	fi

fi
