# OpenVPN container Alpine 3.7

My openvpn server is a easy to use OOBE container for everyone to use

This VPN server includes:

 - run script witch detect startup for the first time.
 - Scripts to add and remove (revoke) client certificates.

It also generates a client config witch automatically inputs your server IP (Thanks @xantios for this addon!)

Also, you have to ajust a line in server.conf to suit your own internal ip range.
Server.conf is located in the files folder in the root of the vpn server.
adjust this line: `push "route 10.10.10.0 255.255.255.0"`

# How to use!

Just type "./openvpn.sh" in the folder where README.md is located.

In the main folder you will notice the two client scripts.
To add a client, just type `./addclient.sh client1`. Substitute "client1" with the name you want your VPN client to have.

To revoke and remove a certificate, just type "./rmclient.sh client1". Again, same client name options.

Reminder! If the first key is created, it wil automatically create a "keys" folder.

The container automatically detects if it is being run for the first time, so it will automatically build and install the necesarry certificates for you.

Have fun and stay connected! :)
