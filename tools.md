# Usefull tools to have

## ssh

Mandatory to have, allows for secure connection between devices

https://www.openssh.org/

```sudo pacman -S --needed openssh```

## whois

whois searches for an object in a RFC 3912 database.

This version of the whois client tries to guess the right server to ask for the specified object.  If no guess can be  made  it  will  connect  to  whois.networksolu‐
tions.com for NIC handles or whois.arin.net for IPv4 addresses and network names

https://github.com/rfc1036/whois

```sudo pacman -S --needed whois```

## bind

Set of DNS related tools, came with several utilities.

I actually used something like this, to look up a IP address.

```dig +short 1.1.1.1.origin.asn.cymru.com TXT```

https://www.isc.org/bind/

```sudo pacman -S --needed bind```

## 
