# UNIX/Linux Bash

## file system hierarchy

[Filesystem Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)
`$ man hier`
[hier - description of the file system hierarchy](https://linux.die.net/man/7/hier)

[some history/background with /bin vs /sbin vs /usr/bin vs /usr/sbin](http://lists.busybox.net/pipermail/busybox/2010-December/074114.html)


## tar/tar.gz

TAR is short for "Tape Archive".
It is used to store multiple files in one single file. But it is **only** for storing data, **not** compressing it.
TAR files are often compressed after being created. And then the extension would become: tgz, tar.gz or gz.

* Unix command to open a TAR file without any external programs:
`$ tar -xvf file.tar`

* Unix command to create a **compressed** TAR file:

`$ tar -czvf file.tar.gz /path/to/folder-or-file`

* -c: create an archive
* -z: use gzip to **compress** the archive
* -v: enable verbose mode to show the progress of the creation process
* -f: let you specify the name of the archive