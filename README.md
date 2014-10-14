Bash script of making live iso for CoreOS
=========================================

Usage
-----

```zsh
# clone my repository
$ git clone https://github.com/nyarla/coreos-live-iso
$ cd coreos-live-iso
$ git checkout sakura-vps

# Create config files
$ cp ~/.ssh/id_rsa.pub .
$ ./sakuravps-configure

# if you need to edit configuration parameter on Dockerfile
$ ./build

# Upload ISO
$ sftp vps0000@example.com 0< sftp-cmd
```

Requirements
------------
* `docker`

Author
------

Naoki OKAMURA (Nyarla) *nyarla[ at ]thotep.net*

Unlicense
---------

`makeiso.sh` is under the public domain.



