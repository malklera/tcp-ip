# To install on the VM

## ssh

Mandatory to have, allows for secure connection between devices

https://www.openssh.org/

`sudo pacman -S --needed openssh`

## ip

ip - show / manipulate routing, network devices, interfaces and tunnels

https://git.kernel.org/pub/scm/network/iproute2/iproute2.git

`sudo pacman -S --needed iproute2`

## ethtool

ethtool is the standard Linux utility for controlling network drivers and hardware, particularly for wired Ethernet devices

https://www.kernel.org/pub/software/network/ethtool/

`sudo pacman -S --needed ethtool`

## wol

Wake On LAN client - wakes up magic packet compliant machines.

http://ahh.sourceforge.net/wol/

`sudo pacman -S --needed wol`

## iw

iw - show / manipulate wireless devices and their configuration

https://wireless.docs.kernel.org/en/latest/en/users/documentation/iw.html

`sudo pacman -S --needed iw`

# Usefull tools to have

## tshark

TShark is a network protocol analyzer. It lets you capture packet data from a live network, or read packets from a previously saved capture file, either printing a
decoded form of those packets to the standard output or writing the packets to a file.

https://www.wireshark.org/

`sudo pacman -S --needed wireshark-cli`

For some reason it do not downloaded lua

`sudo pacman -S --needed lua`

## whois

whois searches for an object in a RFC 3912 database.

This version of the whois client tries to guess the right server to ask for the specified object.  If no guess can be  made  it  will  connect  to  whois.networksolu‐
tions.com for NIC handles or whois.arin.net for IPv4 addresses and network names

https://github.com/rfc1036/whois

`sudo pacman -S --needed whois`

## bind

Set of DNS related tools, came with several utilities.

I actually used something like this, to look up a IP address.

`dig +short 1.1.1.1.origin.asn.cymru.com TXT`

https://www.isc.org/bind/

`sudo pacman -S --needed bind`

## 
