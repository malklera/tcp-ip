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

I used [quickemu] to set up my VMs, but it may have been easer to use [qemu] directly for the dependencies problems I have to dealt with, but I disgress.

- Install [qemu].
- Build [quickemu] from source, I have a problem with the package being an old version.
> If you are building from source, you will have to download/build the dependencies, depending of where you are using it from.

**System where the new commands where used**
I created two VMs with quickemu

For linux system I choose a minimal install of Arch

`$ uname -a`
``

For Windows I choose Windows 10

``

I will not look for tools for MacOs because I do not think I will ever touch one.

~~If you use a system where this tools are not available, I do not care, good luck. And not, this document is not an excuse to say that I use Arch btw~~

2. The Internet Address Architecture
2.3. Basic IP Address Structure
2.3.6. IPv6 Addresses and Interface Identifiers
2.3.6.1. Examples


```
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

```

```

[//]:
[qemu]: <https://www.qemu.org>
[quickemu]: <https://github.com/quickemu-project/quickemu>
