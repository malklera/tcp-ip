# TCP/IP Modern tools

I am following the book *TCP/IP Illustrated, Vol. 1: The Protocols by W. Richard Stevens* second edition.

On the first command show on the examples I learnt that while the knowlege contained on this books is quite relevant today (from what I read online), some of the tools used at the moment of the writing are deprecated, so I have to go look for alternatives, I do not found a modern compiling of them, and since I have to do it to use them myself here they are.

I will only indicate Chapter and specific section where the command is used, show the actual example (is this copyright infringement??), if you want the content of the book, go buy it.

Below the example from the book will be a example run on a VM system at the moment I do it, the output of the commands will be sanitice and this is the convention to follow.

| Output            | Placeholder
| -                 | -
| Binary digit      | b
| Decimal digit     | d
| Hexadecimal digit | h
| Letter            | l

On your own system the output of the commands will follow the same structure (I think) but the actual values will be different.

Where the values are not reemplaced by the above table, either I do not cach it or the value is not a privacy/security concert(as far as llms know).~~pleace do not take over my system~~



## Preparation

I used [quickemu](https://github.com/quickemu-project/quickemu) to set up my VMs, but it may have been easer to use [qemu](https://www.qemu.org) directly for the dependencies problems I have to dealt with, but I disgress.

- Install [qemu].
- Install [quickemu], I have a problem with the package being an old version, so I have to build it from source.
> If you are building from source, you will have to download/build the dependencies, depending of where you are using it from.

**System where the new commands where used**
I created two VMs with quickemu

For linux system I choose a minimal archlinux install

```sh
linux$ uname -a
Linux archvm 6.16.4-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 28 Aug 2025 19:49:53 +0000 x86_64 GNU/Linux
```
`` ```

For Windows I choose Windows 11

``` ```

I will not look for tools for MacOs because I do not think I will ever touch one.

~~If you use a system where this tools are not available, I do not care, good luck. And not, this document is not an excuse to say that I use Arch btw~~

# 2. The Internet Address Architecture
2.3. Basic IP Address Structure
2.3.6. IPv6 Addresses and Interface Identifiers
2.3.6.1. Examples

```sh
Linux% ifconfig
Linux% ifconfig eth1
eth1      Link encap:Ethernet  HWaddr 00:30:48:2A:19:89
          inet addr:12.46.129.28  Bcast:12.46.129.127
          Mask:255.255.255.128
          inet6 addr: fe80::230:48ff:fe2a:1989/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1359970341 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1472870787 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4021555658 (3.7 GiB)  TX bytes:3258456176 (3.0 GiB)
          Base address:0x3040 Memory:f8220000-f8240000
```

```sh
linux$ ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: enp0s9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether hh:hh:hh:hh:hh:hh brd ff:ff:ff:ff:ff:ff
    altname enx525400123456
    inet dd.d.d.dd/24 metric 100 brd 10.0.2.255 scope global dynamic enp0s9
       valid_lft 85019sec preferred_lft 85019sec
    inet6 hhhh::hhhh:hh:hhhh:hhhh/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 86272sec preferred_lft 14272sec
    inet6 hhhh::hhhh:hh:hhhh:hhhh/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
```
1: lo: is for loopback, I suposse someday I will learn what is for, for now, ignore that

2: : is my actual ethernet connection
 is autogenerate following the [pnidn](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/networking_guide/sec-understanding_the_predictable_network_interface_device_names) standart? it is compose by

type_interface p\<Bus number\>s\<Slot number\> => enp0s9 

You can see the result of the mapping of link/ether address to IPv6 address
> inet addr:12.46.129.28
> inet6 addr: fe80::230:48ff:fe2a:1989

Yet to understand how and why would you do that

## 2.7. Unicast Address Assignment
### 2.7.1. Single Provider/No Network/Single Address

```sh
Linux% ifconfig ppp0
ppp0      Link encap:Point-to-Point Protocol
          inet addr:71.141.244.213
          P-t-P:71.141.255.254  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1492  Metric:1
          RX packets:33134 errors:0 dropped:0 overruns:0 frame:0
          TX packets:41031 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3
          RX bytes:17748984 (16.9 MiB)  TX bytes:9272209 (8.8 MiB)

Linux% netstat -gn
IPv6/IPv4 Group Memberships
Interface       RefCnt Group
--------------- ------ ---------------------
lo              1      224.0.0.1
ppp0            1      224.0.0.251
ppp0            1      224.0.0.1
lo              1      ff02::1
```

```sh
linux$ ip address show enp0s9
2: enp0s9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether hh:hh:hh:hh:hh:hh brd ff:ff:ff:ff:ff:ff
    altname enx525400123456
    inet dd.d.d.dd/24 metric 100 brd 10.0.2.255 scope global dynamic enp0s9
       valid_lft 81360sec preferred_lft 81360sec
    inet6 hhhh::hhhh:hh:hhhh:hhhh/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 85872sec preferred_lft 13872sec
    inet6 hhhh::hhhh:hh:hhhh:hhhh/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever

linux$ ip maddress show
1:      lo
        inet  224.0.0.1
        inet6 ff02::1
        inet6 ff01::1
2:      enp0s9
        link  33:33:00:00:00:01
        link  01:00:5e:00:00:01
        link  33:33:ff:hh:hh:hh
        link  01:80:c2:00:00:00
        link  01:80:c2:00:00:03
        link  01:80:c2:00:00:0e
        link  01:00:5e:00:00:fc
        link  01:00:5e:00:00:fb
        link  33:33:00:01:00:03
        link  33:33:00:00:00:fb
        inet  224.0.0.251
        inet  224.0.0.252
        inet  224.0.0.1
        inet6 ff02::fb
        inet6 ff02::1:3
        inet6 ff02::1:ffhh:hhhh users 2
        inet6 ff02::1 users 2
        inet6 ff01::1
```

# 3. Link Layer
### 3.2.3. 802.1p/q: Virtual LANs and QoS Tagging

```sh
Linux% vconfig add eth1 2
Added VLAN with VID == 2 to IF -:eth1:-
Linux% ifconfig eth1.2
eth1.2 Link encap:Ethernet HWaddr 00:04:5A:9F:9E:80
            BROADCAST MULTICAST MTU:1500 Metric:1
            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:0
            RX bytes:0 (0.0 b) TX bytes:0 (0.0 b)
Linux% vconfig rem eth1.2
Removed VLAN -:eth1.2:-
Linux% vconfig set_name_type VLAN_PLUS_VID
Set name-type for VLAN subsystem. Should be visible in
            /proc/net/vlan/config
Linux% vconfig add eth1 2
Added VLAN with VID == 2 to IF -:eth1:-
Linux% ifconfig vlan0002
vlan0002 Link encap:Ethernet HWaddr 00:04:5A:9F:9E:80
            BROADCAST MULTICAST MTU:1500 Metric:1
            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:0
            RX bytes:0 (0.0 b) TX bytes:0 (0.0 b)
```


```sh
linux$ sudo ip link add link enp0s9 name descriptiveName type vlan id 1
linux$ ip -d address show descriptiveName
3: descriptiveName@enp0s9: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether hh:hh:hh:hh:hh:hh brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 0 maxmtu 65535
    vlan protocol 802.1Q id 1 <REORDER_HDR> numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
linux$ sudo ip link delete descriptiveName
```

It is not recommended to create VLAN interfaces automatically, there is not a built in command for that.

### 3.2.4. 802.1AX: Link Aggregation (Formerly 802.3ad)

For what I understang what you want is for applications to not care about what
interface is the data going, if you change physical ethernet connector or change
from ethernet to Wi-Fi, your MAC, IP, and other data of the interface change, if
the application wants to connect to a specific IP, each time the interface change
you have to change the application.

If the application instead connect to a master interface, you can add, change, and
delete slaves interfaces and the application would not care, or if you have a ethernet
cable as the main connection, you can have a Wi-Fi as a backup, or another ethernet
cable.

```sh
Linux% modprobe bonding
Linux% ifconfig bond0 10.0.0.111 netmask 255.255.255.128
Linux% ifenslave bond0 eth0 wlan0
```

```sh
linux$ sudo modprobe bonding
linux$ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
    altname enx525400123456
    inet 10.0.2.15/24 metric 100 brd 10.0.2.255 scope global dynamic enp0s8
       valid_lft 85689sec preferred_lft 85689sec
    inet6 fec0::5054:ff:fe12:3456/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 86268sec preferred_lft 14268sec
    inet6 fe80::5054:ff:fe12:3456/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
3: enp0s11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
    altname enx525400123457
    inet 10.0.4.15/24 metric 1024 brd 10.0.4.255 scope global dynamic enp0s11
       valid_lft 85688sec preferred_lft 85688sec
    inet6 fec0::5054:ff:fe12:3457/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 86134sec preferred_lft 14134sec
    inet6 fe80::5054:ff:fe12:3457/64 scope link proto kernel_ll
       valid_lft forever preferred_lft foreve
linux$ sudo ip link add bond0 type bond mode active-backup
linux$ sudo ip link set enp0s8 down
linux$ sudo ip link set enp0s8 master bond0
# The following command is just to dealt with a qemu related problem regarding
# the mac addresses, for an actual machine you do not do this. This MAC address
# is the same that is asigned to enp0s8 by default.
linux$ sudo ip link set bond0 addr 52:54:00:12:34:56
linux$ sudo ip addr add 10.0.2.15/24 dev bond0
linux$ sudo ip link set bond0 up
# Slave interfaces should not have their own address, it is inherited from the master
linux$ sudo ip addr flush dev enp0s8
linux$ sudo ip route add default via 10.0.2.2 dev bond0 src 10.0.2.15 metric 100
```

## 3.3. Full Duplex, Power Save, Autonegotiation, and 802.1X Flow Control

ethtool is still used

```sh
Linux% ethtool eth0
Settings for eth0:
           Supported ports: [ TP MII ]
           Supported link modes: 10baseT/Half 10baseT/Full
           100baseT/Half 100baseT/Full
           Supports auto-negotiation: Yes
           Advertised link modes: 10baseT/Half 10baseT/Full
           100baseT/Half 100baseT/Full
           Advertised auto-negotiation: Yes
           Speed: 10Mb/s
           Duplex: Half
           Port: MII
           PHYAD: 24
           Transceiver: internal
           Auto-negotiation: on
           Current message level: 0x00000001 (1)
           Link detected: yes
Linux% ethtool eth1
Settings for eth1:
           Supported ports: [ TP ]
           Supported link modes: 10baseT/Half 10baseT/Full
                      100baseT/Half 100baseT/Full
                      1000baseT/Full
           Supports auto-negotiation: Yes
           Advertised link modes: 10baseT/Half 10baseT/Full
                      100baseT/Half 100baseT/Full
                      1000baseT/Full
           Advertised auto-negotiation: Yes
           Speed: 100Mb/s
           Duplex: Full
           Port: Twisted Pair
           PHYAD: 0
           Transceiver: internal
           Auto-negotiation: on
           Supports Wake-on: umbg
           Wake-on: g
           Current message level: 0x00000007 (7)
           Link detected: yes
```

On the VM this tool do not actually work. For complete information run as sudo,
it use a part of the kernel called netlink.

```sh
linux$ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
    altname enx525400123456
    inet 10.0.2.15/24 metric 100 brd 10.0.2.255 scope global dynamic enp0s8
       valid_lft 86058sec preferred_lft 86058sec
    inet6 fec0::5054:ff:fe12:3456/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 86060sec preferred_lft 14060sec
    inet6 fe80::5054:ff:fe12:3456/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
3: enp0s11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
    altname enx525400123457
    inet 10.0.4.15/24 metric 1024 brd 10.0.4.255 scope global dynamic enp0s11
       valid_lft 86058sec preferred_lft 86058sec
    inet6 fec0::5054:ff:fe12:3457/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 86385sec preferred_lft 14385sec
    inet6 fe80::5054:ff:fe12:3457/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
linux$ sudo ethtool enp0s8
Settings for enp0s8:
	Supported ports: [  ]
	Supported link modes:   Not reported
	Supported pause frame use: No
	Supports auto-negotiation: No
	Supported FEC modes: Not reported
	Advertised link modes:  Not reported
	Advertised pause frame use: No
	Advertised auto-negotiation: No
	Advertised FEC modes: Not reported
	Speed: Unknown!
	Duplex: Unknown! (255)
	Auto-negotiation: off
	Port: Other
	PHYAD: 0
	Transceiver: internal
	Link detected: yes
linux$ sudo ethtool enp0s11
Settings for enp0s11:
	Supported ports: [  ]
	Supported link modes:   Not reported
	Supported pause frame use: No
	Supports auto-negotiation: No
	Supported FEC modes: Not reported
	Advertised link modes:  Not reported
	Advertised pause frame use: No
	Advertised auto-negotiation: No
	Advertised FEC modes: Not reported
	Speed: Unknown!
	Duplex: Unknown! (255)
	Auto-negotiation: off
	Port: Other
	PHYAD: 0
	Transceiver: internal
	Link detected: yes
```

### 3.3.2. Wake-on LAN (WoL), Power Saving, and Magic Packets

To see what types of WoL options there are

```sh
LESS='+/^ *wol ' man ethtool
```


```sh
Linux% ethtool –s eth0 wol umgb
```

WoL do not make sence on a VM, so normally is not implemented

```sh
linux$ sudo ethtool -s enp0s8 wol umbg
netlink error: Operation not supported
```

## 3.4. Bridges and Switches

```sh
Linux% brctl addbr br0
Linux% brctl addif br0 eth0
Linux% brctl addif br0 eth1
Linux% ifconfig eth0 up
Linux% ifconfig eth1 up
Linux% ifconfig br0 up
```

```sh
linux$ sudo ip link add br0 type bridge
linux$ sudo ip link set enp0s8 master br0
linux$ sudo ip link set enp0s12 master br0
linux$ sudo ip addr flush dev enp0s8
linux$ sudo ip addr flush dev enp0s12
linux$ sudo ip addr add 10.0.2.15/24 dev br0
linux$ sudo ip link set enp0s8 up
linux$ sudo ip link set enp0s12 up
linux$ sudo ip link set br0 up
linux$ sudo ip route add default via 10.0.2.2 dev br0 src 10.0.2.15 metric 100
```

```sh
Linux% brctl show
bridge name bridge id         STP enabled interfaces
br0         8000.0007e914a9c1 no          eth0 eth1

Linux% brctl showmacs br0
port no mac addr is local? ageing timer
  1 00:04:5a:9f:9e:80 no 0.79
  2 00:07:e9:14:a9:c1 yes 0.00
  1 00:08:74:93:c8:3c yes 0.00
  2 00:14:22:f4:19:5f no 0.81
  1 00:17:f2:e7:6d:91 no 2.53
  1 00:90:f8:00:90:b7 no 17.13
```

With the first command we learn which interfaces are connected to which master.

```sh
linux$ bridge link
2: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state forwarding priority 32 cost 100
4: enp0s12: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state forwarding priority 32 cost 100
```

Then with the following we learn the type of link bridge/bridge_slave, stp_state, bridge_id

```sh
linux$ ip -d link show br0
5: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 16:a0:5e:e3:40:4b brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535 netns-immutable
    bridge forward_delay 1500 hello_time 200 max_age 2000 ageing_time 30000 stp_state 0 priority 32768 vlan_filtering 0 vlan_protocol 802.1Q bridge_id 8000.16:a0:5e:e3:40:4b designated_root 8000.16:a0:5e:e3:40:4b root_port 0 root_path_cost 0 topology_change 0 topology_change_detected 0 hello_timer    0.00 tcn_timer    0.00 topology_change_timer    0.00 gc_timer  222.81 fdb_n_learned 2 fdb_max_learned 0 vlan_default_pvid 1 vlan_stats_enabled 0 vlan_stats_per_port 0 group_fwd_mask 0 group_address 01:80:c2:00:00:00 mcast_snooping 1 no_linklocal_learn 0 mcast_vlan_snooping 0 mst_enabled 0 mdb_offload_fail_notification 0 fdb_local_vlan_0 0 mcast_router 1 mcast_query_use_ifaddr 0 mcast_querier 0 mcast_hash_elasticity 16 mcast_hash_max 4096 mcast_last_member_count 2 mcast_startup_query_count 2 mcast_last_member_interval 100 mcast_membership_interval 26000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_response_interval 1000 mcast_startup_query_interval 3125 mcast_stats_enabled 0 mcast_igmp_version 2 mcast_mld_version 1 nf_call_iptables 0 nf_call_ip6tables 0 nf_call_arptables 0 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
```

On the MACs tables we see mac address(mac addr), interface(port no), used int/int(ageing timer), owner(is local?)

```sh
[user@server ~]$ bridge -s fdb
52:55:0a:00:02:02 dev enp0s8 used 2572/105 master br0
52:54:00:12:34:56 dev enp0s8 vlan 1 used 2662/2662 master br0 permanent
52:54:00:12:34:56 dev enp0s8 used 2662/2662 master br0 permanent
33:33:00:00:00:01 dev enp0s8 self permanent
01:00:5e:00:00:01 dev enp0s8 self permanent
01:80:c2:00:00:00 dev enp0s8 self permanent
01:80:c2:00:00:03 dev enp0s8 self permanent
01:80:c2:00:00:0e dev enp0s8 self permanent
33:33:00:00:00:01 dev enp0s11 self permanent
01:00:5e:00:00:01 dev enp0s11 self permanent
33:33:ff:12:34:57 dev enp0s11 self permanent
01:80:c2:00:00:00 dev enp0s11 self permanent
01:80:c2:00:00:03 dev enp0s11 self permanent
01:80:c2:00:00:0e dev enp0s11 self permanent
01:00:5e:00:00:fc dev enp0s11 self permanent
33:33:00:01:00:03 dev enp0s11 self permanent
52:56:00:00:00:02 dev enp0s12 used 774/234 master br0
52:54:00:12:34:58 dev enp0s12 vlan 1 used 2657/2657 master br0 permanent
52:54:00:12:34:58 dev enp0s12 used 2657/2657 master br0 permanent
33:33:00:00:00:01 dev enp0s12 self permanent
01:00:5e:00:00:01 dev enp0s12 self permanent
01:80:c2:00:00:00 dev enp0s12 self permanent
01:80:c2:00:00:03 dev enp0s12 self permanent
01:80:c2:00:00:0e dev enp0s12 self permanent
33:33:00:00:00:01 dev br0 self permanent
01:00:5e:00:00:6a dev br0 self permanent
33:33:00:00:00:6a dev br0 self permanent
01:00:5e:00:00:01 dev br0 self permanent
33:33:ff:e3:40:4b dev br0 self permanent
01:00:5e:00:00:fc dev br0 self permanent
01:00:5e:00:00:fb dev br0 self permanent
33:33:00:01:00:03 dev br0 self permanent
33:33:00:00:00:fb dev br0 self permanent
16:a0:5e:e3:40:4b dev br0 vlan 1 used 2685/2685 master br0 permanent
16:a0:5e:e3:40:4b dev br0 used 2685/2685 master br0 permanent
```

```sh
Linux% brctl setageing br0 1
Linux% brctl showmacs br0
port no mac addr is local? ageing timer
  1 00:04:5a:9f:9e:80 no 0.76
  2 00:07:e9:14:a9:c1 yes 0.00
  1 00:08:74:93:c8:3c yes 0.00
  2 00:14:22:f4:19:5f no 0.78
  1 00:17:f2:e7:6d:91 no 0.00
```

```sh
linux$ sudo ip link set dev br0 type bridge ageing_time 500
```

If trying this with a VM, you probably would see nothing with this

```sh
bridge -s fdb show br0 | grep -v permanent
```

To see how the aging timer work, set up two terminals with ssh connections to the VM.

Terminal one

```sh
watch -n 0.1 "bridge -s fdb show | grep -v permanent"
```

Terminal two, any type of request will do, you could be not connected to ssh and
then try to make a connection and you would see it on Terminal one

```sh
linux$ ls
```
### 3.4.1. Spanning Tree Protocol (STP)
#### 3.4.1.5. Example

```sh
Linux% brctl stp br0 on
```

You need some working bridges before doing this. 

```sh
linux$ sudo ip link set dev br0 type bridge stp_state 1
```

```sh
Linux% brctl showstp br0
```

```sh
linux$ ip -d link show br0
5: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 16:a0:5e:e3:40:4b brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535 netns-immutable
    bridge forward_delay 1500 hello_time 200 max_age 2000 ageing_time 30000 stp_state 1 priority 32768 vlan_filtering 0 vlan_protocol 802.1Q bridge_id 8000.16:a0:5e:e3:40:4b designated_root 8000.16:a0:5e:e3:40:4b root_port 0 root_path_cost 0 topology_change 0 topology_change_detected 0 hello_timer    0.14 tcn_timer    0.00 topology_change_timer    0.00 gc_timer   53.42 fdb_n_learned 1 fdb_max_learned 0 vlan_default_pvid 1 vlan_stats_enabled 0 vlan_stats_per_port 0 group_fwd_mask 0 group_address 01:80:c2:00:00:00 mcast_snooping 1 no_linklocal_learn 0 mcast_vlan_snooping 0 mst_enabled 0 mdb_offload_fail_notification 0 fdb_local_vlan_0 0 mcast_router 1 mcast_query_use_ifaddr 0 mcast_querier 0 mcast_hash_elasticity 16 mcast_hash_max 4096 mcast_last_member_count 2 mcast_startup_query_count 2 mcast_last_member_interval 100 mcast_membership_interval 26000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_response_interval 1000 mcast_startup_query_interval 3125 mcast_stats_enabled 0 mcast_igmp_version 2 mcast_mld_version 1 nf_call_iptables 0 nf_call_ip6tables 0 nf_call_arptables 0 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
linux$ bridge -d link show
2: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state forwarding priority 32 cost 100
    hairpin off guard off root_block off fastleave off learning on flood on mcast_flood on bcast_flood on mcast_router 1 mcast_to_unicast off neigh_suppress off neigh_vlan_suppress off vlan_tunnel off isolated off locked off mab off mcast_n_groups 0 mcast_max_groups 0
4: enp0s12: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state forwarding priority 32 cost 100
    hairpin off guard off root_block off fastleave off learning on flood on mcast_flood on bcast_flood on mcast_router 1 mcast_to_unicast off neigh_suppress off neigh_vlan_suppress off vlan_tunnel off isolated off locked off mab off mcast_n_groups 0 mcast_max_groups 0
```

```sh
linux$ sudo tshark -i enp0s8 -Y "stp" -V
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s8'
Frame 1: Packet, 52 bytes on wire (416 bits), 52 bytes captured (416 bits) on interface enp0s8, id 0
    Section number: 1
    Interface id: 0 (enp0s8)
        Interface name: enp0s8
    Encapsulation type: Ethernet (1)
    Arrival Time: Jan  7, 2026 22:00:24.634843505 -03
    UTC Arrival Time: Jan  8, 2026 01:00:24.634843505 UTC
    Epoch Arrival Time: 1767834024.634843505
    [Time shift for this packet: 0.000000000 seconds]
    [Time since reference or first frame: 0.000000000 seconds]
    Frame Number: 1
    Frame Length: 52 bytes (416 bits)
    Capture Length: 52 bytes (416 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: eth:llc:stp]
    Character encoding: ASCII (0)
IEEE 802.3 Ethernet
    Destination: Nearest-Customer-Bridge (01:80:c2:00:00:00)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...1 .... .... .... .... = IG bit: Group address (multicast/broadcast)
    Source: 52:54:00:12:34:56 (52:54:00:12:34:56)
        .... ..1. .... .... .... .... = LG bit: Locally administered address (this is NOT the factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Length: 38
    [Stream index: 0]
Logical-Link Control
    DSAP: Spanning Tree BPDU (0x42)
        0100 001. = SAP: Spanning Tree BPDU
        .... ...0 = IG Bit: Individual
    SSAP: Spanning Tree BPDU (0x42)
        0100 001. = SAP: Spanning Tree BPDU
        .... ...0 = CR Bit: Command
    Control field: U, func=UI (0x03)
        000. 00.. = Command: Unnumbered Information (0x00)
        .... ..11 = Frame type: Unnumbered frame (0x3)
Spanning Tree Protocol
    Protocol Identifier: Spanning Tree Protocol (0x0000)
    Protocol Version Identifier: Spanning Tree (0)
    BPDU Type: Configuration (0x00)
    BPDU flags: 0x00
        0... .... = Topology Change Acknowledgment: No
        .... ...0 = Topology Change: No
    Root Identifier: 32768 / 0 / 16:a0:5e:e3:40:4b
        Root Bridge Priority: 32768
        Root Bridge System ID Extension: 0
        Root Bridge System ID: 16:a0:5e:e3:40:4b (16:a0:5e:e3:40:4b)
    Root Path Cost: 0
    Bridge Identifier: 32768 / 0 / 16:a0:5e:e3:40:4b
        Bridge Priority: 32768
        Bridge System ID Extension: 0
        Bridge System ID: 16:a0:5e:e3:40:4b (16:a0:5e:e3:40:4b)
    Port identifier: 0x8001
    Message Age: 0
    Max Age: 20
    Hello Time: 2
    Forward Delay: 15
```
