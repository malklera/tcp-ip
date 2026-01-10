# 1. Introduction

### 1.3.2. Multiplexing, Demultiplexing, and Encapsulation in TCP/IP

Arriving Ethernet frame contains

| MAC | Ethernet Type |
|-|-|
| destination | 0x0800 -> IPv4 |
| address |0x0806 -> ARP |
| |0x86DD -> IPv6 |
| 48-bit | 16-bit |


### 1.3.3. Port Numbers

Port numbers are 16-bit nonnegative integers (range 0–65535)
Well-know:       0-1023
Registered:      1024-49151
Dynamic/Private: 49152-65535

**Some well-know ports**

- FTP (ports 20 and 21)
- Secure Shell Protocol (SSH, port 22)
- Telnet remote terminal protocol (port 23)
- e-mail/Simple Mail Transfer Protocol (SMTP, port 25)
- Domain Name System (DNS, port 53)
- the Hypertext Transfer Protocol or Web (HTTP and HTTPS, ports 80 and 443)
- Interactive Mail Access Protocol (IMAP and IMAPS, ports 143 and 993)
- Simple Network Management Protocol (SNMP, ports 161 and 162)
- Lightweight Directory Access Protocol (LDAP, port 389)

# 2. The Internet Address Architecture

## 2.2. Expressing IP Addresses

**IPv4.**

32 bit nonnegative integer
0 - 4 294 967 296 (2^32)
But is represented this way
[0-255].[0-255].[0-255].[0-255]

**IPv6**

128 bit nonnegative integer
0 - 3.402 823 669 × 10^38 (2^128)
But represented on hex
[0 - ffff]:[0 - ffff]:[0 - ffff]:[0 - ffff]:[0 - ffff]:[0 - ffff]:[0 - ffff]:[0 - ffff]

**With this rules:**

1. Leading zeros of a block need not be written.
2. Blocks of all zeros can be omitted and replaced by the notation ::
For example, the IPv6 address 0:0:0:0:0:0:0:1 can be written more compactly as ::1
Similarly, the address 2001:0db8:0:0:0:0:0:2 can be written more compactly as 2001:db8::2
To avoid ambiguities, the :: notation may be used only once in an IPv6 address.
3. Embedded IPv4 addresses represented in the IPv6 format can use a form of hybrid
notation in which the block immediately preceding the IPv4 portion of the address
has the value ffff and the remaining part of the address is formatted using dotted-quad.
For example, the IPv6 address ::ffff:10.0.0.1 represents the IPv4 address 10.0.0.1
This is called an IPv4-mapped IPv6 address.
4. A conventional notation is adopted in which the low-order 32 bits of the IPv6
address can be written using dotted-quad notation. The IPv6 address ::0102:f001
is therefore equivalent to the address ::1.2.240.1 . This is called an IPv4-compatible
IPv6 address. Note that IPv4-compatible addresses are not the same as IPv4-mapped
addresses; they are compatible only in the sense that they can be written down
or manipulated by software in a way similar to IPv4 addresses. This type of
addressing was originally required for transition plans between IPv4 and IPv6
but is now no longer required [RFC4291].

1. Leading zeros must be suppressed (e.g., 2001:0db8::0022 becomes 2001:db8::22).
2. The :: construct must be used to its maximum possible effect (most zeros suppressed)
but not for only 16-bit blocks. If multiple blocks contain equal-length runs of
zeros, the first is replaced with ::
3. The hexadecimal digits a through f should be represented in lowercase.

When using IPv6 on combination with HTTP protocol, you have to surround the ipv6 address on [] so that the colon from the
address is not confuse with the colon from the HTTP protocol

Example:

http://[2001:0db8:85a3:08d3:1319:8a2e:0370:7344]:443/

## 2.3. Basic IP Address Structure

### 2.3.1. Classful Addressing

What determines the class is the first block of the address 0-255.0-255.0-255.0-255
the rest of the blocks range between 0-255 each

| Class | Address Range | High order bits   | Fraction of total
| -     | -             | -                 | -
| A     | 0 - 127       | 0                 | 1/2
| B     | 128 - 191     | 10                | 1/4
| C     | 192 - 223     | 110               | 1/8
| D     | 224 - 239     | 1110              | 1/16
| E     | 240 - 255     | 1111              | 1/16

### 2.3.2. Subnet Addressing

The first block of an IPv4 address is centrally allocated(the class), but the
rest of the address can be manage by local administrators to be again divided
on net/host

# 3. Link Layer
## 3.5. Wireless LANs—IEEE 802.11(Wi-Fi)
### 3.5.4. Physical-Layer Details: Rates, Channels, and Frequencies

The standards has changed since the writing here, and the regulatory part is
country dependent, most of the interference problems has been worked out on new
standards.

Acording to [https://wireless.docs.kernel.org/en/latest/en/developers/regulatory/wireless-regdb.html](linux)
this are the frequency configs used by the kernel.

How to read.

DFS : Dynamic Frequency Selection, works by "listening" before selecting a frequency
AUTO-BW : Automatic Bandwidth, allowed to negotiate channel width shifts
FCC : Federal Communications Commission, USA
ETSI : European Telecommunications Standards Institute
JP : Japan, regulated by Ministry of Internal Affairs and Communications
NO-IR : No Initiate Radiation, passive scan only
NO-OUTDOOR : Not allowed to use outdoors

country <initial of country>: <flags>

    (<int, minimal frequency> - <int, maximum frequency> @ <int, maximum channel width>), (<int, maximum transmit power on dBm>), <flags>

United States.

```sh
# https://www.ecfr.gov/cgi-bin/text-idx?SID=eed706a2c49fd9271106c3228b0615f3&mc=true&node=pt47.1.15&rgn=div5
# Title 47 Part 15 - Radio Frequency Devices, April 2, 2020
# Channels 12 and 13 are not forbidden, but are not normally used with full
# power in order to avoid any potential interference in the adjacent restricted
# frequency band, 2,483.5–2,500 MHz which is subject to strict emission limits
# set out in 47 CFR § 15.205. TODO: reenable and specify a safe TX power here.
country US: DFS-FCC
	# S1G Channel 1-3
	(902 - 904 @ 2), (30)
	# S1G Channel 5-35
	(904 - 920 @ 16), (30)
	# S1G Channel 37-51
	(920 - 928 @ 8), (30)
	(2400 - 2472 @ 40), (30)
	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
	(5150 - 5250 @ 80), (23), AUTO-BW
	(5250 - 5350 @ 80), (24), DFS, AUTO-BW
	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
	# requirements, we can extend the range by 5 MHz to make the kernel
	# happy and be able to use channel 144.
	(5470 - 5730 @ 160), (24), DFS
	(5730 - 5850 @ 80), (30), AUTO-BW
	# https://www.federalregister.gov/documents/2021/05/03/2021-08802/use-of-the-5850-5925-ghz-band
	# max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
	(5850 - 5895 @ 40), (27), NO-OUTDOOR, AUTO-BW, NO-IR
	# 6g band
	# https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicensed-use-of-the-6ghz-band
	(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
	# 60g band
	# reference: section IV-D https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
	# channels 1-6 EIRP=40dBm(43dBm peak)
	(57240 - 71000 @ 2160), (40)
```

Argentina

```sh
# Source:
# https://www.boletinoficial.gob.ar/detalleAviso/primera/287126/20230524
country AR: DFS-FCC
	(2402 - 2482 @ 40), (20)
	(5170 - 5250 @ 80), (17), AUTO-BW
	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
	(5490 - 5730 @ 160), (24), DFS
	(5735 - 5835 @ 80), (30)
	(5925 - 7125 @ 320), (12), NO-OUTDOOR
```


