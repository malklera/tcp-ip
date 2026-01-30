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

Open the .conf file generate by quickget and add this at the end.

The first line adds a "secure" connection, I will not touch this one on any of
the examples.

The second one adds another network connection to simulate connections between
two networks, since I will not touch the secure one, I need another.

```
extra_args="-device virtio-net,netdev=mgmt -netdev user,id=mgmt,net=10.0.4.0/24,hostfwd=tcp::22222-:22 -device virtio-net,netdev=wifi -netdev user,id=wifi,net=10.0.3.0/24,hostfwd=tcp::22221-:22"
```

Just to keep consistency when connecting to the VM, the "secure"(as in none of
our commands will touch this device) will be port 22222, when looking into `ip addr`
we will not touch the device with the address 10.0.4.0/24.

This way no matter what changes of configuration we made, we will have a connection
to the VM to revert the changes or do something else.

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
port 22222
```

Create a file like this <number>-<descriptive name>.network, the number is the
priority at which systemd will apply the configs, the descriptive name is purelly
for he human administrator, .network is the file type.

```sh
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
ssh -p <port> <vmUser>@localhost
```

<port> will be either 22222 for the secure connection or 22221 if we need another
terminal into the VM

<vmUser> is the user name from the **VM**
