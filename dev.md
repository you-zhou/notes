Dev Notes

# System Setup
## python, pip, irtualenv & pipenv
windows
`python -V`
`pip -V`
`python -m pip install -U pip`
`pip install -U virtualenvwrapper-win`

Linux
Installing apps with different profiles will have different default package destinations.
user | directory
--- | ---
regular user (none root)| ~/.local/bin
root | /usr/bin

`$ export PATH=$PATH:~/.local/bin`

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
$ sudo apt install software-properties-common python-software-properties
$ sudo add-apt-repository ppa:pypa/ppa
$ sudo apt update
$ sudo apt install pipenv
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

### environment script
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

### jupyter notebook & lab
* It's better to isolate packages related to jupyter to an individual virtual environment.
`$ mkvirtualenv jupyter`

* Jupyter notebook is a prerequisite for jupyterlab
`$ pip install -U install jupyterlab`
`$ jupyter notebook --version`

* Start jupyter notebook / lab
`$ jupyter notebook`
or
`$ jupyter lab`



## git
Installation.
`$ sudo apt-get install git`
`$ git --version`

`$ git config --global user.name "You Zhou"`
`$ git config --global user.email zhouyou.xy@gmail.com`

Caching your GitHub password in Git
```
# set git to use the credential memory cache
$ git config --global credential.helper cache
# set the cache to timeout after 10 hour (setting is in seconds)
$ git config --global credential.helper 'cache --timeout 36000'
```
For Windows, run `git config --global credential.helper wincred`


Connect to github via either ssh or httpps.
### register a new pc to github via ssh
#### Generating a new SSH key
1.  Open Terminal.
2.  Paste the text below, substituting in your GitHub email address.
	`$ ssh-keygen -t rsa -b 4096 -C "zhouyou.xy@gmail.com"`
	This creates a new ssh key, using the provided email as a label.
    `Generating public/private rsa key pair.`
    
3.  When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.
    `Enter a file in which to save the key (/home/_you_/.ssh/id_rsa): [Press enter]`
    
4.  At the prompt, type a secure passphrase. For more information, see ["Working with SSH key passphrases"](https://help.github.com/articles/working-with-ssh-key-passphrases).
    
    Enter passphrase (empty for no passphrase): _[Type a passphrase]_
    Enter same passphrase again: _[Type passphrase again]_

#### Adding your SSH key to the ssh-agent
Before adding a new SSH key to the ssh-agent to manage your keys, you should have [checked for existing SSH keys](https://help.github.com/articles/checking-for-existing-ssh-keys) and [generated a new SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key).

1.  Start the ssh-agent in the background.
    `$ eval "$(ssh-agent -s)"`
    `Agent pid 59566`
    
2.  Add your SSH private key to the ssh-agent. If you created your key with a different name, or if you are adding an existing key that has a different name, replace _id_rsa_ in the command with the name of your private key file.
    `$ ssh-add ~/.ssh/id_rsa`
    
3.  [Add the SSH key to your GitHub account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account).


$ git status

$ git checkout .

$ git clean -f # remove untracked files
$ git clean -fd # remove untracked directories

$ git reset --hard

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

## Matplotlib
It's a Python plotting library, inspired by MATLAB, meaning that the terms used (**Axis, Figure, Plots**) will be similar to those used in MATLAB. [ref](http://queirozf.com/entries/matplotlib-pylab-pyplot-etc-what-s-the-different-between-these)

### Figure
`This is the entire window where one or more subplots live. A Figure object (new window) is created with the figure() command.`
You can use it to configure things like:
* Image size (set_size_inches())
* Whether to use tight_layout (set_tight_layout())
  This adjusts the subplot padding; generally makes things look better.

 
### Axes
`This is an object representing a subplot (which you might casually call a “plot”) which contains axes, ticks, lines, points, text, etc.`
The Axes object has methods to allow you to configure things like:
* The plot frame (set_frame_on or set_frame_off)
* X-axis and Y-axis limits (set_xlim() and set_ylim())
* X-axis and Y-axis Labels (set_xlabel() and set_ylabel())
* The plot title (set_title())

### pyplot
`pyplot is a shell-like interface to Matplotlib, to make it easier to use for people who are used to MATLAB.`
pyplot maintains state across calls.
Useful for use in Jupyter or IPython notebooks.
Your can import it via the matplotlib.pyplot namespace.
```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0,10,9)
y = np.randn(9)

plt.scatter(x,y)
plt.show()
```

#### plot()
This is a command that draws points or lines and returns a list of Line2D objects. One sublety is that plot() will automatically call figure() and/or subplot() if neccesary to create the underlying Figure and Axes objects.
#### subplot()
This is a command that creates and returns a new subplot (Axes) object which will be used for subsequent plotting commands.


#### plt.gcf() `gcf: Get Current Figure`
You can use it to get a reference to the current figure when using pyplot, for example, to change image sizes.

```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0,10,9)
y = np.randn(9)

# this call creates a figure in the background
plt.scatter(x,y)

# this allows you to retrieve the figure created
# by the call to scatter() above
fig = plt.gcf()
fig.set_size_inches(6,2)

plt.show()
```
#### plt.gca() `gca: Get Current Axes`
Same as with plt.gcf(), you can use plt.gca() to get a reference to the current axes, if you need to change the limits on the y-axis, for example.

```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0,10,9)
y = np.randn(9)

# this call creates a figure in the background
plt.scatter(x,y)

# this allows you to retrieve the axis
# in the figure created 
# by the call to scatter() above
axis = plt.gca()
axis.set_ylim(-3,3)

plt.show()
```

#### plt.cla() / plt.clf() `clear figure/axes`
These methods are used to clear the current figure `plt.clf()` or the current axes `plt.cla()`.


### Plot `numpy.datetime64` values
`pandas dtype='datetime64[ns]'` -> time series in matplotlib

For Matplotlib to plot dates (or any scalar with units) a **converter to float** needs to be registered with the matplolib.units module. The current best converters for datetime64 values are in pandas. To enable the converter, import it from pandas:
```python
from pandas.tseries import converter as pdtc
pdtc.register()
```

If you only want to use the pandas converter for datetime64 values
```python
from pandas.tseries import converter as pdtc
import matplotlib.units as munits
import numpy as np

munits.registry[np.datetime64] = pdtc.DatetimeConverter()
```
**workaround**: 
* plot index as x-ticks (e.g. 0, 1, 2, .., n) 
* use array/list elements as x-tick labels (e.g. dates[0], dates[1], ..., dates[n]
```python
# Convert date series to array of strings.
xticklabels = df['Period start time'].dt.strftime('%d/%m/%y %I%p').values
# Use index of date array as the x-tick.
xticks = [i for i in range(len(xticklabels))]

ax.plot(xticks, y)
ax.set_xticklabels(xticklabels, rotation=45)
```


### plot vertical lines
```python
# Add a vertical line separator.
ax.axvline(x=5, color='r', linestyle='dashed')
```

### plot small grid lines
```python
ax.grid(True, linestyle=':')
```

## PYTHON
### REPL
Read–Eval–Print Loop

### dir and help
==IMPORTANT: explore Python using dir and help.==
#### dir()
The dir function returns the **attributes** of an object. It is used to discover the attributes of any object quickly.

The attribute list is in alphabetical order, and you can normally ignore the first couple of attributes starting with `__`.

e.g. `dir("Jack Bauer")`

#### help()
The built-in help function also provides documentation for a method, module, class, or function if you pass them in as an argument. 
For example, if you are curious what the attribute upper on a string does, the following gives you the documentation:
```python
help('some string'.upper)
Help on built-in function upper:

upper(...) method of builtins.str instance
    S.upper() -> str
    
    Return a copy of S converted to uppercase.
```

e.g. to find examples for string formatting: `help("FORMATTING")`
`help("builtins")`

### dunder methods
start and end with double underscores (Double UNDERscores). “Dunder add” is one way to say __add__,

They are used to determine what happens under the covers
when **operations** are performed on an object. For example, when you use the + or % operator on a string, the `.__add__` or `.__mod__` method is invoked respectively.

==We only need to define dunder methods when we implement our own classes and want them to react to operations such as + or % ==






### pdb
Python also includes a debugger to step through code. It is found in a module named pdb. This library is modelled after the gdb library for C. To drop into the debugger at any point in a Python program, insert the code:
`import pdb; pdb.set_trace()`

Command | Purpose
---|---
h, help | List the commands available
n, next | Execute the next line
c, cont, continue | Continue execution until a breakpoint is hit
w, where, bt | Print a stack trace showing where execution is
u, up | Pop up a level in the stack
d, down | Push down a level in the stack
l, list | List source code around current line

### is v.s. ==
`is` check identity, i.e. id(obj)
`==` checks value

### None
None is a singleton object in Python.
Two places to use None:
1. init a variable that may be assigned a value in the future.
2. the default result of a function and a method that does not explicitly return a value

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
TODO



### Divide Operator
* 26 % 7 == 5 (you will get remainder)

* 26 / 7 == 3.7142857142857144 (you will get divisor can be float value )

* 26 // 7 == 3 (you will get divisor only integer value) )


### Strings
[great examples for string format](https://pyformat.info/)

There are three ways to format  a string.
* % operator - similar to C's printf
	```python
	"Num: %d Hex: %x" % (12, 13)
	# 'Num: 12 Hex: d'
	
	"%s %s" % ('hello', 'world')
	# 'hello world'
	```
	
* format
	```python
	name = 'Matt'
	print('Hello {}'.format(name))
	# Hello Matt

	print('I:{} R:{} S:{}'.format(1, 2.5, 'foo'))
	# I:1 R:2.5 S:foo
	
	"Name: {:*^12}".format("Ringo")
	# 'Name: ***Ringo****'
	
	"Percent: {:=+10.1%}".format(-44/100)
	# 'Percent: - 44.0%'
	```
	
* f-string from Python 3.6
	```python
	name = 'matt'
	f"My name is {name.capitalize()}"
	# 'My name is Matt'
	
	f'Square root of two: {2**.5:5.3f}
	# 'Square root of two: 1.414'
	```

### tuple
Tuples are ordered sequences that are IMMUTABLE. 
==Tuples can be used as keys in dictionaries. But not lists.==

Scenarios to consider using tuples:
* returning multiple items from a function.
* hint developers that this variable is not meant to be modified.
* conserve memory as it use less than a list.

#### Two ways to create an empty tuple
1. first_tuple = tuple()
2. second_tuple = ()

#### Three ways to create a tuple with one item in it
1. first_tuple = tuple([1])
2. second_tuple = (1,)
3. third_tuple = 1,

All of them will create a tuple `(1,)`.

#### Three ways to create a tuple with more than one items in it
1. first_tuple = tuple(['Steph', 'Curry', 'Guard'])
2. second_tuple = 'Steph', 'Curry', 'Guard'
3. third_tuple = ('Steph', 'Curry', 'Guard')

All of them will create a tuple `('Steph', 'Curry', 'Guard')`.

### list
Lists are ordered sequences that are MUTABLE.

#### Two ways to create an empty list
1. first_list = list()
2. second_list = []

#### Two ways to create a pre-populated list
1. first_list = list(['Tom', 'Jerry'])
2. second_list = ['Tom', 'Jerry']

#### Two ways to delete an item from a list
```python
names = ['George', 'Henry', 'Fred', 'Paul']
# 1. remove method
names.remove('Paul') # ONLY REMOVE THE FIRST OCCURRENCE
print(names)
# ['George', 'Henry', 'Fred']

# 2. delete by index using bracket notation
del names[1]
print(names)
# ['George', 'Fred']
```

#### Two ways to sort a list
1. `list.sort()` method sorts the list ==in place==.
2. `sorted(list)` function returns a new list that is ordered. ==But it reuses all items in the list, instead of creating new items.==

#### Copy of a list
`names = ['John', 'Paul', 'George', 'Ringo']`
Below ==`[:]`== will create a new list object with a different identity. But the items' identity remains the same with `names`. 
`names2 = names[:]`

`id(names) is not id(names2)`
`id(names[0]) is id(names2[0])`

### set
Unordered collection that cannot contain duplicates.

#### Scenarios to use sets
* Removing duplicates.
* Checking membership using the `in` operation, as fast lookup operation even on large sets.
* set operations, such as union (|), intersection (&), difference (-), and xor (^)
```python
# One way to create a set while remvoing duplicates.
digits = [0, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9]
digit_set = set(digits) # remove extra 1

# The other way to create a set while removing duplicates.
digit_set = {0, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9}

# Both above would create the set and remove the duplicated 1.

# To check membership.
9 in digit_set # True
42 in digit_set # False
```

#### Note
* Because sets must be able to compute a **hash value** for each item in the set, sets can only contain items that are hashable.
* Mutable items are not hashable in Python, which means you cannot hash a
list or dictionary.
* To hash your own user-created classes, you will need to implement `__hash__` and `__eq__`.
* To use the `in` operation, also implements the `__contains__` method.


### dictionary
#### Two way to create a dictionary
```python
# 1. use the literal syntax {key: value, ...}
info = {'first': 'Pete', 'last': 'Best'}

# 2. use the built-in dict class with a list of tuple pairs.
info = dict([('first', 'Pete'),
			 ('last', 'Best')])
```
#### Insert values to a dictionary
Use index operations (square brackets) to insert values into a dictionary.
`info['age'] = 20`
`info['occupation'] = 'Drummer'`

#### Retrieve values from a dictionary
1. Square bracket [].
This literal syntax can pull a value out of a dictionary when you use the brackets without assignment:
`info['age']` will get 20

2. `.get` method.
It is used to retrieve a value for a key, which accepts an optional parameter to return a **default** value if the key is not found.
`infor.get('gender', 'N/A')` will get 'N/A' as gender is not a key in dictionary.
This is a way to get around the **KeyError** when trying to pull out a key that does not exist in a dictionary.

3. `.setdefault` method.
The method has the same signature as `.get` and initially behaves like it, returning a default value if the key does not exist. In addition to that, it also **sets** the value of the key to the default value if the key is not found.
So, it is usually used to provide an accumulator or counter for a key.
	```python
	# count the number of people with same name
	names = ['Ringo', 'Paul', 'John', 'Ringo']
	count = {}
	# 1. without using the .setdefault method
	for name in names:
		if name not in count:
			count[name] = 1
		else:
			count[name] += 1
			
	# 2. using .setdefault method saved a bit of code
	for name in names:
		count.setdefault(name, 0)
		count[name] += 1
	# 3. using the collections.Counter class
	import collections
	count = collections.Counter(names)
	
	# all above methods will produce the same results
	count['Ringo'] # 1
	```
#### `.keys()`, `.values()` and `.items()`

### loop
#### for loops with an index
Use the `in` statement in a `for` loop.
```python
animals = ["cat", "dog", "bird"]
# 1. C-styled loop with index.
# Loop a list using the combination of built-in functions range and len.
for index in range(len(animals)):
	print(index, animals[index])

# 2. A prefered and more Pythonic way.
# Loop a list is to use the built-in function enumerate.
for index, value in enumerate(animals):
	print(index, value)
```

The `enumerate` function returns a sequence of **tuples** of (index, item) pairs for the sequence passed into it.

Note: 
You can define your own classes that respond to the `for` statement, by implementing the `.__iter__` method.


## Reading & Writing Files
[ref: docs.python.org](https://docs.python.org/3/tutorial/inputoutput.html#reading-and-writing-files)
### open(filename, mode) binary v.s. text mode
* text mode
The default mode. Data strings are converted to files while reading and writing with a specific encoding (platform dependent).
In text mode, the default when reading is to convert platform-specific line endings (`\n` on Unix, `\r\n` on Windows) to just `\n`. When writing in text mode, the default is to convert occurrences of `\n` back to platform-specific line endings. This behind-the-scenes modification to file data is fine for text files, but will **corrupt** binary data like that in `JPEG` or `EXE` files.

* binary mode
Data is read and written in the form of bytes objects. This mode should be used for all files that don't contain text.


## Exceptions and Error Handlings
[ref: PYTHON – EXCEPTIONS AND ERROR HANDLINGS](http://devarea.com/python-exceptions-and-error-handlings/)

It is important to handle Exceptions & Errors when dealing with some functions. e.g.
* database connection (could not connect to the database due to incorrect IP, port# or password?)
* file handling (open a file which does not exist)
* process response from a server (which could be down)


## Decorator
Decorator is a good example of closure. Decorator is a function that takes another function and extends the behavior of the latter function  _without_  explicitly modifying it
```python
def add_stars(some_function):
    def wrapper():
        print("********************")
        some_function()
        print("********************")
    return wrapper

@add_stars
def my_function():
    print("Hello!!!")

my_function()

# ********************
# Hello!!!
# ********************
```

## Colour Coded Print
Print texts  in colour coded fashion can be useful to highlight important messages.
Print a string that starts a color/style, then the string, then end the color/style change with  `'\x1b[0m'`:
```python
print('\x1b[6;30;42m' + 'Success!' + '\x1b[0m')
```
[![Success with green background example](https://i.stack.imgur.com/RN3MN.png)](https://i.stack.imgur.com/RN3MN.png)

```python
# Colourise - colours text in shell. Returns plain if colour doesn't exist.
def colourise(colour, text):
    if colour == "black":
        return "\033[1;30m" + str(text) + "\033[1;m"
    if colour == "red":
        return "\033[1;31m" + str(text) + "\033[1;m"
    if colour == "green":
        return "\033[1;32m" + str(text) + "\033[1;m"
    if colour == "yellow":
        return "\033[1;33m" + str(text) + "\033[1;m"
    if colour == "blue":
        return "\033[1;34m" + str(text) + "\033[1;m"
    if colour == "magenta":
        return "\033[1;35m" + str(text) + "\033[1;m"
    if colour == "cyan":
        return "\033[1;36m" + str(text) + "\033[1;m"
    if colour == "gray":
        return "\033[1;37m" + str(text) + "\033[1;m"
    return str(text)

# Highlight - highlights text in shell. Returns plain if colour doesn't exist.
def highlight(colour, text):
    if colour == "black":
        return "\033[1;40m" + str(text) + "\033[1;m"
    if colour == "red":
        return "\033[1;41m" + str(text) + "\033[1;m"
    if colour == "green":
        return "\033[1;42m" + str(text) + "\033[1;m"
    if colour == "yellow":
        return "\033[1;43m" + str(text) + "\033[1;m"
    if colour == "blue":
        return "\033[1;44m" + str(text) + "\033[1;m"
    if colour == "magenta":
        return "\033[1;45m" + str(text) + "\033[1;m"
    if colour == "cyan":
        return "\033[1;46m" + str(text) + "\033[1;m"
    if colour == "gray":
        return "\033[1;47m" + str(text) + "\033[1;m"
    return str(text)


# Example usage:
print(colourise("black", "Black"))
print(colourise("red", "Red"))
print(colourise("green", "Green"))
print(colourise("yellow", "Yellow"))
print(colourise("blue", "Blue"))
print(colourise("magenta", "Magenta"))
print(colourise("cyan", "Cyan"))
print(colourise("gray", "Gray"))
print(highlight("black", "Highlight: black"))
print(highlight("red", "Highlight: red"))
print(highlight("green", "Highlight: green"))
print(highlight("yellow", "Highlight: yellow"))
print(highlight("blue", "Highlight: blue"))
print(highlight("magenta", "Highlight: magenta"))
print(highlight("cyan", "Highlight: cyan"))
print(highlight("gray", "Highlight: gray"))

# Example usage of colourise() + highlight()
text = "Blue on red is difficult to read because the wavelengths are \
refracted onto different areas of the eye."

print(highlight("red", (colourise("blue", text))))
```


## Anonymous Functions (Lambda Expressions)
`lambda` functions are anonymous functions for simple operations. It is very common where we pass a function to another function. For example the builtin map function to map a list to a new list:
```python
ls = [2,4,6]
newlist = map(lambda item:item * 2, ls)
for n in newlist:
    print(n) 
# 4
# 8
# 12
```
`lambda` functions **cannot** contain branches or loops but can contain conditional expression. Usually a simple expression:
```python
import random

f1 = lambda x:x+10
f2 = lambda :random.randint(100,200)
f3 = lambda x,y:x+y
compare=lambda a,b: -1 if a < b else (+1 if a > b else 0)

print( f1(10) ) # 20
print( f2() ) # prints random number 
print( f3(2,3)) # 5
print( compare(10,20) ) # -1
```


## Function Annotations (Python 3)
You can add documentation to the parameters and the return value:
```python
def add(a:"first number" = 0,
        b:"second number" = 0) -> "sum of a and b":
    return a+b

for item in add.__annotations__.items():
    print(item)

# ('a', 'first number')
# ('b', 'second number')
# ('return', 'sum of a and b')
```

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

## SQLite
sqlite3 is part of the Python Standard Library.
[ref: # A thorough guide to SQLite database operations in Python](http://sebastianraschka.com/Articles/2014_sqlite_in_python_tutorial.html)
The ONLY thing that needs to be done before we can perform any operation on a SQLite DB via Python's `sqlite3` module is to open a connection to an **SQLite DB file**. e.g. `sqlite_file` in the example below:
```python
import sqlite3

# This will create a new databae file, if sqlite_file does not already exist.
conn = sqlite3.connect(sqlite_file)
c = conn.cursor()
# ...
# Create table
c.execute('''CREATE TABLE stocks
 (date text, trans text, symbol text, qty real, price real)''')
# Insert a row of data
c.execute("INSERT INTO stocks VALUES ('2006-01-05','BUY','RHAT',100,35.14)")
c.commit()
c.close()
```
And this `sqlite_file` can reside anywhere on the disk, e.g.,
 ```python
sqlite_file = '/Users/Sebastian/Desktop/my_db.sqlite'
```


## dataset
[dataset.readthedocs.io](https://dataset.readthedocs.io/en/latest/)
A simple data loading script using **dataset**:
```python
import dataset

db = dataset.connect('sqlite:///:memory:')
table = db['sometable']
table.insert(dict(name='John Doe', age=37))
table.insert(dict(name='Jane Doe', age=34, gender='female'))
john = table.find_one(name='John Doe')
```

Connections to different DBs.
```python
# connecting to a SQLite database
db = dataset.connect('sqlite:///mydatabase.db')

# connecting to a MySQL database with user and password
db = dataset.connect('mysql://user:password@localhost/mydatabase')

# connecting to a PostgreSQL database
db = dataset.connect('postgresql://scott:tiger@localhost:5432/mydatabase')
```

## pytz v.s. dateutil.tz
[ref: time zones](https://blog.ganssle.io/articles/2018/03/pytz-fastest-footgun.html)



# Django
## how to start a django project properly with cookiecutter
### create a virtual environment for the project
	* virtualenvwrapper
	`mkvirtualenv bitsroom` # new virtual environement will be activated after the creation
	or
	* pipenv
	`$ cd ~/Dev/bitsroom` # **ENTER** project directory first
	`$ pipenv install` # create/prepare a virtual environment (the venv name will be assigned based on the project folder name)
	`$ pipenv shell` # activate virtual environment
2. use cookiecutter
	`$ pip install "cookiecutter>=1.4.0"` # do this within a virtual environment, as it will install several dependant packages.
	`$ cookiecutter -h` # check options
	`$ cookiecutter https://github.com/pydanny/cookiecutter-django` # this prompt values for the project.
3. track files with git
	```git
	# go into the project folder
	cd bitsroom
	# versioin control
	$ git init
	$ git add .
	$ git commit -m "initial commit"
	$ git remote add origin git@github.com:you-zhou/bitsroom.git
	$ git push -u origin master
	```
### PostgreSQL
#### installation
`$ sudo apt-get install postgresql postgresql-contrib pgadmin3`

#### create a database
The command prompt `$` will change into `#`, which means that we're now sending commands to PostgreSQL after below command.
1. Initiate password for the default user postgres.
```
sudo -u postgres psql postgres

# \password postgres

Enter new password: 
```
2. connect to PostgreSQL with the default user `postgres`
`$ psql -U postgres -W`

3. create a user
```
# CREATE USER jackz;
```
4. create a database with an assigned owner
```
# CREATE DATABASE bitsroom OWNER jackz;
```
5. set password for new user.
	* login database with the default user `postgres` and its password.
		`$ sudo -u postgres psql bitsroom`
	* set the password for `jackz`
		`bitsroom=# \password jackz`

#### test connection using psql
`$ psql -d bitsroom -U postgres -W`
or
`$ psql -d bitsroom -U jackz -W`

If there is an error message `psql: FATAL: Peer authentication failed for user "postgres"`, edit `/etc/postgresql/9.6/main/pg_hba.conf` as below:
Change line# 85 from:
`local	all	postgres	peer`
to:
`local	all	postgres	md5`

And change line# 90 from:
`local	all	all	peer`
to:
`local	all	all	md5`

And then restart PostsgreSQL by `$ sudo service postgresql restart`

[stackoverflow ref](https://stackoverflow.com/questions/18664074/getting-error-peer-authentication-failed-for-user-postgres-when-trying-to-ge)

#### configure Postgres Database
* command line utility **psql**
* graphical utility **pgAdmin**

> how to change a password
`$ sudo -u user_name psql db_name`
Set/change password:
`$ \password user_name`
Quit:
`$ \q`

At this point, there should be an empty database working with the specified user.
Now we need to tell Django the information of my database. To do it, you need to define an environment variable  **DATABASE_URL**  using the Django convention:
In a Unix environment, below command will set the environment variable `DATABSE_URL` in the environment, which Django can then read from:
`$ export DATABASE_URL=postgres://example_user:password@localhost:5432/bitsroom`
After this, run Django migrations: `$ python manage.py migrate`
And then, run the server with:  `$ python manage.py runserver`

#### set database information in standard Django structure
Find this part in your  `bitsroom/settings.py`  file:
```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}

```

And replace it with this:

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'bitsroom',
        'USER': 'jackz',
        'PASSWORD': 'mypwd',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
```

#### set DATABASE_URL for cookiecutter-django
In the terminal, set up the DATABASE_URL as an **environment variable**.
`$ export DATABASE_URL=postgres://jackz:mypwd@127.0.0.1:5432/bitsroom`
In the same terminal, run:
```
$ python manage.py migrate
$ python manage.py runserver
```

### deployment for Hheroku
#### sSetup Hheroku CLI.
```bash
# Run this from your terminal.
# The following will add our apt repository and install the CLI:
sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install heroku
```

#### work on a new branch for Heroku settings
1.  Create a new branch:  
    `git checkout -b setup-heroku`
2.  Edit, add and commit your files.
3.  Push your branch to the remote repository:  
    `git push -u origin setup-heroku`

Work with the auxiliary package `django-heroku`.
ango-heroku`
2. Add `django-heroku==0.3.1` to `requirements/production.txt`
31. Inside the virtualenv, run `$ pip3 install dj. In  `settings/production.py`, at the very bottom:
	```python
	…
	# Configure Django App for Heroku.
	import django_heroku
	django_heroku.configure(locals())
	```
#### create an app on Heroku
Create an app called `bitsroom`.
`$ heroku create bitsroom`

Check remote branch `heroku`.
`$ git remote -v`

Push the current local branch `setup-heroku` to Heroku.
`$ git push heroku setup-heroku`


## slug
### 1. Generating a unique slug for a *single* model.
[ref: unique slug for a single model](https://fazle.me/auto-generating-unique-slug-in-django/)
```python
# models.py
from django.db import models


class Article(models.Model):
    title = models.CharField(max_length=120)
    slug = models.SlugField(max_length=140, unique=True)
    content = models.TextField()
    
    def __str__(self):
        return self.title
```
The idea is to attach a number to the slug to make it **unique**, if the result of a simple `django.utils.text.slugify()` duplicates with existing records.
* Append/Increment a number, if a slugified field already exists.
* Override the default `save()` method to ensure `self.slug` is always unique (with a integer appendix if necessary).

So, add a `_get_unique_slug()` **inside** the Article model.
```python
from django.db import models
from django.utils.text import slugify


class Article(models.Model):
    title = models.CharField(max_length=120)
    slug = models.SlugField(max_length=140, unique=True)
    content = models.TextField()

    def __str__(self):
        return self.title

    def _get_unique_slug(self):
        slug = slugify(self.title)
        unique_slug = slug
        num = 1
        while Article.objects.filter(slug=unique_slug).exists():
            unique_slug = '{}-{}'.format(slug, num)
            num += 1
        return unique_slug

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = self._get_unique_slug()
        super().save()
```


### 2. Generating unique slug for generic models. DRY.
[ref:  unique slug for generic models](https://fazle.me/auto-generating-unique-slug-django-generic-approach/)
```python
# models.py
from  django.db import  models


class  Author(models.Model):
	name  =  models.CharField(max_length=120)
	slug  =  models.SlugField(max_length=140,  unique=True)

	def  __str__(self):
		return  self.name
```

Instead of defining a method `get_unique_slug()`  inside each and every model class, create a `utils.py`  to centralise common functions.

Differences in placing this `utils.py`
* `project/app/utils.py` for application wide reuse. Can be packaged with the app. (Self-contained)
* `project/common/utils.py` for project wide reuse. **Cannot** be packaged with the app. Instead, it use an separate & customised application e.g. `common` to encapsulate frequently used functions.

```python
# utils.py
from django.utils.text import slugify


def get_unique_slug(model_instance, slugable_field_name, slug_field_name):
    """
    Takes a model instance, sluggable field name (such as 'title') of that
    model as string, slug field name (such as 'slug') of the model as string;
    returns a unique slug as string.
    """
    slug = slugify(getattr(model_instance, slugable_field_name))
    unique_slug = slug
    extension = 1
    ModelClass = model_instance.__class__
    while ModelClass._default_manager.filter(
        **{slug_field_name: unique_slug}
    ).exists():
        unique_slug = '{}-{}'.format(slug, extension)
        extension += 1
    return unique_slug
```

Override the default `save()` to populate the `slug` field when saving a new Author object.
```python
# models.py
from django.db import models
from .utils import get_unique_slug


class Author(models.Model):
    name = models.CharField(max_length=120)
    slug = models.SlugField(max_length=140, unique=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = get_unique_slug(self, 'name', 'slug')
        super().save()

    def __str__(self):
        return self.name
```

### 3. fill in slug with prepopulated_fileds
[ref: django doc](https://docs.djangoproject.com/en/2.0/ref/contrib/admin/#django.contrib.admin.ModelAdmin.prepopulated_fields)
Use JavaScript to *automatically* populate the slug field from the fields assigned, by substituting dashes for spaces.
NOTE: this is ONLY for the **admin** interface.
```python
class ArticleAdmin(admin.ModelAdmin):
    prepopulated_fields = {"slug": ("title",)}
```

## Upload Files/Images
[ref: django doc](https://docs.djangoproject.com/en/2.0/topics/http/file-uploads/)
Note that [`request.FILES`](https://docs.djangoproject.com/en/2.0/ref/request-response/#django.http.HttpRequest.FILES "django.http.HttpRequest.FILES") will only contain data if the request method was `POST` and the `<form>` that posted the request has the attribute `enctype="multipart/form-data"`. Otherwise, `request.FILES` will be **empty**.


# JavaScript
## REPL (Read Eval Print Loop)
* [codepen](https://codepen.io/)
* [babel](https://babeljs.io/repl/)

## Variable declaration:  var, let & const
Declaration | Limitation | Re-declaration | Re-assignment | Note
--- | --- | :---: | --- | --- 
const | Strictest | N | N | must be assigned at declaration time
let | Moderate | N | Y |
var | Weakest | Y | Y |

## Operators
* == equal
* != not equal
* === strict equal
* !== not strict equal
* ternary
	```javascript
	14 - 7 === 7 ? 'Yep!' : 'Nope.'; // Yep!
	```


## Functions
To represent a function `f(x) = x* 2`, and assign it with the name "double":
```javascript
const double = x => x * 2;
```
The value of the a function expression is the function itself:
```javascript
double; // [Function: double]
```
To check the function definition, use `.toString()` method:
```javascript
double.toString(); // 'x => x * 2'
```



## Objects
An object in JavaScript is a collection of key: value pairs. It also has a literal notation:
```javascript
{  
  key: 'value'  
}
```

And of course, you can assign an object to a name:
```javascript
const foo = {  
  bar: 'bar'  
}
```

# Bootstrap
## From pixels to rems
Bootstrap 4 has swapped out pixels with **relative units of measurements (rems)** in all places except media queries and grid behaviours. This means more flexibility and responsiveness, as rem units aren’t absolute, which pixels are.

With  `rems`  all font sizes are relative to the root element (the  `html`  tag), and by default,  `1rem`  equals  `16px`. However, if you change the font-size to, say, 50% in the root element, then  `1rem`  will equal  `8px`  throughout the app.



# Markdown
## Text
## Markdown
### Text Basics
asterisk: this is *italic* and this is **bold**.

underscore: another _italic_ and another __bold__.

the back ticks represent `important` text.

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


# System
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
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTExNTQxMTIwNjMsODA4ODY3NTc1LC0xMz
Q0OTIzNTU2LDExNjYwNDk1ODMsLTE1OTk5MzI1MjMsNDg5MTYx
NDU2LDEzODY5MjYzMDgsLTEwOTUzMDE3MzMsMjA5NTMxNzgyNC
wtMTQ4MTIzNTc2LC03MDc4NzM5OTUsLTIxMTUyMDA3NDIsLTEy
MjU4Mjg3MjcsMTE3MTYxNzkyOSwtMzM2MTYzMjkwLDUwNTA5NT
cyMiw4ODkzNDI3NTcsLTE3MzM3MjQ1MDMsLTEyMjAwODY0MDUs
Mzg0MTMwMDgyXX0=
-->