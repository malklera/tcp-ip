# TCP/IP Modern tools

I am following the book *TCP/IP Illustrated, Vol. 1: The Protocols by W. Richard Stevens* second edition.

On the first command show on the examples I learnt that while the knowlege contained on this books is quite relevant today (from what I read online), some of the tools used at the moment of the writing are deprecated, so I have to go look for alternatives, I do not found a modern compiling of them, and since I have to do it to use them myself here they are.

I will only indicate Chapter and specific section where the command is used, show the actual example (is this copyright infringement??), if you want the content of the book, go buy it.

Below the example from the book will be a example run on a VM system at the moment I do it, the output of the commands will be sanitice and this is the convention to follow.

| Output | Placeholder |
| - | - |
| Binary digit | b |
| Decimal digit | d |
| Hexadecimal digit | h |
| Letter | l |

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
