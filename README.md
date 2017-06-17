Bash Utility Commands
=====================

This repo is a few bash utilities I wrote, that others may find useful. 

## Downloads

Check the [releases page](https://github.com/jfogarty/bash-utility-commands/releases) to get the latest distribution.

## Documentation

### Commands ###

- **t** : Go to a directory with history and adaptation
- **path** : Modify or display a path
- **md** : Make a directory and subdirectories
- **ipv6** : Dynamically enable and disable IPV6 interfaces
- **tpad** : Enable or disable the touchpad
- **osinfo** : Display operating system info
- **vbssh** : Log into a Virtual Box VM via ssh

Each command supports -? for documentation.

### `toDir` (alias `t`)

Since I'm a bad typist, I have trouble typing long path names. When navigating
the shell I find this tool invaluable. Every time you use it the current
directory is added to the memo file. Changing directories is done by typing either a bottom level directory or any part of the directory name. 

```
$ toDir -v?
Usage: . toDir [options] [dir]
Go to a recently used directory.

-l             list the current memofile.
-q             quiet output - only errors displayed.
-v             verbose output during command execution.

Each time you use 'toDir', the current directory is put at the
top of a list of available directories.  The 'dir' you specify is
looked up in the list and chdir to that directory is issued.
You can also use any valid relative directory name.
Use .. or ... or  .... to pop to previous directories.

NOTE you must source command with the prefixed '. ' or source:

    . toDir [options] [dir]

otherwise the cd command will just be displayed and you will
stay in the current directory.

I place an alias t=. toDir in my .bashrc file for convenience.
```

### `toPath` (alias `path`)

Modifying path environment variables is a pain. This makes it easy to add new directories, usually to the start of PATH. You can use -a to append the directory, or just type 'path' to get a nice list of the directories.

The directory set is scanned to see if there are duplicates or non-existant
directories, and these are noted. You can use '-c' to remove these errors.

Specify a different PATH variable with '-e', and remove a directory from the
list with '-d'.

```
$ toPath -v?
Usage: . toPath [options] [newdir]
Display or append to a PATH environment variable

-a             append to the path (default: prepend).
-c             clean the path (remove duplicates and missing dirs).
-d             delete the specified path.
-e[EnvVar]     select the variable to modify.
-q             quiet output - only errors displayed.
-t             terse - compact output.
-v             verbose output during command execution.

The PATH variable (or the one selected by -e) is displayed or
modified. By default a new directory is prepended. Use -a to append
to the path.

NOTE to modify a PATH variable you must source the path command with:

    . toPath [options] [dir]

otherwise the result will just be the command needed to make the change
without actually doing it.

I place an alias path=. toPath in my .bashrc file for convenience.
```

### `md` 

Trivial mkdir but has nice option handling for hacking.

```
$ md -?
Usage: md [OPTION]... DIRECTORY...
Create the DIRECTORY(ies), if they do not already exist.
This always creates the parent directories as required.

A short form of mkdir with fewer options.
  -h, --help     display this help and exit
  -v, --version  output version information and exit
  -t, --trial    trial mode. Show the commands that would execute
```


### `ipv6`

Convenient tool to dynamically enable and disable ipv6 interfaces.

```
Usage: ipv6 [options] [off|on]
Display, enable or disable the IPV6 interfaces

Options:

  -a    control all interfaces
  -e    control/list ethernet (cabled) interfaces
  -w    list only wireless interfaces

  -v    verbose output during command execution
  -q    quiet mode. Disables all console output
  -t    trial run -- commands are shown but not executed

When no options are passed this displays the current
IPV6 state for all interfaces. When off or on is passed
this will control wireless interfaces only unless -e or -a
have been used.
```

### `tpad` 

Utility to disable the annoying touchpad on my laptop when I'm using a mouse. 
Should work on many systems, but you'll need to look at your devices to be sure.

```
tpad -?
Usage: /home/john/bin/tpad [off|on]
Enable or disable the ASUS R510D Touchpad

⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
⎜   ↳ Lenovo Ultraslim Plus Wireless Keyboard & Mouse	id=13	[slave  pointer  (2)]
⎜   ↳ PS/2 Generic Mouse                      	id=17	[slave  pointer  (2)]
⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ Power Button                            	id=6	[slave  keyboard (3)]
    ↳ Video Bus                               	id=7	[slave  keyboard (3)]
    ↳ Video Bus                               	id=8	[slave  keyboard (3)]
    ↳ Power Button                            	id=9	[slave  keyboard (3)]
    ↳ Sleep Button                            	id=10	[slave  keyboard (3)]
    ↳ Lenovo Ultraslim Plus Wireless Keyboard & Mouse	id=12	[slave  keyboard (3)]
    ↳ USB2.0 HD UVC WebCam                    	id=14	[slave  keyboard (3)]
    ↳ Asus WMI hotkeys                        	id=15	[slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard            	id=16	[slave  keyboard (3)]

Touchpad is device [17]
```


### `vbssh` 

Utility to log into a Virtal Box VM with the same user you are currently
using. Does dynamic discovery of the IP address of the VM for convenience.

```
vbssh -?
Usage: /home/john/bin/vbssh [vm]
SSH to a specific VM with a dynamically discovered IP address
The VM is selected by specifying any part of the name.

Note - The virtual machine must have VBoxService running or it will not
export the IP address and all will be lost.
```

## Systems

This is standard bash used on various Linux systems. I've only tested on Mint, Ubuntu, and Debian OS's. YMMV.


## License

This code is MIT Licensed and under the Free License 1.0.0. You are free to
choose the one that works for you. if you want to grab parts for use in your
own project then please remove my name and hack away.

## Building 

None required. I suggest you put the tools you want in your local ./bin directory, and add the suggested aliases to .bashrc.

## Installing 

Since these tools modify environment variables you will find them most useful
if you have nice shortcuts and don't have to keep typing the '. ' in front of them.  I add the following to my .bashrc

```
$ alias t=. toDir
$ alias path=. toPath
```
