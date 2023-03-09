# Operating System

## Unix & Linux System

In general, Unix is a family of operating systems that includes Linux, as well as other systems like macOS, Solaris, and FreeBSD. However, if you specifically want to check whether the operating system running on a particular machine is Linux or another Unix-like system, there are a few ways to do it:

Examples of extracting system information.

```bash
lscpu # displays information about the CPU architecture and specifications.
lspci # lists all the PCI buses and devices connected to them.
lsusb # lists all the USB buses and devices connected to them.
free -h # displays the amount of free and used memory in the system.
df # displays information about the file system usage.
cat /proc/meminfo # displays information about memory usage.
cat /proc/cpuinfo # displays information about the CPU, including its model, speed, and number of cores.
cat /proc/version # displays the Linux kernel version and other system information.
uname -a # displays detailed information about the system, including the kernel version, architecture, and hostname.
```

### Check the kernel name and version with `uname`

The kernel is the core component of the operating system, and its name and version can provide clues about the underlying system. You can check the kernel name and version by running the following command in a terminal:

`uname` is short for "UNIX name". In Unix-like operating systems, "uname" is a command-line utility that displays information about the system's kernel and operating system.

Some of the most commonly used options include:

- "-s": Displays the system's kernel name (e.g. "Linux" or "Darwin").
- "-r": Displays the system's kernel release number (e.g. "5.10.0-9-amd64").
- "-v": Displays the system's kernel version (e.g. "#1 SMP Debian 5.10.70-1 (2021-09-30)").
- "-m": Displays the system's machine hardware name (e.g. "x86_64" or "armv7l").
- "-a": Displays all of the above information, as well as the system's processor type and operating system name (e.g. "GNU/Linux").

The "uname" command is often used in shell scripts and other automation tasks to determine information about the system's kernel and operating system, which can be used to make decisions about how to run or configure software on the system.

```bash
uname -srm
```

output would be like "Linux 2.6.32-696.el6.x86_64 x86_64"

On a Linux system, this will typically output something like "Linux x86_64" or "Linux armv7l". On a Unix system, it might output something like "Darwin x86_64" (for macOS) or "SunOS sparc64" (for Solaris).

Check the distribution or version information: If the system is running a Linux-based operating system, you can often find out which distribution it is by checking the contents of the "/etc/*-release" files. For example, you can run the following command to display information about the distribution on a Debian or Ubuntu system:

```bash
cat /etc/os-release
```

This will output a list of variables that describe the system, including the distribution name and version. Other Linux distributions may use different files or methods to provide similar information.

Check the system documentation or vendor information: Finally, you can often find out whether a system is running Linux or another Unix-like operating system by consulting the documentation or vendor information for the hardware or virtualization platform it's running on. For example, if the system is running on a virtual machine hosted by a cloud provider, the provider's documentation may indicate which operating system image is being used.

### /etc

In Linux and Unix-based systems, "/etc" is a directory that is used to store **system configuration files** that are needed by various system utilities, daemons, and services.
The name "/etc" stands for "==**et cetera**==", which means "and so on" or "and other things" in Latin. The idea behind this naming convention is that the directory contains miscellaneous files that don't belong in other directories.
The "/etc" directory typically contains a variety of configuration files, including:
System-wide configuration files for various services and daemons, such as Apache, SSH, and MySQL.
Configuration files for system-level applications, such as the crontab scheduler and the fstab file system table.
Administrative scripts and scripts used during the boot process.
Various other configuration files and system-related data.
Since the files in the "/etc" directory are often critical to the proper functioning of the system, they are typically owned by the "root" user and are not accessible to regular users.

- /etc/init.d

In Linux, the "**/etc/init.d**" directory is a standard location for ==storing the startup scripts for system services==. When a Linux system boots up, it runs a series of scripts that start and stop various system services. These scripts are typically stored in the "/etc/init.d" directory and are organized by service name.

Each script in the "/etc/init.d" directory is responsible for starting or stopping a specific system service. The scripts are usually written in Bash or another scripting language and are designed to be executed with specific arguments to start or stop the associated service.

For example, a script named "apache2" in the "/etc/init.d" directory might be used to start and stop the Apache web server. When the system boots up, the startup process will execute the "apache2" script with the "start" argument to start the web server. When the system shuts down, the shutdown process will execute the "apache2" script with the "stop" argument to stop the web server.

While the "/etc/init.d" directory is still used in many Linux distributions, some distributions have switched to using the newer "systemd" system and service manager, which stores service configuration files in a different location and uses a different approach to managing system services.

- "/etc/environment": This is a system-wide configuration file that sets environment variables that apply to all users and processes on the system.

- "/etc/fstab": This is a system configuration file that is used to specify the file systems that are mounted at system startup.

- "/etc/sysctl.conf": This is a system configuration file that is used to configure various kernel parameters at system startup.

- "/etc/profile": This is a system-wide configuration file that is read by Bourne-compatible shells such as Bash when a new shell session is started. It is used to set environment variables and perform other tasks related to the system-wide shell environment.

### /var

In Linux and Unix-based systems, "/var" is a directory that is used to store **variable data files** that are generated by system processes and applications during runtime. The name "/var" stands for "==**variable**==", which refers to the fact that the files stored in this directory can change in size and content over time.
The "/var" directory typically contains a variety of files, including:
Log files generated by system processes and applications, which are stored in the "**/var/log**" subdirectory.
Spool files for print queues and other system spools, which are stored in the "/var/spool" subdirectory.
Lock files used to indicate that a resource is in use by a process, which are stored in the "**/var/lock**" subdirectory.
Cached data used by various system services, such as package managers and DNS resolvers, which are stored in the "/var/cache" subdirectory.
Temporary files used by applications and processes, which are stored in the "**/var/tmp**" subdirectory.
The "/var" directory is often stored on a separate partition or disk, to ensure that it has enough space to accommodate the variable data files generated by system processes and applications.
Since the files in the "/var" directory are often critical to the proper functioning of the system, they are typically owned by the "root" user and are not accessible to regular users.

### /proc

In Linux, the "/proc" directory is a **virtual file system** that provides information about running ==**processes**== and other system information in **real-time**. It is **not** a physical file system and **does not** contain actual files on disk, but instead, it is a window into the **kernel's internal data structures**.

The "/proc" directory contains a hierarchy of subdirectories and files, each of which corresponds to a specific **system resource or process**. For example, the "/proc/cpuinfo" file provides information about the CPU, including its model, speed, and number of cores. Similarly, the "/proc/meminfo" file provides information about memory usage, and the "/proc/sys" directory contains files that allow you to view and modify various system settings.

Since the information in the "/proc" directory is updated in real-time, it can be a useful tool for monitoring system performance and troubleshooting issues. However, it is important to note that the information in "/proc" is dynamic and may change rapidly, so it should be used with caution and only by experienced users who understand the underlying system architecture.

Examples to check real-time system information:

```bash
cat /proc/meminfo # displays information about memory usage.
cat /proc/cpuinfo # displays information about the CPU, including its model, speed, and number of cores.
cat /proc/version # displays the Linux kernel version and other system information.
```

### /usr

In Linux, the "/usr" directory is a standard subdirectory of the root file system, and it contains a variety of user-related files and directories.

The "/usr" directory stands for "==**Unix System Resources**==", and it is used to store most of the user-accessible files and programs on the system. It is typically mounted on a separate file system, which allows it to be shared across multiple machines or to be mounted read-only to improve system security.

The "/usr" directory is organized into several subdirectories, each with a specific purpose:

"/usr/bin": This directory contains most of the user-executable programs and utilities.
"/usr/sbin": This directory contains system administration programs that are typically used by the system administrator.
"/usr/lib": This directory contains libraries that are used by the programs in "/usr/bin" and "/usr/sbin".
"/usr/share": This directory contains architecture-independent data files that are shared by different packages.
"/usr/include": This directory contains header files that are needed to compile C and C++ programs.
"/usr/local": This directory contains programs, libraries, and other files that are not included in the standard distribution of the operating system, but are installed locally by the system administrator or third-party software.
In summary, the "/usr" directory is an essential part of the Linux file system hierarchy, and it contains a wide range of files and directories that are used by the operating system and its users.

### /bin & /sbin

In Linux, both the "/bin" and "/sbin" directories are subdirectories of the root file system, but they have different purposes.

The "/bin" directory stands for "==**binary**==", and it contains essential user-level programs and utilities that are needed for basic system operations and maintenance. These programs are typically used by all users on the system and do not require administrative privileges to run. Examples of programs that are stored in the "/bin" directory include "ls", "cp", "mv", "rm", and "cat".

The "/sbin" directory stands for "==**system binary**==", and it contains system-level programs and utilities that are used for system administration and maintenance tasks. These programs are typically used by system administrators and require administrative privileges to run. Examples of programs that are stored in the "/sbin" directory include "ifconfig", "iptables", "fdisk", "mount", and "shutdown".

In summary, the main difference between the "/bin" and "/sbin" directories is the type of programs and utilities that they contain. The "/bin" directory contains essential user-level programs that are used by all users on the system, while the "/sbin" directory contains system-level programs that are used for system administration and maintenance tasks and require administrative privileges to run.

### /opt

In Linux, "/opt" stands for "**optional**" and it is a directory where ==optional software== can be installed.

Unlike the "/usr" directory which contains software packages that are installed using the system's package manager, the "/opt" directory is usually used for installing software that is not part of the core operating system or that is not available through the system's package manager.

Many commercial software vendors use the "/opt" directory to install their software, as it provides a standard location for installation and makes it easy to manage the software separately from the operating system.

The "/opt" directory is typically located at the root level of the file system, and its subdirectories may contain software packages organized by vendor or application name.

## X Window System (GUI)

The X Window System, also known as **X11** or simply X, is a computer software system that provides a graphical user interface (**GUI**) for Unix-like operating systems such as Linux, FreeBSD, and OpenBSD. It was first developed in 1984 by the Massachusetts Institute of Technology (MIT) and has since become ==the standard GUI for Unix-based systems==.

The X Window System is a **client-server** system, where the user's computer runs a client program that communicates with the X server running on the computer where the display is physically attached. The X server manages the graphical display and input devices such as the mouse and keyboard, while the client programs provide the user interface.

One of the key features of the X Window System is its ability to run multiple applications simultaneously, each in its own window. This allows users to easily switch between different programs and to arrange them on the screen in any way they like. Additionally, the X Window System provides a network-transparent architecture, which means that applications running on one computer can be displayed on another computer over a network.

The X Window System has been widely adopted in the Unix and Linux communities, and many popular desktop environments and window managers such as GNOME, KDE, and Xfce are built on top of it.

## Shell (CLI)

In computing, **a shell is a program that provides a command-line interface (CLI) to interact with the operating system (OS) and execute commands**. It is the outermost layer of the OS that sits between the user and the kernel, which is the core component of the OS responsible for managing system resources and running applications.

A shell allows users to type commands in a terminal or console window, and it interprets those commands and translates them into system calls that the kernel can understand and execute. The shell also provides various features such as command history, tab completion, and scripting capabilities, which can be used to automate tasks and perform complex operations.

There are several different types of shells available in Linux and other Unix-like operating systems, including the Bourne shell (sh), the C shell (csh), the Korn shell (ksh), the Bourne-Again shell (bash), and the Z shell (zsh). Each shell has its own set of features and capabilities, and users can choose the shell that best fits their needs and preferences.

### Set environment variables

You can set environment variables using the `export` command followed by the variable name and value. Here's the basic syntax: 

```bash
export VARIABLE_NAME=value
```

This command adds the /path/to/new/directory directory to the existing PATH environment variable. Note that the $PATH syntax is used to reference the current value of PATH and add the new directory to it.

To make the changes to the environment variable **permanent**, you can add the `export` command to the appropriate shell configuration file, such as `~/.bashrc` or `~/.bash_profile`.

For example, to set the PATH environment variable to include a new directory, you can use the following command:

```bash
export PATH=$PATH:/path/to/new/directory
```

After following these steps, the environment variable will be set permanently and will be available in all future Bash sessions.

### Bash

Bash (Bourne-Again Shell) is a Unix-like shell that is a replacement for the original Bourne shell (sh) and the C shell (csh). It was developed by Brian Fox for the GNU Project as a free software alternative to the proprietary shells that were commonly used in Unix systems at the time.

- `~/.bashrc`: This is a file that is read by the Bash shell every time a new shell session is started for a user. It typically contains customizations and settings specific to the user's environment, such as aliases, environment variables, and shell options.

- `~/.profile`: This is a file that is read by the Bash shell or other Bourne-compatible shells when a new shell session is started. It is similar to ".bash_profile", but is used by other shells in addition to Bash.

- `~/.bash_profile`: This is another file that is read by the Bash shell when a new shell session is started. It is typically used to set environment variables and perform other tasks related to the user's login session.

- `~/.bash_logout`: This is a file that is read by the Bash shell when a user logs out. It can be used to perform tasks such as clearing the screen or printing a logout message.

- `~/.inputrc`: This is a file that contains settings for the Readline library, which is used by many command-line programs in Linux. It can be used to customize command-line editing and history features.

**Reload** the bash file to apply the changes: `source ~/.bashrc`

### Zsh

Zsh (Z shell) is a Unix-like shell that is an extended version of the Bourne shell (sh) and the Korn shell (ksh) with many additional features and improvements. It was developed in the early 1990s by Paul Falstad and has since become a popular alternative to other Unix shells, particularly the Bash shell.

To set the user environment add `export PATH=$PATH:/your/custom/path` to below places:

- `/etc/zshenv`: This is a system-wide configuration file that is read by Zsh before any other files. You can set the PATH variable ==system-wide== by adding the following line to the `/etc/zshenv` file:

- `~/.zshenv`: This is a user-specific configuration file that is read by Zsh before any other files. You can add directories to the PATH variable for your user account only by adding the following line to the ~/.zshenv file:

- `~/.zshrc`: This is a user-specific configuration file that is read by Zsh when a new shell session is started. You can add directories to the PATH variable for your user account only by adding the following line to the `~/.zshrc` file:

- `~/.zprofile`: This is a user-specific configuration file that is read by Zsh when a user logs in. You can add directories to the PATH variable for your user account only by adding the following line to the `~/.zprofile` file:

It's important to note that changes made to the PATH variable in a terminal session will only apply to that session and its child processes. To make the changes apply to all new terminal sessions, you need to edit one of the files listed above.

## Permission

Linux uses a permissions model where each file and directory has an owner, group, and a set of permissions that determine who can access the file, and what actions they can perform on it. The permissions include read, write, and execute permissions, and they can be set for the owner of the file, the group associated with the file, and others (everyone else).

Linux systems also have user accounts and groups that are used to grant users access to specific resources and operations. A user can be a member of one or more groups, and each group can have specific permissions set for it.

Some of the tools and techniques used for Linux privilege control include:

User Accounts and Groups: User accounts and groups are used to manage and control access to resources and operations. Each user account has its own set of permissions, and group memberships can be used to grant or restrict access to resources.

- File Permissions: File permissions are used to control access to files and directories. Each file and directory has an owner, a group, and a set of permissions that determine who can access the file and what actions they can perform on it.

- Sudo: Sudo is a command that allows a user to execute commands with the privileges of another user, such as the root user. This is useful for performing administrative tasks without logging in as the root user.

- SELinux: SELinux (Security-Enhanced Linux) is a security module that provides access control mechanisms for Linux systems. It can be used to control access to files, directories, and network resources.

- AppArmor: AppArmor is a Linux kernel security module that provides mandatory access control (MAC) for applications. It can be used to control access to files, directories, and other resources based on an application's profile.

The string "-rw-rw-r--." represents the file permissions for a file in a Linux or Unix system.

Each character in the string represents a set of permissions. The first character indicates the file type (- for a regular file, d for a directory, and so on), and the next nine characters represent the file permissions.

The file permissions are divided into three sets of three characters each:

1. The first set of characters represents the permissions for the ==file owner==
2. the second set represents the permissions for the ==group owner== of the file
3. and the third set represents the permissions for all ==other users==

### Check permissions of a file with `ls -l`
`ls -l /var/log/secure`
Or
`stat /var/log/secure`

Here's how to interpret the file permissions in the string "-rw-rw-r--.":

The first character "-" indicates that this is a regular file.
The next three characters "rw-" indicate that the file owner has read and write permissions, but does not have execute permission.
The next three characters "rw-" indicate that the group owner of the file has read and write permissions, but does not have execute permission.
The next three characters "r--" indicate that all other users have read permission only.
The dot at the end of the string indicates that there are no special permissions or attributes set for this file.

## Owner and Owner Group

In Linux and Unix-based systems, every file and directory is associated with a **user owner** and a **group owner**. The owner of a file or directory is typically the user who created it, and the group owner is a group to which the user belongs.

The owner of a file or directory has the highest level of control over it, and can perform all operations on it, including modifying its permissions, changing its contents, and deleting it. The group owner has a lower level of control, and can only perform operations that are allowed by the file or directory's permissions.

The group owner is often used to provide access to multiple users who need to work with the same files or directories. For example, a web development team might create a group to which all team members belong, and assign that group ownership of the web server's files and directories. This way, each team member can access and modify the files, but other users outside the group cannot.

When a new file or directory is created, the user owner and group owner are set according to the user who created it and their default group. These ownership settings can be changed using the "chown" command to change the user owner, and the "chgrp" command to change the group owner.

### List all groups

In a Linux or Unix-based system, you can use the "==getent==" command with the "group" parameter. Here's the syntax:
`getent group`
This will display a list of all the groups in the system, along with their GID (group ID) and a list of all the users who are members of each group.

or
`cat /etc/group`
This will display the contents of the "/etc/group" file, which includes a list of all the groups in the system, along with their GID and a list of all the users who are members of each group.

Note that you will need root or sudo privileges to execute these commands, as they display system-wide information that is not accessible to regular users.

### Check user group

`groups jack`
or
`id jack`

### Change Owner with `chown`

In Unix-like operating systems, "chown" is a command-line utility that is used to change the ownership of files and directories. The name "chown" is short for "**change owner**."

Using the "chown" command, you can change the owner of a file or directory to a specific user, as well as change the group ownership of a file or directory to a specific group.

The syntax of the "chown" command is as follows:

```bash
chown [OPTIONS] USER[:GROUP] FILE
```

Here, "USER" represents the **new owner** of the file or directory, "GROUP" represents the **new group owner** of the file or directory (optional), and "FILE" represents the name of the file or directory whose ownership needs to be changed.

Some common options of the "chown" command are:

- "-R" or "--recursive": changes the ownership of a directory and its contents recursively.
- "-v" or "--verbose": shows verbose output of the command's execution.

Example

```bash
chown newowner:newgroup filename
chown newuser:newgroup myfile.txt
chown john file.txt  # change the owner of "file.txt" to a user named "john"
chown :staff file.txt  # change group ownership of "file.txt" to a group named "staff"
```


