# Dev Notes
----------

## GIT
$ git config --global user.name "George Brocklehurst"
$ git config --global user.email george@georgebrock.com


$ git status
$ git diff
$ git diff --staged

$ git commit --patch

$ git log --oneline --decorate

$ git commit --amend  # Reword the last commit message
```git
	# This can be useful to include files you forgot to track, or include modifications to the files you just commited. To do so, you can add the changes and then perform the amend:
	$ git add README.md config/routes.rb
	$ git rm notes.txt
	$ git commit --amend
```



## DJANGO




## PYTHON
### Why ```if __name__ == '__main__'```?

It checks if a module is being `imported` or ran `directly`. Refer to [Python Docs](https://docs.python.org/3/library/__main__.html).

```python
if __name__ == "__main__":
    # execute only if run as a script
    main()
```

* direct run: __name__ = __main__
> if statement == True, and the script in __main__ will be executed

* imported: __name__ = module's filename 
> if statement == False, and the script in __main__ will not be executed

With this behavior any py file can exhibit dual behavior - it is a script as well as module. 

A very common use of this is to put test code of your script inside the if condition that you mentioned, while allowing others to use it as a module.

e.g. ```pyton -m```

Modules are objects, and all modules have a built-in attribute `__name__`. 

A module's `__name__` depends on how we're using the module.

If we `import` the module, then `__name__` is the module's filename, without a directory path or file extension

If we run the module not by `importing` it but running it directly as a standalone program,  `__name__` will be a special default value: `__main__.


### self




### Divide Operator
* 26 % 7 == 5 (you will get remainder)

* 26 / 7 == 3.7142857142857144 (you will get divisor can be float value )

* 26 // 7 == 3 (you will get divisor only integer value) )



## Markdown
### Text Basics
asterisk: this is *italic* and this is **bold**.

underscore: another _italic_ and another __bold__.

the backticks represent `important` text.

the % is `%`

### Indentation
> some indentation
>> more indentation
>>> even more intendation

### Bullets
+ item-1
- item-2
* item-3
  + sub-item-1
  - sub-item-2
  * sub-item-3


## Proxy
The auto proxy detection system works by downloading a file called wpad.dat from the host wpad. First confirm this host exists from a command prompt:

```ping wpad```
If it doesn't exist, you may have to put the correct DNS suffix. In the same command prompt, type

```ipconfig /all```
You should see a Primary DNS Suffix and a DNS Suffix Search List

Try appending each of these with a . to wpad:

```ping wpad.<primary dns suffix>```
If any of these work, then in your browser enter http://wpad.<suffix>/wpad.dat. This will download the proxy auto configuration file you can open in notepad.exe

Toward the bottom of this file, you should see a line saying

```PROXY <host:port>;```
It might be repeated if you have multiple proxies available. The host and port are what you need.

If this file doesn't exist, then either there is no proxy server, or the proxy server is being provided by dhcp (note that this would only work with IE, so if firefox can surf, this is not the method being used). If you don't have access to the dhcp server to see what it is sending, the easiest way would be to open a site in ie, then go to a command prompt. Type

```netstat -ban```
This will provide a list of connections made with the process id of each process. Go to Task Manager, and select View/Select Columns and enable PID (Process Identifier). Look for the PID of iexplore.exe in the list returned by netstat -ban This will reveal the proxy ip and port.


### Check proxy details from Chrome
chrome and go to below URL to see the proxy details:
chrome://net-internals/#proxy

### Check proxy setttings from regedt in Windows 
```reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" | find /i "proxyserver"
```

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEyMjg4MTI2MDJdfQ==
-->