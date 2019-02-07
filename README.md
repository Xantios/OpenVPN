# OpenVPN container Alpine 3.7

My openvpn server is a easy to use OOBE container for everyone to use

This VPN server includes:

 - run script witch detect startup for the first time.
 - Scripts to add and remove (revoke) client certificates.

It also generates a client config witch automatically inputs your server IP (Thanks @xantios for this addon!)

# How to use!

Just type "./openvpn.sh" in the folder where README.md is located.

In the "keys" folder you will notice the two client scripts.
To add a client, just type "./addclient.sh client1". Substitute "client1" with the name you want your VPN client to have.

To revoke and remove a certificate, just type "./rmclient.sh client1". Again, same client name options.

The container automatically detects if it is being run for the first time, so it will automatically build and install the necesarry certificates for you.

Have fun and stay connected! :)
