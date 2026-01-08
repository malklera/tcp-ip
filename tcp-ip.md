## Definitions

- IP : Internet Protocol
- TCP : Transmission Control Protocol
- UDP : User Datagram Protocol
- DCCP : Datagram Congestion Control Protocol
- SCTP : Stream Control Transmission Protocol
- NAT : Network Adress Translation
- ARM : ARPANET Reference Model
- WAN : Wide Area Network
- WWW : World Wide Web
- FCFS : First Come First Serve
- FIFO : First In First Out
- TDM : Time Division Multiplexing
- VC : Virtual Circuits
- DSL : Digital Surbscriber Lines
- LCI/LCN : Logical Channel Identifier/Logical Channel Number
- OSI: Open Systems Interconection
- PDU : Protocol Data Unit
- TPDU : Transport Protocol Data Unit
- FTP : File Transfer Protocol
- ARP : Address Resolution Protocol, only on IPv4 and with multi-access link-layer protocols
- ICMP : Internet Control Message Protocol
- IGMP : Internet Group Management Protocol
- MLD : Multicast Listener Discovery protocol
- MAC : Media Access Control
- IANA : Internet Assigned Numbers Authority 
- URL : Uniform Resource Locator
- IETF : Internet Engineering Task Force
- IAB : Internet Architecture Board
- IESG : Internet Engineering Steering Group
- SDOs : Standard Defining Organizations
- IRTF : Internet Research Task Force
- RFC : Request For Comments
- IEEE : Institute of Electrical and Electronics Engineers
- IEEERA : IEEE Registration Authority
- W3C : World Wide Web Consortium
- ITU - ITU-T : International Telecomunication Union
- API : Application Programming Interface
- ISP : Internet Service Provider 
- LAN : Local Area Network
- DHCP : Dynamic Host Configuration Protocol
- VLSM : Variable Length Subnet Mask
- IID : Interface IDentifier
- OUI : Organizationally Unique Identifier
- CIDR : Class-less Inter-Domain Routing
- WKP : Well-Known Prefix
- ASM : Any-Source Multicast
- SSM : Source-Specific Multicast
- NTP : Network Time Protocol
- SAP : Session Announcement Protocol
- SDP : Session Description Protocol
- AS : Autonomous System
- UBM : Unicast-prefix-Based Multicast addressing
- RP : Rendezvous Point
- RIR : Regional Internet Registries
- NRO : Number Resource Organization
- PA : Provider-Agregatable (addresses)
- PI : Provider-Independent (addresses)
- RPSL : Routing Prolicy Specification Language
- HIP : Host Identity Protocol
- PPP : Point to Point Protocol
- MTU : Maximum Transmission Unit
- CSMA/CD : Carrier Sense, Multiple Access with Collision Detection
- CSMA/CA : Carrier Sense, Multiple Access with Collision Avoidance
- LLC : Logical Link Control
- SFD : Start Frame Delimiter
- QoS : Quality of Service
- CRC : Cyclic Redundancy Check
- IGP : Inter-Package Gap
- ISL : Inter-Switch Link
- LACP : Link Agregation Control Protocol
- NICs : Network Interface Card
- STP : Spanning Tree Protocol
- RSTP : Rapid Spanning Tree Protocol
- BPDUs : Bridge Protocol Data Units


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

| Class | Address Range | High order bits | Fraction of total |
| - | - | - | - |
| A | 0 - 127 | 0 | 1/2 |
| B | 128 - 191 | 10 | 1/4 |
| C | 192 - 223 | 110 | 1/8 |
| D | 224 - 239 | 1110 | 1/16 |
| E | 240 - 255 | 1111 | 1/16 |

### 2.3.2. Subnet Addressing

The first block of an IPv4 address is centrally allocated(the class), but the
rest of the address can be manage by local administrators to be again divided
on net/host

# 3. Link Layer
