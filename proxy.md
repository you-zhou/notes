# Proxy

The auto proxy detection system works by downloading a file called wpad.dat from the host wpad. First confirm this host exists from a command prompt:

```ping wpad```
If it doesn't exist, you may have to put the correct DNS suffix. In the same command prompt, type

```ipconfig /all```
You should see a Primary DNS Suffix and a DNS Suffix Search List

Try appending each of these with a . to wpad:

```ping wpad.<primary dns suffix>```
If any of these work, then in your browser enter <http://wpad.<suffix>/wpad.dat>. This will download the proxy auto configuration file you can open in notepad.exe

Toward the bottom of this file, you should see a line saying

```PROXY <host:port>;```
It might be repeated if you have multiple proxies available. The host and port are what you need.

If this file doesn't exist, then either there is no proxy server, or the proxy server is being provided by dhcp (note that this would only work with IE, so if firefox can surf, this is not the method being used). If you don't have access to the dhcp server to see what it is sending, the easiest way would be to open a site in ie, then go to a command prompt. Type

```netstat -ban```
This will provide a list of connections made with the process id of each process. Go to Task Manager, and select View/Select Columns and enable PID (Process Identifier). Look for the PID of iexplore.exe in the list returned by netstat -ban This will reveal the proxy ip and port.

## Check proxy details from Chrome

chrome and go to below URL to see the proxy details:
`chrome://net-internals/#proxy`

## Check proxy setttings from regedt in Windows

```reg
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" | find /i "proxyserver"
```
