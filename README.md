Bash script of making live iso for CoreOS
=========================================

Usage
-----

```zsh
# clone my repository
$ git clone https://github.com/nyarla/coreos-live-iso
$ cd coreos-live-iso

# if you need to edit configuration parameter
$ vim makeiso.sh

# build iso file.
$ cp ~/.ssh/id_rsa.pub .
$ ./docker-build
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



