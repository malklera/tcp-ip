# Set up environmet for testing

This is not a guide, this is for my future self, or for when I end up nuking the vm and need to install it again.

## Install VM

I will use [quickemu](https://github.com/quickemu-project/quickemu) to manage my **VM**


To install quickemu I cloned the repo because of a bug on the arch package(old version)


Install dependencies

```
$ sudo pacman -S --needed --noconfirm qemu bash coreutils curl edk2-aarch64 edk2-arm edk2-ovmf gawk grep mesa-utils jq pciutils libprocps python cdrtools usbutils util-linux sed socat spice-gtk swtpm xdg-user-dirs libxrandr zsync unzip
```

Make the .local/bin directory if you do not have it, clone the repo, create symlinks to both binaries used

```
$ mkdir ~/.local/bin
$ git clone --filter=blob:none https://github.com/quickemu-project/quickemu
$ cd quickemu
$ ln -s quickemu ~/.local/bin/quickemu
$ ln -s quickget ~/.local/bin/quickget
```

Download an Arch image.

```
$ quickget archlinux latest
```

Use this config for the **VM**

```
#!/home/<user>/.local/bin/quickemu --vm
vmname="name of vm(what you prefer)"
guest_os="linux"
# <directory-name> can be custom or the default
disk_img="<directory-name>/disk.qcow2"
iso="archlinux-latest/archlinux-2025.08.01-x86_64.iso"
# this is to be able to copy from host to guest, I could not copy from guest to host
display="spice"
# if you want to connect from host to guest, for example with ssh
ssh_port="2225"
```

To open the **VM**

```
$ quickemu --vm <name-vm>.conf
```

Install the OS

- Inmediatly after finishing installing Arch and rebooting I have to do this.

**VM**

```
$ sudo pacman -S openssh
$ sudo systemctl enable --now sshd
```

```$ whoami```


**Host**

```$ ssh -p <vmUser>@localhost <port>```

<vmUser> is the user name from the **VM**

<port> Its part of the command output from quickemu, it says something like this

> - ssh:      On host:  ssh user@localhost -p <port>

Once you have connected to the **VM** run the following

```$ curl -o setArch.sh https://raw.githubusercontent.com/malklera/tcp-ip/refs/heads/main/setArch.sh```

Make the file executable

```$ chmod +x setArch.sh```

Run the script

```$ sudo ./setArch.sh```

Once everything is installed.

```$ reboot```


