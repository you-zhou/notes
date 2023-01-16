# Windows HTTP Proxy
In Windows, you can add or remove an HTTP proxy for a specific network by using the command line tool netsh.

To add an HTTP proxy for a specific network, you can use the following command:

`netsh winhttp set proxy [proxy:port] "": [Bypass list]`
For example, to set the proxy to "proxy.example.com" on port 8080, you would use the following command:

`netsh winhttp set proxy proxy.example.com:8080 ""`
To remove the proxy for a specific network, you can use the following command:

`netsh winhttp reset proxy`
This command will remove any proxy settings that are currently configured.

Alternatively, you can use the GUI interface in Internet Options -> Connections -> LAN settings to set or remove the proxy.

`netsh interface ip show config` command to get the name of the current network adapter, and then use an if statement to check the name of the adapter and run the appropriate commands for setting or removing the proxy.

```batch
@echo off

rem Get the name of the current network adapter
for /f "tokens=2 delims=:" %%a in ('netsh interface ip show config ^| findstr "Connected"') do set "adapter=%%a"

rem Check the name of the adapter and run the appropriate commands
if "%adapter%" == " Network1" (
    netsh winhttp set proxy proxy.example.com:8080 ""
    echo Proxy set for Network1
) else (
    netsh winhttp reset proxy
    echo Proxy removed
)
```

```Python
import os
import subprocess

def get_adapter():
    output = subprocess.check_output("netsh interface ip show config", shell=True)
    output = output.decode("utf-8")
    lines = output.split("\n")
    for line in lines:
        if "Connected" in line:
            adapter = line.split(":")[1].strip()
            return adapter

def set_proxy(adapter):
    if adapter == "Network1":
        os.system('netsh winhttp set proxy proxy.example.com:8080 ""')
        print("Proxy set for Network1")
    else:
        os.system('netsh winhttp reset proxy')
        print("Proxy removed")

adapter = get_adapter()
set_proxy(adapter)

```