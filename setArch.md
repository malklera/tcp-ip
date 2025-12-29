# Set up environmet for testing

This is not a guide, this is for my future self, or for when I end up nuking the vm and need to install it again.

## Install VM

I will use [quickemu](https://github.com/quickemu-project/quickemu) to manage my **VM**


To install quickemu I cloned the repo because of a bug on the arch package(old version)


Install dependencies

```sh
sudo pacman -S --needed --noconfirm qemu bash coreutils curl edk2-aarch64 edk2-arm edk2-ovmf gawk grep mesa-utils jq pciutils libprocps python cdrtools usbutils util-linux sed socat spice-gtk swtpm xdg-user-dirs libxrandr zsync unzip
```

Make the .local/bin directory if you do not have it, clone the repo, create symlinks to both binaries used

```sh
mkdir ~/.local/bin
git clone --filter=blob:none https://github.com/quickemu-project/quickemu
ln -s quickemu/quickemu ~/.local/bin/quickemu
ln -s quickemu/quickget ~/.local/bin/quickget
```

Download an Arch image, I have problems running the command outside of the HOME
directory, may check it later.

```sh
quickget archlinux latest
```

Open the .conf file generate by quickget and add this line at the end.

```
extra_args="-device virtio-net,netdev=mgmt -netdev user,id=mgmt,net=10.0.4.0/24,hostfwd=tcp::22221-:22"
```

To open the **VM**

```sh
quickemu --vm <name-vm>.conf
```

Install the OS, I choose a minimal server type install where only ssh is installed.

Inmediatly after finishing installing Arch and rebooting I have to do this.

```sh
sudo pacman -S --needed --noconfirm vim
```

**VM**

Now the important part, we will be making several network changes, since i will
be connected from Host to Guest with SSH, if I change the network config I may
loose the connection, to prevent that we have the extra_args on the VM config file,
that give use a second connection to the VM, the connection created by default by
quickemu will be our "testing" connection, all examples will be run with that one,
the one we added will be our "secure" connection, when we mess up the testing connection
we can fix it using the secure connection.

Identify the available connections.

```sh
ip addr
```

We know the secure ip because we added manually.

Secure.

```
inet 10.0.4.15/24
port 22221
```

Create a file like this <number>-<descriptive name>.network, the number is the
priority at which systemd will apply the configs, the descriptive name is purelly
for he human administrator, .network is the file type.

```
sudo vim /etc/systemd/network/10-mgmt.network
```

Inside that file will be put this, where <name connection> is the name asigne to
the connection we created, the one with address "10.0.4.15/24" given by ```ip addr```

```
[Match]
Name=<name connection>

[Network]
DHCP=yes

[DHCPv4]
UseRoutes=false
```

Check which program is managing the network.

```sh
ps aux | grep -Ei 'NetworkManager|systemd-networkd|dhcpcd|connman|wicked'
```

If needed disable with.

```sh
sudo systemctl disable --now <name-process>
```

And if needed activated systemd-networkd.

```sh
sudo systemctl enable --now systemd-networkd
```

The testing one is generated, so the other connection that is not loopback is
the one we will be using.


**Host**

```sh
ssh -p <vmUser>@localhost <port>
```

<vmUser> is the user name from the **VM**

<port> Its part of the command output from quickemu, it says something like this

> - ssh:      On host:  ssh user@localhost -p <port>

# Tools to use on the VM
## 
