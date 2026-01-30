# Linux VM

## Preparation

I used [quickemu](https://github.com/quickemu-project/quickemu) to set up my VMs,
but it may have been easer to use [qemu](https://www.qemu.org) directly for the
dependencies problems I have to dealt with, but I disgress.

- Install [qemu].
- Install [quickemu], I have a problem with the package being an old version, so I have to build it from source.
> If you are building from source, you will have to download/build the dependencies, depending of where you are using it from.

**System where the new commands where used**
I created two VMs with quickemu

For linux system I choose a minimal archlinux install

```sh
linux$ uname -a
Linux archvm 6.16.4-arch1-1
```
`` ```

~~If you use a system where this tools are not available, I do not care, good luck. And not, this document is not an excuse to say that I use Arch btw~~

## Commands

# 2. The Internet Address Architecture
## 2.3. Basic IP Address Structure
### 2.3.6. IPv6 Addresses and Interface Identifiers
#### 2.3.6.1. Examples

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

## 3.5. Wireless LANs—IEEE 802.11(Wi-Fi)

VMs do not have wireless connections, you can get access to one with a usb card
and allowing the VM to access it, or run the commands from the host if you have
Wi-Fi on it.

I do not have Wi-Fi, so the modern example commands do not show output.

### 3.5.1. 802.11 Frames
#### 3.5.1.1. Management Frames

```sh
Linux% iwlist wlan0 scan
wlan0 Scan completed :
            Cell 01 - Address: 00:02:6F:20:B5:84
                     ESSID:"Grizzly-5354-Aries-802.11b/g"
                     Mode:Master
                     Channel:4
                      Frequency:2.427 GHz (Channel 4)
                     Quality=5/100 Signal level=47/100
                     Encryption key:on
                     IE: WPA Version 1
                        Group Cipher : TKIP
                        Pairwise Ciphers (2) : CCMP TKIP
                        Authentication Suites (1) : PSK
                     Bit Rates:1 Mb/s; 2 Mb/s; 5.5 Mb/s; 11 Mb/s;
                            6 Mb/s; 12 Mb/s; 24 Mb/s; 36 Mb/s; 9 Mb/s;
                            18 Mb/s; 48 Mb/s; 54 Mb/s
                     Extra:tsf=0000009d832ff037
```

Check for the name of the device

```sh
linux$ iw dev
```

Actually do the scan.

```sh
linux$ sudo iw dev <devname> scan
```

#### 3.5.1.2. Control Frames: RTS/CTS and ACKs

```sh
Linux% iwconfig wlan0 rts 250
wlan0 IEEE 802.11g ESSID:"Grizzly-5354-Aries-802.11b/g"
           Mode:Managed
           Frequency:2.427 GH
           Access Point: 00:02:6F:20:B5:84
           Bit Rate=24 Mb/s Tx-Power=0 dBm
           Retry min limit:7 RTS thr=250 B Fragment thr=2346 B
           Encryption key:xxxx- ... -xxxx [3]
           Link Quality=100/100 Signal level=46/100
           Rx invalid nwid:0 Rx invalid crypt:0 Rx invalid frag:0
           Tx excessive retries:0 Invalid misc:0 Missed beacon:0
```

```sh
linux$ sudo iw phy <phyname> set rts 250
```

## 3.7. Loopback

```sh
Linux% ifconfig lo
lo Link encap:Local Loopback
           inet addr:127.0.0.1 Mask:255.0.0.0
           inet6 addr: ::1/128 Scope:Host
           UP LOOPBACK RUNNING MTU:16436 Metric:1
           RX packets:458511 errors:0 dropped:0 overruns:0 frame:0
           TX packets:458511 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:266049199 (253.7 MiB)
           TX bytes:266049199 (253.7 MiB)
```

```sh
linux$ ip -d addr show lo
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00 promiscuity 0 allmulti 0 minmtu 0 maxmtu 0 netns-immutable numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
linux$ ip -s link show lo
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    RX:  bytes packets errors dropped  missed   mcast
             0       0      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
             0       0      0       0       0       0
```

# 4. ARP: Address Resolution Protocol
## 4.3. ARP Cache

```sh
Linux% arp
Address             HWtype  HWaddress           Flags Mask Iface
gw.home             ether   00:0D:66:4F:60:00   C          eth1
printer.home        ether   00:0A:95:87:38:6A   C          eth1

Linux% arp -a
printer.home (10.0.0.4) at     00:0A:95:87:38:6A [ether] on eth1
gw.home (10.0.0.1) at 00:0D:66:4F:60:00 [ether] on eth1
```

```sh
linux$ ip neighbor
10.0.2.2 dev enp0s8 lladdr 52:55:0a:00:02:02 STALE
10.0.4.2 dev enp0s11 lladdr 52:55:0a:00:04:02 REACHABLE
10.0.3.2 dev enp0s12 lladdr 52:55:0a:00:03:02 STALE
fe80::2 dev enp0s11 lladdr 52:56:00:00:00:02 router STALE
fe80::2 dev enp0s8 lladdr 52:56:00:00:00:02 router STALE
fe80::2 dev enp0s12 lladdr 52:56:00:00:00:02 router STALE

linux$ ip -s neighbor
10.0.2.2 dev enp0s8 lladdr 52:55:0a:00:02:02  used 721/721/677probes 1 STALE
10.0.4.2 dev enp0s11 lladdr 52:55:0a:00:04:02  ref 1 used 7/0/7probes 1 REACHABLE
10.0.3.2 dev enp0s12 lladdr 52:55:0a:00:03:02  used 720/720/701probes 1 STALE
fe80::2 dev enp0s11 lladdr 52:56:00:00:00:02 router  used 8944/9004/8944probes 0 STALE
fe80::2 dev enp0s8 lladdr 52:56:00:00:00:02 router  used 8946/9006/8946probes 0 STALE
fe80::2 dev enp0s12 lladdr 52:56:00:00:00:02 router  used 8946/9006/8946probes 0 STALE
```

## 4.5. ARP Examples
### 4.5.1. Normal Example

```sh
C:\> arp -a                   Verify that the ARP cache is empty
No ARP Entries Found
C:\> telnet 10.0.0.3 www      Connect to the Web server [port 80]
Connecting to 10.0.0.3...
Escape character is ’^]’.
```

On Host, set up a temporary server wich we will call.

```sh
python3 -m http.server 8000 --bind 0.0.0.0
```

On VM

Terminal A

```sh
linux$ sudo ip neighbor flush all
linux$ ip neighbor show
10.0.3.2 dev enp0s12 lladdr 52:55:0a:00:03:02 REACHABLE
```

Terminal B, when you run the command, you would get the output up to "Capturingon 'enp0s8'"

```sh
linux$ sudo tshark -i enp0s8 -Y "arp || tcp.port == 8000"
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s8'
    1 0.000000000 52:54:00:12:34:56 → Broadcast    ARP 42 Who has 10.0.2.2? Tell 10.0.2.15
    2 0.000079681 52:55:0a:00:02:02 → 52:54:00:12:34:56 ARP 64 10.0.2.2 is at 52:55:0a:00:02:02
    3 0.000086511    10.0.2.15 → 10.0.2.2     TCP 74 43588 → 8000 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM TSval=747956706 TSecr=0 WS=512
    4 0.000377564     10.0.2.2 → 10.0.2.15    TCP 60 8000 → 43588 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460
    5 0.000394794    10.0.2.15 → 10.0.2.2     TCP 54 43588 → 8000 [ACK] Seq=1 Ack=1 Win=64240 Len=0
```

Terminal A, after running this command, go back to Terminal B and you will see
the packets.

```sh
linux$ telnet 10.0.2.2 8000
Trying 10.0.2.2...
Connected to 10.0.2.2.
Escape character is '^]'
```

### 4.5.2. ARP Request to a Nonexistent Host

```sh
Linux% date ; telnet 10.0.0.99 ; date
Fri Jan 29 14:46:33 PST 2010
Trying 10.0.0.99...
telnet: connect to address 10.0.0.99: No route to host
Fri Jan 29 14:46:36 PST 2010
Linux% arp -a
? (10.0.0.99) at <incomplete> on eth0
Linux% tcpdump –n arp
1 21:12:07.440845 arp who-has 10.0.0.99 tell 10.0.0.56
2 21:12:08.436842 arp who-has 10.0.0.99 tell 10.0.0.56
3 21:12:09.436836 arp who-has 10.0.0.99 tell 10.0.0.56
```

Terminal A

```sh
linux$ sudo tshark -i enp0s8 -Y arp
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s8'
    1 0.000000000 52:54:00:12:34:56 → Broadcast    ARP 42 Who has 10.0.2.99? Tell 10.0.2.15
    2 1.028782047 52:54:00:12:34:56 → Broadcast    ARP 42 Who has 10.0.2.99? Tell 10.0.2.15
    3 2.052803931 52:54:00:12:34:56 → Broadcast    ARP 42 Who has 10.0.2.99? Tell 10.0.2.15
3 packets captured
```

Terminal B

```sh
linux$ sudo ip neighbor flush all
linux$ date; telnet 10.0.2.99; date
Tue Jan 20 02:30:16 PM -03 2026
Trying 10.0.2.99...
telnet: Unable to connect to remote host: No route to host
Tue Jan 20 02:30:19 PM -03 2026
linux$ ip neighbor show
10.0.2.99 dev enp0s8 FAILED
10.0.4.2 dev enp0s11 lladdr 52:55:0a:00:04:02 REACHABLE
10.0.3.2 dev enp0s12 lladdr 52:55:0a:00:03:02 REACHABLE
```

## 4.8. Gratuitous ARP and Address Conflict Detection (ACD)

```sh
Linux% tcpdump -e -n arp
1      0.0 0:0:c0:6f:2d:40 ff:ff:ff:ff:ff:ff arp 60:
           arp who-has 10.0.0.56 tell 10.0.0.56
```

On archlinux this is disable by default.

```sh
linux$ sysctl net.ipv4.conf.enp0s8.arp_notify
net.ipv4.conf.enp0s8.arp_notify = 0
```

What you can see is the IPV6 version of this.

Terminal A

```sh
linux$ sudo tshark -i enp0s8 -Y "arp || icmpv6.type == 135"
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s8'
   13 0.875991960           :: → ff02::1:ff12:3456 ICMPv6 86 Neighbor Solicitation for fe80::5054:ff:fe12:3456
   27 2.755948956           :: → ff02::1:ff12:3456 ICMPv6 86 Neighbor Solicitation for fec0::5054:ff:fe12:3456
2 packets captured
```

Terminal B

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
    inet 10.0.2.15/24 metric 100 scope global dynamic enp0s8
       valid_lft 86076sec preferred_lft 86076sec
    inet6 fec0::5054:ff:fe12:3456/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 86168sec preferred_lft 14168sec
    inet6 fe80::5054:ff:fe12:3456/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
3: enp0s11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
    altname enx525400123457
    inet 10.0.4.15/24 metric 1024 brd 10.0.4.255 scope global dynamic enp0s11
       valid_lft 85124sec preferred_lft 85124sec
    inet6 fec0::5054:ff:fe12:3457/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 85916sec preferred_lft 13916sec
    inet6 fe80::5054:ff:fe12:3457/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
4: enp0s12: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:58 brd ff:ff:ff:ff:ff:ff
    altname enx525400123458
    inet 10.0.3.15/24 metric 100 brd 10.0.3.255 scope global dynamic enp0s12
       valid_lft 85124sec preferred_lft 85124sec
    inet6 fec0::5054:ff:fe12:3458/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 86312sec preferred_lft 14312sec
    inet6 fe80::5054:ff:fe12:3458/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
linux$ sudo ip link set enp0s8 down
linux$ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: enp0s8: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
    altname enx525400123456
3: enp0s11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
    altname enx525400123457
    inet 10.0.4.15/24 metric 1024 brd 10.0.4.255 scope global dynamic enp0s11
       valid_lft 85098sec preferred_lft 85098sec
    inet6 fec0::5054:ff:fe12:3457/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 85890sec preferred_lft 13890sec
    inet6 fe80::5054:ff:fe12:3457/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
4: enp0s12: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:58 brd ff:ff:ff:ff:ff:ff
    altname enx525400123458
    inet 10.0.3.15/24 metric 100 brd 10.0.3.255 scope global dynamic enp0s12
       valid_lft 85098sec preferred_lft 85098sec
    inet6 fec0::5054:ff:fe12:3458/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 86286sec preferred_lft 14286sec
    inet6 fe80::5054:ff:fe12:3458/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
linux$ sudo ip link set enp0s8 up
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
       valid_lft 86398sec preferred_lft 86398sec
    inet6 fec0::5054:ff:fe12:3456/64 scope site tentative dynamic mngtmpaddr noprefixroute
       valid_lft 86400sec preferred_lft 14400sec
    inet6 fe80::5054:ff:fe12:3456/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
3: enp0s11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
    altname enx525400123457
    inet 10.0.4.15/24 metric 1024 brd 10.0.4.255 scope global dynamic enp0s11
       valid_lft 85088sec preferred_lft 85088sec
    inet6 fec0::5054:ff:fe12:3457/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 85880sec preferred_lft 13880sec
    inet6 fe80::5054:ff:fe12:3457/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
4: enp0s12: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:58 brd ff:ff:ff:ff:ff:ff
    altname enx525400123458
    inet 10.0.3.15/24 metric 100 brd 10.0.3.255 scope global dynamic enp0s12
       valid_lft 85088sec preferred_lft 85088sec
    inet6 fec0::5054:ff:fe12:3458/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 86275sec preferred_lft 14275sec
    inet6 fe80::5054:ff:fe12:3458/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
```

# 5. The Internet Protocol (IP)
## 5.3. IPv6 Extension Headers
### 5.3.2. Routing Header

RH0 is deprecated, you cannot do it with ping anymore, you can do something like
it.

```sh
C:\> ping6 -r -s 2001:db8::100 2001:db8::1
```

Terminal A set up the monitoring.

On the result on Frame 63 what we care about is the part of "Options: (40 bytes), Record Route"
which show our success at adding a Route, on Frame 70 we see the response to a deprecated option,
the "Options:" part was dropped.

```sh
linux$ sudo tshark -i enp0s12 -V -Y "icmp"
Running as user "root" and group "root". This could be dangerous.
Capturing on 'enp0s12'
Frame 63: Packet, 138 bytes on wire (1104 bits), 138 bytes captured (1104 bits) on interface enp0s12, id 0
    Section number: 1
    Interface id: 0 (enp0s12)
        Interface name: enp0s12
    Encapsulation type: Ethernet (1)
    Arrival Time: Jan 23, 2026 14:32:00.352052573 -03
    UTC Arrival Time: Jan 23, 2026 17:32:00.352052573 UTC
    Epoch Arrival Time: 1769189520.352052573
    [Time shift for this packet: 0.000000000 seconds]
    [Time delta from previous captured frame: 4.576166 milliseconds]
    [Time since reference or first frame: 392.542161 milliseconds]
    Frame Number: 63
    Frame Length: 138 bytes (1104 bits)
    Capture Length: 138 bytes (1104 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: eth:ethertype:ip:icmp:data]
    Character encoding: ASCII (0)
Ethernet II, Src: 52:54:00:12:34:58 (52:54:00:12:34:58), Dst: 52:55:0a:00:03:02 (52:55:0a:00:03:02)
    Destination: 52:55:0a:00:03:02 (52:55:0a:00:03:02)
        .... ..1. .... .... .... .... = LG bit: Locally administered address (this is NOT the factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Source: 52:54:00:12:34:58 (52:54:00:12:34:58)
        .... ..1. .... .... .... .... = LG bit: Locally administered address (this is NOT the factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Type: IPv4 (0x0800)
    [Stream index: 0]
Internet Protocol Version 4, Src: 10.0.3.15, Dst: 8.8.8.8
    0100 .... = Version: 4
    .... 1111 = Header Length: 60 bytes (15)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
        0000 00.. = Differentiated Services Codepoint: Default (0)
        .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    Total Length: 124
    Identification: 0xcbb0 (52144)
    010. .... = Flags: 0x2, Don't fragment
        0... .... = Reserved bit: Not set
        .1.. .... = Don't fragment: Set
        ..0. .... = More fragments: Not set
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 64
    Protocol: ICMP (1)
    Header Checksum: 0x1294 [validation disabled]
    [Header checksum status: Unverified]
    Source Address: 10.0.3.15
    Destination Address: 8.8.8.8
    Options: (40 bytes), Record Route
        IP Option - No-Operation (NOP)
            Type: 1
                0... .... = Copy on fragmentation: No
                .00. .... = Class: Control (0)
                ...0 0001 = Number: No-Operation (NOP) (1)
        IP Option - Record Route (39 bytes)
            Type: 7
                0... .... = Copy on fragmentation: No
                .00. .... = Class: Control (0)
                ...0 0111 = Number: Record route (7)
            Length: 39
            Pointer: 8
            Recorded Route: 10.0.3.15
            Empty Route: 0.0.0.0 <- (next)
            Empty Route: 0.0.0.0
            Empty Route: 0.0.0.0
            Empty Route: 0.0.0.0
            Empty Route: 0.0.0.0
            Empty Route: 0.0.0.0
            Empty Route: 0.0.0.0
            Empty Route: 0.0.0.0
    [Stream index: 1]
Internet Control Message Protocol
    Type: Echo (ping) request (8)
    Code: 0
    Checksum: 0x3ef3 [correct]
    [Checksum Status: Good]
    Identifier (BE): 51903 (0xcabf)
    Identifier (LE): 49098 (0xbfca)
    Sequence Number (BE): 1 (0x0001)
    Sequence Number (LE): 256 (0x0100)
    ICMP Data: 90b0736900000000265f050000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
        Timestamp from icmp data: Jan 23, 2026 14:32:00.352038000 -03
        [Timestamp from icmp data (relative): 14.573 microseconds]
        Data (40 bytes)

0000  10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f   ................
0010  20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f    !"#$%&'()*+,-./
0020  30 31 32 33 34 35 36 37                           01234567
            Data: 101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
            [Length: 40]

Frame 70: Packet, 98 bytes on wire (784 bits), 98 bytes captured (784 bits) on interface enp0s12, id 0
    Section number: 1
    Interface id: 0 (enp0s12)
        Interface name: enp0s12
    Encapsulation type: Ethernet (1)
    Arrival Time: Jan 23, 2026 14:32:00.373228725 -03
    UTC Arrival Time: Jan 23, 2026 17:32:00.373228725 UTC
    Epoch Arrival Time: 1769189520.373228725
    [Time shift for this packet: 0.000000000 seconds]
    [Time delta from previous captured frame: 112.540 microseconds]
    [Time delta from previous displayed frame: 21.176152 milliseconds]
    [Time since reference or first frame: 413.718313 milliseconds]
    Frame Number: 70
    Frame Length: 98 bytes (784 bits)
    Capture Length: 98 bytes (784 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: eth:ethertype:ip:icmp:data]
    Character encoding: ASCII (0)
Ethernet II, Src: 52:55:0a:00:03:02 (52:55:0a:00:03:02), Dst: 52:54:00:12:34:58 (52:54:00:12:34:58)
    Destination: 52:54:00:12:34:58 (52:54:00:12:34:58)
        .... ..1. .... .... .... .... = LG bit: Locally administered address (this is NOT the factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Source: 52:55:0a:00:03:02 (52:55:0a:00:03:02)
        .... ..1. .... .... .... .... = LG bit: Locally administered address (this is NOT the factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Type: IPv4 (0x0800)
    [Stream index: 0]
Internet Protocol Version 4, Src: 8.8.8.8, Dst: 10.0.3.15
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
        0000 00.. = Differentiated Services Codepoint: Default (0)
        .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    Total Length: 84
    Identification: 0x11b7 (4535)
    010. .... = Flags: 0x2, Don't fragment
        0... .... = Reserved bit: Not set
        .1.. .... = Don't fragment: Set
        ..0. .... = More fragments: Not set
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 255
    Protocol: ICMP (1)
    Header Checksum: 0x4cd3 [validation disabled]
    [Header checksum status: Unverified]
    Source Address: 8.8.8.8
    Destination Address: 10.0.3.15
    [Stream index: 1]
Internet Control Message Protocol
    Type: Echo (ping) reply (0)
    Code: 0
    Checksum: 0x46f3 [correct]
    [Checksum Status: Good]
    Identifier (BE): 51903 (0xcabf)
    Identifier (LE): 49098 (0xbfca)
    Sequence Number (BE): 1 (0x0001)
    Sequence Number (LE): 256 (0x0100)
    [Request frame: 63]
    [Response time: 21.176 ms]
    ICMP Data: 90b0736900000000265f050000000000101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
        Timestamp from icmp data: Jan 23, 2026 14:32:00.352038000 -03
        [Timestamp from icmp data (relative): 21.190725 milliseconds]
        Data (40 bytes)

0000  10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f   ................
0010  20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f    !"#$%&'()*+,-./
0020  30 31 32 33 34 35 36 37                           01234567
            Data: 101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f3031323334353637
            [Length: 40]

2 packets captured
```

Terminal B.

```sh
linux$ ping -R -c 1 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(124) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=255 time=21.2 ms

--- 8.8.8.8 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 21.190/21.190/21.190/0.000 ms
```

### 5.3.3. Fragment Header

```sh
C:\> ping -l 3952 ff01::2
```

Set up the monitoring.

Terminal A, the "not port 22" is so tshark do not record my connection from the host
to the VM.

```sh
linux$ tshark -i any -f "not port 22" -w capture.pcap
```

Terminal B

```sh
linux$ ping -s 3952 ff01::2
ping: connect: Invalid argument
```

    Gemini

    The reason you’re getting this is that ff01::2 is a Link-Local Multicast address. 
    Because it is "Link-Local," the Linux kernel needs to know which specific cable (interface)
    to send it out on. It can't look at its routing table for the answer because that 
    address is technically valid on every interface you have.

So we specify one interface.

```sh
linux$ ping -s 3952 ff01::2%enp0s12
PING ff01::2%enp0s12 (ff01::2%4) 3952 data bytes
ping: sendmsg: Message too long
...same message keep repeating...
```

    Gemini

    Multicast Restriction: ff01::2 is a multicast address. Modern Linux kernels (and many routers)
    have safety features that prevent fragmenting multicast packets to avoid "amplification attacks"
    (where one fragmented packet turns into hundreds of fragments across a network)

How to force it to actually see the fragmentation.

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
       valid_lft 85167sec preferred_lft 85167sec
    inet6 fec0::5054:ff:fe12:3456/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 86318sec preferred_lft 14318sec
    inet6 fe80::5054:ff:fe12:3456/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
3: enp0s11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
    altname enx525400123457
    inet 10.0.4.15/24 metric 1024 brd 10.0.4.255 scope global dynamic enp0s11
       valid_lft 85167sec preferred_lft 85167sec
    inet6 fec0::5054:ff:fe12:3457/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 85825sec preferred_lft 13825sec
    inet6 fe80::5054:ff:fe12:3457/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
4: enp0s12: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 52:54:00:12:34:58 brd ff:ff:ff:ff:ff:ff
    altname enx525400123458
    inet 10.0.3.15/24 metric 100 brd 10.0.3.255 scope global dynamic enp0s12
       valid_lft 85167sec preferred_lft 85167sec
    inet6 fec0::5054:ff:fe12:3458/64 scope site dynamic mngtmpaddr noprefixroute
       valid_lft 86304sec preferred_lft 14304sec
    inet6 fe80::5054:ff:fe12:3458/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
```

Terminal A is connected to my "secure link" enp0s11, Terminal B is connected to
enp0s12, so we choose to send the package from enp0s12 to enp0s8

```sh
linux$ ping -6 -c 1 -s 3952 fec0::5054:ff:fe12:3456
```

And here I found out that fragmentation only happens when the packet is bigger than
the MTU, the kernel is smart enough to send a package through loopback instead of
the other interfaces, the MTU of loopback is "65536", now to simulate the example
set up monitoring again and do this, where I try to ping an external address.

```sh
linux$ ping -6 -c 1 -s 3952 2001:4860:4860::8888
```

Would you look at that, it do not work, for some reason my VM refuse to connect
to the internet using ipv6, so back to sending to loopback, just decrease the size
of loopback MTU.

```sh
linux$ ip link set mtu 1500 dev lo
```

Try again sending to enp0s8

```sh
linux$ ping -6 -c 1 -s 3952 fec0::5054:ff:fe12:3456
PING fec0::5054:ff:fe12:3456 (fec0::5054:ff:fe12:3456) 3952 data bytes
3960 bytes from fec0::5054:ff:fe12:3456: icmp_seq=1 ttl=64 time=0.067 ms

--- fec0::5054:ff:fe12:3456 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.067/0.067/0.067/0.000 ms
```

Later we can see what we captured.

```sh
linux$ tshark -r capture.pcap
    1 0.000000000 fec0::5054:ff:fe12:3456 → fec0::5054:ff:fe12:3456 IPv6 1512 IPv6 fragment (off=0 more=y ident=0x39616cb8 nxt=58)
    2 0.000009451 fec0::5054:ff:fe12:3456 → fec0::5054:ff:fe12:3456 IPv6 1512 IPv6 fragment (off=1448 more=y ident=0x39616cb8 nxt=58)
    3 0.000018414 fec0::5054:ff:fe12:3456 → fec0::5054:ff:fe12:3456 ICMPv6, HiPerConTracer 1128 Echo (ping) request id=0x9665, seq=1, hop limit=64 (SendTTL=20, Round=21)
    4 0.000034969 fec0::5054:ff:fe12:3456 → fec0::5054:ff:fe12:3456 IPv6 1512 IPv6 fragment (off=0 more=y ident=0x5d3ebbd2 nxt=58)
    5 0.000037457 fec0::5054:ff:fe12:3456 → fec0::5054:ff:fe12:3456 IPv6 1512 IPv6 fragment (off=1448 more=y ident=0x5d3ebbd2 nxt=58)
    6 0.000039795 fec0::5054:ff:fe12:3456 → fec0::5054:ff:fe12:3456 ICMPv6, HiPerConTracer 1128 Echo (ping) reply id=0x9665, seq=1, hop limit=64 (request in 3) (SendTTL=20, Round=21)
```

And to see one packet on detail.

```sh

linux$ tshark -r capture.pcap -V -Y "frame.number == 2"
Frame 2: Packet, 1512 bytes on wire (12096 bits), 1512 bytes captured (12096 bits) on interface any, id 0
    Section number: 1
    Interface id: 0 (any)
        Interface name: any
    Encapsulation type: Linux cooked-mode capture v1 (25)
    Arrival Time: Jan 30, 2026 14:55:44.253986596 -03
    UTC Arrival Time: Jan 30, 2026 17:55:44.253986596 UTC
    Epoch Arrival Time: 1769795744.253986596
    [Time shift for this packet: 0.000000000 seconds]
    [Time delta from previous captured frame: 9.451 microseconds]
    [Time since reference or first frame: 9.451 microseconds]
    Frame Number: 2
    Frame Length: 1512 bytes (12096 bits)
    Capture Length: 1512 bytes (12096 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: sll:ethertype:ipv6:ipv6.fraghdr:data]
    Character encoding: ASCII (0)
Linux cooked capture v1
    Packet type: Unicast to us (0)
    Link-layer address type: Loopback (772)
    Link-layer address length: 6
    Source: 00:00:00_00:00:00 (00:00:00:00:00:00)
    Unused: 0000
    Protocol: IPv6 (0x86dd)
Internet Protocol Version 6, Src: fec0::5054:ff:fe12:3456, Dst: fec0::5054:ff:fe12:3456
    0110 .... = Version: 6
    .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 (DSCP: CS0, ECN: Not-ECT)
        .... 0000 00.. .... .... .... .... .... = Differentiated Services Codepoint: Default (0)
        .... .... ..00 .... .... .... .... .... = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    .... 0011 0100 0100 0000 1011 = Flow Label: 0x3440b
    Payload Length: 1456
    Next Header: Fragment Header for IPv6 (44)
    Hop Limit: 64
    Source Address: fec0::5054:ff:fe12:3456
        [Address Space: Reserved by IETF]
    Destination Address: fec0::5054:ff:fe12:3456
        [Address Space: Reserved by IETF]
    [Stream index: 0]
    Fragment Header for IPv6
        Next header: ICMPv6 (58)
        Reserved octet: 0x00
        0000 0101 1010 1... = Offset: 181 (1448 bytes)
        .... .... .... .00. = Reserved bits: 0
        .... .... .... ...1 = More Fragments: Yes
        Identification: 0x39616cb8
Data (1448 bytes)

0000  a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af   ................
0010  b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf   ................
0020  c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf   ................
0030  d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df   ................
0040  e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef   ................
0050  f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff   ................
0060  00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f   ................
0070  10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f   ................
0080  20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f    !"#$%&'()*+,-./
0090  30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f   0123456789:;<=>?
00a0  40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f   @ABCDEFGHIJKLMNO
00b0  50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f   PQRSTUVWXYZ[\]^_
00c0  60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f   `abcdefghijklmno
00d0  70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f   pqrstuvwxyz{|}~.
00e0  80 81 82 83 84 85 86 87 88 89 8a 8b 8c 8d 8e 8f   ................
00f0  90 91 92 93 94 95 96 97 98 99 9a 9b 9c 9d 9e 9f   ................
0100  a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af   ................
0110  b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf   ................
0120  c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf   ................
0130  d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df   ................
0140  e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef   ................
0150  f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff   ................
0160  00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f   ................
0170  10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f   ................
0180  20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f    !"#$%&'()*+,-./
0190  30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f   0123456789:;<=>?
01a0  40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f   @ABCDEFGHIJKLMNO
01b0  50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f   PQRSTUVWXYZ[\]^_
01c0  60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f   `abcdefghijklmno
01d0  70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f   pqrstuvwxyz{|}~.
01e0  80 81 82 83 84 85 86 87 88 89 8a 8b 8c 8d 8e 8f   ................
01f0  90 91 92 93 94 95 96 97 98 99 9a 9b 9c 9d 9e 9f   ................
0200  a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af   ................
0210  b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf   ................
0220  c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf   ................
0230  d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df   ................
0240  e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef   ................
0250  f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff   ................
0260  00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f   ................
0270  10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f   ................
0280  20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f    !"#$%&'()*+,-./
0290  30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f   0123456789:;<=>?
02a0  40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f   @ABCDEFGHIJKLMNO
02b0  50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f   PQRSTUVWXYZ[\]^_
02c0  60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f   `abcdefghijklmno
02d0  70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f   pqrstuvwxyz{|}~.
02e0  80 81 82 83 84 85 86 87 88 89 8a 8b 8c 8d 8e 8f   ................
02f0  90 91 92 93 94 95 96 97 98 99 9a 9b 9c 9d 9e 9f   ................
0300  a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af   ................
0310  b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf   ................
0320  c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf   ................
0330  d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df   ................
0340  e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef   ................
0350  f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff   ................
0360  00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f   ................
0370  10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f   ................
0380  20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f    !"#$%&'()*+,-./
0390  30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f   0123456789:;<=>?
03a0  40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f   @ABCDEFGHIJKLMNO
03b0  50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f   PQRSTUVWXYZ[\]^_
03c0  60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f   `abcdefghijklmno
03d0  70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f   pqrstuvwxyz{|}~.
03e0  80 81 82 83 84 85 86 87 88 89 8a 8b 8c 8d 8e 8f   ................
03f0  90 91 92 93 94 95 96 97 98 99 9a 9b 9c 9d 9e 9f   ................
0400  a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af   ................
0410  b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf   ................
0420  c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf   ................
0430  d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df   ................
0440  e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef   ................
0450  f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff   ................
0460  00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f   ................
0470  10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f   ................
0480  20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f    !"#$%&'()*+,-./
0490  30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f   0123456789:;<=>?
04a0  40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f   @ABCDEFGHIJKLMNO
04b0  50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f   PQRSTUVWXYZ[\]^_
04c0  60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f   `abcdefghijklmno
04d0  70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f   pqrstuvwxyz{|}~.
04e0  80 81 82 83 84 85 86 87 88 89 8a 8b 8c 8d 8e 8f   ................
04f0  90 91 92 93 94 95 96 97 98 99 9a 9b 9c 9d 9e 9f   ................
0500  a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af   ................
0510  b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf   ................
0520  c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf   ................
0530  d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df   ................
0540  e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef   ................
0550  f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff   ................
0560  00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f   ................
0570  10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f   ................
0580  20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f    !"#$%&'()*+,-./
0590  30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f   0123456789:;<=>?
05a0  40 41 42 43 44 45 46 47                           @ABCDEFG
    Data […]: a0a1a2a3a4a5a6a7a8a9aaabacadaeafb0b1b2b3b4b5b6b7b8b9babbbcbdbebfc0c1c2c3c4c5c6c7c8c9cacbcccdcecfd0d1d2d3d4d5d6d7d8d9dadbdcdddedfe0e1e2e3e4e5e6e7e8e9eaebecedeeeff0f1f2f3f4f5f6f7f8f9fafbfcfdfeff000102030405060708090a0b0c0d0e0f101
    [Length: 1448]
```
