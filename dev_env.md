# Dev Environment Setup

## python, pip, virtualenv & pipenv

windows
`python -V`
`pip -V`
`python -m pip install -U pip`
`pip install -U virtualenvwrapper-win`

In Windows, the default path for `WORKON_HOME` is `%USERPROFILE%Envs`


Linux
Installing apps with different profiles will have different default package destinations.
user | directory
--- | ---
regular user (none root)| ~/.local/bin
root | /usr/bin

`$ export PATH=~/.local/bin:$PATH`

```bash
$ pip install virtualenvwrapper
$ export WORKON_HOME=~/Envs
$ source /usr/local/bin/virtualenvwrapper.sh
```

Installing packages with pip.
user | directory
--- | ---
regular user (none root) | ~/.local/lib/pythonX.X/site-packages
root | /usr/lib/pythonX.X/dist-packages

`$ which python3`
`$ python3 -V`
`$ pip3 -V`
`$ sudo apt-get install -U python3-pip`
NOTE: it is import to add sudo 
`$ sudo pip3 install -U virutualenvwrapper`
NOTE: Ubuntu would not recognise the virtualenv commands straight away.
`$ export PATH=$PATH:~/.local/bin`
`$ source /usr/local/bin/virtualenvwrapper.sh` 

Install `pipenv` in Ubuntu:

* using apt

```bash
sudo apt install software-properties-common python-software-properties
sudo add-apt-repository ppa:pypa/ppa
sudo apt update
sudo apt install pipenv
```

or

* using pip

`$ pip install pipenv`
If `pipenv` command could not be found, but `$ python -m pipenv --version` works, it usually means a conflict with `virtualenv`.
The solution is to uninstall both `virtualenv` and `pipenv`
`$ pip uninstall virtualenv`
`$ pip uninstall pipenv`
and install `pipenv` again, which will install `virtualenv` as a dependency.
`$ pip install --user pipenv` This does a [user installation](https://pip.pypa.io/en/stable/user_guide/#user-installs) to prevent breaking any system-wide packages.
`pip install -U $(pip freeze | awk '{split($0, a, "=="); print a[1]}') --user` this will update all packages in the current pip environment.

## Environment Variables

1. PATH
   Add the Python executable directory to the PATH environment variable. This will allow you to run the python command from anywhere in your system with

   ```windows
   set PATH=%PATH%;%userprofile%\AppData\Roaming\Python\Python39\Scripts;%userprofile%\AppData\Roaming\Python\Python39\site-packages
   ```

2. PYTHONPATH
   The PYTHONPATH environment variable is used by Python to determine where to search for modules and packages.

   ```windows
   set PYTHONPATH=%userprofile%\Documents\OneDrive - Optus\Dev\modules;%userprofile%\AppData\Roaming\Python\Python39\site-packages
   ```

Below is a customised bash shell script that should be executed at the end of `~/.bashrc` or `~/.bash_profile`.
e.g. Append  `source ~/.setup_my_env` to `~/.bashrc`

```bash
# .setup_my_env
# DESCRIPTION: this is to set up common environment across my different PCs.

# environment register local bin
export PATH=$PATH:~/.local/bin

# common directories for cross PC scripts
export DEV_HOME=~/Dev
export DROPBOX_HOME=~/Dropbox

# aliases
alias vpn="windscribe status"
alias vpnon="windscribe connect AU"
alias vpnoff="windscribe disconnect"

# virtualenvwrapper set up
export WORKON_HOME=~/.virtualenvs
# solved "could not import the module virtualenvwrapper.hook_loader" issue
export VIRTUALENVWRAPPER_PYTHON=`which python3`
export VIRTUALENVWRAPPER_VIRTUALENV=`which virtualenv`
# source /usr/local/bin/virtualenvwrapper.sh
source `which virtualenvwrapper.sh`
```

## Trouble-shooting

### Specify trusted-host

* Update pip with sepecified trusted-host
  `python -m pip install  --trusted-host pypi.org --trusted-host files.pythonhosted.org pip`

* Install certifi package
  `python -m pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org certifi`

  Or consider changing configuration settings:
  `pip config set global.trusted-hosts pypi.org,files.pythonhosted.org`

  Certificates will be installed here: `%userprofile%\AppData\Roaming\Python\Python39\site-packages\certifi\cacert.pem`

  Set environment variable
  `set REQUESTS_CA_BUNDLE=%userprofile%\AppData\Roaming\Python\Python39\site-packages\certifi\cacert.pem`

### Re-install pip

```python
python -m pip install --upgrade pip
python -m pip install  --trusted-host pypi.org --trusted-host files.pythonhosted.org --upgrade setuptools
python -m pip install  --trusted-host pypi.org --trusted-host files.pythonhosted.org --upgrade pip
````

## jupyter notebook & lab

* It's better to isolate packages related to jupyter to an individual virtual environment.
`$ mkvirtualenv jupyter`

* Jupyter notebook is a prerequisite for jupyterlab
`$ pip install -U install jupyterlab`
`$ jupyter notebook --version`

* Start jupyter notebook / lab
`$ jupyter notebook`
or
`$ jupyter lab`




### node.js & npm
`$ sudo apt-get install nodejs`
`$ sudo apt-get install npm`


## Environment Variables
Environment variables are a way to store configurable values across your entire system—all your programs have access to these.

[List/display/set/change/delete environment variables in Windows & Linux.](https://www.ntu.edu.sg/home/ehchua/programming/howto/Environment_Variables.html)

### Notes: Windows vs Linux 
- Windows use semi-colon  `';'`  as path separator (e.g., in  `PATH`  environment variable), while Unix uses colon  `':'`.
-   Unix's variable name is denoted as  `$_varname_`, e.g.,  `$CLASSPATH`. Windows uses  `%_varname_%`, e,g.,  `%CLASSPATH%`.

#### Windows Commands
* List all environment variables.
`> set`
* Display the value of an environment variable.
`> set DROPBOX_HOME` 
or
`> echo %DROPBOX_HOME%`

* Set or change the value of an environment variable. (Note: **no space** before and after '=')
`> set DROPBOX_HOME=C:\Users\Jack\Dropbox`
> To make it permanent, add it into Control Panel -> System and Security -> System. And there is an "Advanced System Settings" on the left side menu.
> If **without admin privilege**, this can be set via Control Panel -> User Accounts -> User Accounts. And there is a "Change my environment variables" option on the left side menu.

* Delete/Unset the an  environment variable by settting it to an empty string. (Note: nothing after the '=')
`> set DROPBOX_HOME=`


#### Linux Commands

* List all environment variables.
`$ env`
or
`$ printenv`

* Display the value of an environment variable.
`echo $DROPBOX_HOME`

* Set or change the value of an environment variable. (Note: **no space** before and after '=') 
`export DROPBOX_HOME=/home/jack/Dropbox`
Or, enclosed the _value_ with double quotes if it contains spaces.
`export DROPBOX_HOME="/home/jack zhou/Dropbox"`
> To make it permanent, append this export command  to one of below Bash shell startup scripts:
> * `~/.bashrc` 
> * `~/.bash_profile` 
> * `~/.profile`
> It will then be executed every time you login using console or remotely using SSH.

* Delete/Unset the an  environment variable by settting it to an empty string. (Note: nothing after the '=')
`$ DROPBOX_HOME=`
or
`$ unset DROPBOX_HOME`

Note: for the older  csh  (C-shell) and  ksh  (Korn-shell):

-   Use "`printenv`" (or "`env`") to list all the environment variables.
-   Use "`setenv  _varname value_`" and "`unsetenv  _varname_`" to set and unset an environment variable.
-   Use "`set  _varname_=_value_`" and "`unset  _varname_`" to set and unset a local variable for the current process.

### pip

Upgrading pip.
* On Linux or macOS:
	`pip install -U pip`

* On Windows:
	`python -m pip install -U pip`

To INSTALL all packages from a list to the current environment.
	`pip install -r requirements.txt`

To UNINSTALL all packages in the current environment.
* Method 1 (with  `pip freeze`)
	`pip freeze | xargs pip uninstall -y`
	or
	`pip3 freeze | xargs sudo pip3 uninstall -y`

* Method 2 (with  `pip list`)
	`pip list | awk '{print $1}' | xargs pip uninstall -y`

* Method 3 (with  `virtualenv`)
	`virtualenv --clear MYENV`
	

### pip install --user pipenv

This does a ==user installation== to prevent breaking any system-wide packages.
`$ pip install --user pipenv`

After this, if pipenv isn’t available in your shell after installation, you’ll need to add the user base‘s binary directory to your PATH.

NOTE: 
* On Linux and macOS you can find the user base binary directory by running `python -m site --user-base` and adding bin to the end. For example, this will typically print ~/.local (with ~ expanded to the absolute path to your home directory) so you’ll need to add ~/.local/bin to your PATH. You can set your PATH permanently by modifying ~/.profile.

* On Windows you can find the user base binary directory by running `py -m site --user-site` and replacing site-packages with Scripts. For example, this could return C:\Users\Username\AppData\Roaming\Python36\site-packages so you would need to set your PATH to include: \Users\Username\AppData\Roaming\Python36\Scripts.
You can set your user PATH permanently in the Control Panel. You may need to log out for the PATHchanges to take effect.


## library

* A python library must be a *module* or a *package*.
* The library must exist in the **PYTHONPATH** environment variable or **`sys.path`** Python variable.

### modules

If you quit from the Python interpreter and enter it again, the definitions you have made (functions and variables) are lost. Therefore, if you want to write a somewhat longer program, you are better off using a text editor to prepare the input for the interpreter and running it with that file as input instead. This is known as creating a  _script_. As your program gets longer, you may want to split it into several files for easier maintenance. You may also want to use a handy function that you’ve written in several programs without copying its definition into each program.

To support this, Python has a way to put definitions in a file and use them in a script or in an interactive instance of the interpreter. Such a file is called a  _module_; definitions from a module can be  _imported_  into other modules or into the  _main_  module (the collection of variables that you have access to in a script executed at the top level and in calculator mode).

A module is a file containing Python definitions and statements. The file name is the module name with the suffix  `.py`  appended. Within a module, the module’s name (as a string) is available as the value of the global variable  `__name__`. 

[python doc ref](https://docs.python.org/3/tutorial/modules.html#)

In a nut shell, modules are **Python files** that end in `.py`, and have a name that is importable.
> PEP 8 states that module filenames should be short and in lowercase. Underscores may be used for readability.

Note:
Even though it is allowed to have underscore `_`  in module names, it is not preferred. e.g. `fs/format_names.py`And should be always avoided. Use submodules instead of underscores if possible. e.g. `fs/format/names.py`.

#### executing modules as scripts

Put execution statements inside `if __name__ == "__main__":`.
Then it will ONLY be executed when the module is ran as a script.
```python
if __name__ == "__main__":
	import sys
	f(int(sys.argv[1]))
```

### packages

Packages are a way of structuring Python’s module namespace by using “dotted module names”. For example, the module name `A.B` designates a submodule named `B` in a package named `A`. Just like the use of modules saves the authors of different modules from having to worry about each other’s global variable names, the use of dotted module names saves the authors of multi-module packages like NumPy or Pillow from having to worry about each other’s module names. 

[python doc ref](https://docs.python.org/3/tutorial/modules.html#packages)

A Python package is a **directory** that contains a file named `__init__.py`, which can even be empty.
In addition, the directory may contain an arbitrary number of modules and sub packages.
> PEP 8 states that directory names for packages should be short and lowercase. Underscores should ==not== be used.


## Access Environment Variables

This is can be used to access files stored in the dropbox, which would have a different directory in different computers. Set the dropbox directory or database file location inside a common environment variable will make scripts portable across computers.

### os.environ

```python
import os

# list all environment variables
os.environ

# get the value of PATH
os.environ['PATH']

# get a possible value with a default value
# instead of a 'KeyError' if it does not exist.
os.environ.get('DROPBOX', 'to be defined')

# Or use the shorter version below.
os.getenv('DROPBOX', 'to be defined')
```
