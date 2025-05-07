# otus_homework
Занятие 1. Обновление ядра системы
Цель домашнего задания
Научиться обновлять ядро в ОС Linux.

Выполнение:

user01@ubuntu01:~$ sudo hostnamectl
 Static hostname: ubt01
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 7b0829f54e214905a195db96cb108691
         Boot ID: 02451497eaef4ae299817726eef5b356
  Virtualization: vmware
Operating System: Ubuntu 22.04.5 LTS
          Kernel: Linux 5.15.0-131-generic
    Architecture: x86-64
user01@ubuntu01:~$  mkdir kernel && cd kernel
wget https://kernel.ubuntu.com/mainline/v6.14.4/amd64/linux-headers-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb
wget https://kernel.ubuntu.com/mainline/v6.14.4/amd64/linux-headers-6.14.4-061404_6.14.4-061404.202504251003_all.deb
wget https://kernel.ubuntu.com/mainline/v6.14.4/amd64/linux-image-unsigned-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb
wget https://kernel.ubuntu.com/mainline/v6.14.4/amd64/linux-modules-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb
sudo apt install *.deb
--2025-05-07 19:00:02--  https://kernel.ubuntu.com/mainline/v6.14.4/amd64/linux-headers-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb
Resolving kernel.ubuntu.com (kernel.ubuntu.com)... 185.125.189.76, 185.125.189.74, 185.125.189.75
Connecting to kernel.ubuntu.com (kernel.ubuntu.com)|185.125.189.76|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3590738 (3.4M) [application/x-debian-package]
Saving to: ‘linux-headers-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb’

linux-headers-6.14.4-061404-generic_6.14.4-0 100%[===========================================================================================>]   3.42M  5.23MB/s    in 0.7s    

2025-05-07 19:00:04 (5.23 MB/s) - ‘linux-headers-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb’ saved [3590738/3590738]

--2025-05-07 19:00:04--  https://kernel.ubuntu.com/mainline/v6.14.4/amd64/linux-headers-6.14.4-061404_6.14.4-061404.202504251003_all.deb
Resolving kernel.ubuntu.com (kernel.ubuntu.com)... 185.125.189.74, 185.125.189.76, 185.125.189.75
Connecting to kernel.ubuntu.com (kernel.ubuntu.com)|185.125.189.74|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 13971460 (13M) [application/x-debian-package]
Saving to: ‘linux-headers-6.14.4-061404_6.14.4-061404.202504251003_all.deb’

linux-headers-6.14.4-061404_6.14.4-061404.20 100%[===========================================================================================>]  13.32M  8.62MB/s    in 1.5s    

2025-05-07 19:00:06 (8.62 MB/s) - ‘linux-headers-6.14.4-061404_6.14.4-061404.202504251003_all.deb’ saved [13971460/13971460]

--2025-05-07 19:00:06--  https://kernel.ubuntu.com/mainline/v6.14.4/amd64/linux-image-unsigned-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb
Resolving kernel.ubuntu.com (kernel.ubuntu.com)... 185.125.189.75, 185.125.189.74, 185.125.189.76
Connecting to kernel.ubuntu.com (kernel.ubuntu.com)|185.125.189.75|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 15769792 (15M) [application/x-debian-package]
Saving to: ‘linux-image-unsigned-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb’

linux-image-unsigned-6.14.4-061404-generic_6 100%[===========================================================================================>]  15.04M  8.74MB/s    in 1.7s    

2025-05-07 19:00:08 (8.74 MB/s) - ‘linux-image-unsigned-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb’ saved [15769792/15769792]

--2025-05-07 19:00:08--  https://kernel.ubuntu.com/mainline/v6.14.4/amd64/linux-modules-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb
Resolving kernel.ubuntu.com (kernel.ubuntu.com)... 185.125.189.74, 185.125.189.75, 185.125.189.76
Connecting to kernel.ubuntu.com (kernel.ubuntu.com)|185.125.189.74|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 159488192 (152M) [application/x-debian-package]
Saving to: ‘linux-modules-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb’

linux-modules-6.14.4-061404-generic_6.14.4-0 100%[===========================================================================================>] 152.10M  10.6MB/s    in 15s     

2025-05-07 19:00:23 (10.3 MB/s) - ‘linux-modules-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb’ saved [159488192/159488192]

Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
user01@ubuntu01:~/kernel$ sudo dpkg -i *.deb 
Selecting previously unselected package linux-headers-6.14.4-061404.
(Reading database ... 110496 files and directories currently installed.)
Preparing to unpack linux-headers-6.14.4-061404_6.14.4-061404.202504251003_all.deb ...
Unpacking linux-headers-6.14.4-061404 (6.14.4-061404.202504251003) ...
Selecting previously unselected package linux-headers-6.14.4-061404-generic.
Preparing to unpack linux-headers-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb ...
Unpacking linux-headers-6.14.4-061404-generic (6.14.4-061404.202504251003) ...
Selecting previously unselected package linux-image-unsigned-6.14.4-061404-generic.
Preparing to unpack linux-image-unsigned-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb ...
Unpacking linux-image-unsigned-6.14.4-061404-generic (6.14.4-061404.202504251003) ...
Selecting previously unselected package linux-modules-6.14.4-061404-generic.
Preparing to unpack linux-modules-6.14.4-061404-generic_6.14.4-061404.202504251003_amd64.deb ...
Unpacking linux-modules-6.14.4-061404-generic (6.14.4-061404.202504251003) ...
Setting up linux-headers-6.14.4-061404 (6.14.4-061404.202504251003) ...
dpkg: dependency problems prevent configuration of linux-headers-6.14.4-061404-generic:
 linux-headers-6.14.4-061404-generic depends on libc6 (>= 2.38); however:
  Version of libc6:amd64 on system is 2.35-0ubuntu3.9.
 linux-headers-6.14.4-061404-generic depends on libdw1t64 (>= 0.171); however:
  Package libdw1t64 is not installed.
 linux-headers-6.14.4-061404-generic depends on libelf1t64 (>= 0.144); however:
  Package libelf1t64 is not installed.
 linux-headers-6.14.4-061404-generic depends on libssl3t64 (>= 3.0.0); however:
  Package libssl3t64 is not installed.

dpkg: error processing package linux-headers-6.14.4-061404-generic (--install):
 dependency problems - leaving unconfigured
Setting up linux-modules-6.14.4-061404-generic (6.14.4-061404.202504251003) ...
Setting up linux-image-unsigned-6.14.4-061404-generic (6.14.4-061404.202504251003) ...
I: /boot/vmlinuz.old is now a symlink to vmlinuz-5.15.0-139-generic
I: /boot/initrd.img.old is now a symlink to initrd.img-5.15.0-139-generic
I: /boot/vmlinuz is now a symlink to vmlinuz-6.14.4-061404-generic
I: /boot/initrd.img is now a symlink to initrd.img-6.14.4-061404-generic
Processing triggers for linux-image-unsigned-6.14.4-061404-generic (6.14.4-061404.202504251003) ...
/etc/kernel/postinst.d/initramfs-tools:
update-initramfs: Generating /boot/initrd.img-6.14.4-061404-generic
/etc/kernel/postinst.d/zz-update-grub:
Sourcing file `/etc/default/grub'
Sourcing file `/etc/default/grub.d/init-select.cfg'
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-6.14.4-061404-generic
Found initrd image: /boot/initrd.img-6.14.4-061404-generic
Found linux image: /boot/vmlinuz-5.15.0-139-generic
Found initrd image: /boot/initrd.img-5.15.0-139-generic
Found linux image: /boot/vmlinuz-5.15.0-131-generic
Found initrd image: /boot/initrd.img-5.15.0-131-generic
Warning: os-prober will not be executed to detect other bootable partitions.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
Adding boot menu entry for UEFI Firmware Settings ...
done
Errors were encountered while processing:
 linux-headers-6.14.4-061404-generic
user01@ubuntu01:~/kernel$ sudo apt --fix-broken install
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Correcting dependencies... Done
The following packages will be REMOVED:
  linux-headers-6.14.4-061404-generic
0 upgraded, 0 newly installed, 1 to remove and 3 not upgraded.
1 not fully installed or removed.
After this operation, 29.3 MB disk space will be freed.
Do you want to continue? [Y/n] Y
(Reading database ... 149696 files and directories currently installed.)
Removing linux-headers-6.14.4-061404-generic (6.14.4-061404.202504251003) ...                                                                                                    
needrestart is being skipped since dpkg has failed                                                                                                                               
user01@ubuntu01:~/kernel$ sudo apt install --reinstall linux-headers-6.14.4-061404-generic                                                                                       
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Package linux-headers-6.14.4-061404-generic is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source

E: Package 'linux-headers-6.14.4-061404-generic' has no installation candidate
user01@ubuntu01:~/kernel$  ls -al /boot
total 439204
drwxr-xr-x  5 root root      4096 May  7 19:06 .
drwxr-xr-x 20 root root      4096 Feb  3 15:09 ..
-rw-r--r--  1 root root    262228 Jan 10 17:45 config-5.15.0-131-generic
-rw-r--r--  1 root root    262228 Apr 11 20:45 config-5.15.0-139-generic
-rw-r--r--  1 root root    295497 Apr 25 10:03 config-6.14.4-061404-generic
drwxr-xr-x  3 root root      4096 Jan  1  1970 efi
drwxr-xr-x  5 root root      4096 May  7 19:06 grub
lrwxrwxrwx  1 root root        32 May  7 19:05 initrd.img -> initrd.img-6.14.4-061404-generic
-rw-r--r--  1 root root 106328863 May  7 18:57 initrd.img-5.15.0-131-generic
-rw-r--r--  1 root root 106338385 May  7 18:57 initrd.img-5.15.0-139-generic
-rw-r--r--  1 root root 174445407 May  7 19:06 initrd.img-6.14.4-061404-generic
lrwxrwxrwx  1 root root        29 May  7 19:05 initrd.img.old -> initrd.img-5.15.0-139-generic
drwx------  2 root root     16384 Feb  3 15:01 lost+found
-rw-------  1 root root   6294491 Jan 10 17:45 System.map-5.15.0-131-generic
-rw-------  1 root root   6295634 Apr 11 20:45 System.map-5.15.0-139-generic
-rw-------  1 root root   9981345 Apr 25 10:03 System.map-6.14.4-061404-generic
lrwxrwxrwx  1 root root        29 May  7 19:05 vmlinuz -> vmlinuz-6.14.4-061404-generic
-rw-------  1 root root  11714568 Jan 10 20:01 vmlinuz-5.15.0-131-generic
-rw-------  1 root root  11719272 Apr 11 21:19 vmlinuz-5.15.0-139-generic
-rw-------  1 root root  15737344 Apr 25 10:03 vmlinuz-6.14.4-061404-generic
lrwxrwxrwx  1 root root        26 May  7 19:05 vmlinuz.old -> vmlinuz-5.15.0-139-generic
user01@ubuntu01:~/kernel$ sudo update-grub
Sourcing file `/etc/default/grub'
Sourcing file `/etc/default/grub.d/init-select.cfg'
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-6.14.4-061404-generic
Found initrd image: /boot/initrd.img-6.14.4-061404-generic
Found linux image: /boot/vmlinuz-5.15.0-139-generic
Found initrd image: /boot/initrd.img-5.15.0-139-generic
Found linux image: /boot/vmlinuz-5.15.0-131-generic
Found initrd image: /boot/initrd.img-5.15.0-131-generic
Warning: os-prober will not be executed to detect other bootable partitions.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
Adding boot menu entry for UEFI Firmware Settings ...
done
user01@ubuntu01:~/kernel$ sudo grub-set-default 0
user01@ubuntu01:~/kernel$ sudo reboot
Connection to 192.168.1.151 closed by remote host.
Connection to 192.168.1.151 closed.
PS D:\VSCode> 
PS D:\VSCode> ssh user01@192.168.1.151
user01@192.168.1.151's password: 
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.14.4-061404-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Wed May  7 07:11:30 PM UTC 2025

  System load:             0.63
  Usage of /:              46.5% of 13.16GB
  Memory usage:            13%
  Swap usage:              0%
  Processes:               252
  Users logged in:         0
  IPv4 address for ens160: 192.168.1.151
  IPv6 address for ens160: fdab:da60:a213:0:20c:29ff:fe47:f416


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status

New release '24.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Wed May  7 18:52:05 2025 from 192.168.1.48
user01@ubt01:~$ sudo hostnamectl
[sudo] password for user01: 
 Static hostname: ubt01
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 7b0829f54e214905a195db96cb108691
         Boot ID: deaa8dd982c54d2c8791e9c4e5869a42
  Virtualization: vmware
Operating System: Ubuntu 22.04.5 LTS
          Kernel: Linux 6.14.4-061404-generic
    Architecture: x86-64
 Hardware Vendor: VMware, Inc.
  Hardware Model: VMware7,1
user01@ubt01:~$ 



