# Run external commands from Python
`os.system()` and `subprocess` are both used to run external commands in Python, but they have some important differences:

`os.system()` is a built-in function in the os module, it runs a command as a separate process and returns the exit code of the command. It does not return any output from the command, and it doesn't provide much control over the new process.

`subprocess` is a module that provides more control over how the command is run, how the output is captured and how the new process is created. `subprocess.run()`, `subprocess.Popen()`, `subprocess.check_call()`, and `subprocess.check_output()` are some of the commonly used functions provided by the module.

`subprocess.run()` is the recommended method to run a command, it runs the command and wait for it to complete, it returns a CompletedProcess object which contains the output, return code, and other information.

`subprocess.Popen()` is used to start a new process and return a Popen object, which can be used to interact with the new process. It allows you to communicate with the process, by sending and receiving data through the stdin, stdout, and stderr pipes.

`subprocess.check_call()` and `subprocess.check_output()` are used to run a command and capture the output and return code respectively, they are similar to `subprocess.run()` but with less options.

In summary, `os.system()` is a simple and easy way to run external commands, but it's less powerful and flexible than subprocess, and it's not recommended to use it in new code, `subprocess` is the recommended way to run external commands in Python, it's more powerful, flexible, and provides more control over the new process.