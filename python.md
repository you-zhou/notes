
# PYTHON
## read great code
One of the core tenets behind the design of Python is creating readable code. The motivation behind this design is simple: ==The number one thing that Python programmers do is read code.==
One of the secrets of becoming a great Python programmer is to **read, understand, and comprehend excellent code.**
Excellent code typically follows the guidelines outlined in Code Style, and does its best to express a clear and concise intent to the reader.
Included below is a list of recommended Python projects for reading. Each one of these projects is a paragon of Python coding.
* [Howdoi](https://github.com/gleitz/howdoi)  is a code search tool, written in Python.
* [Flask](https://github.com/pallets/flask) is a microframework for Python based onWerkzeug and Jinja2. It’s intended for getting started very quickly and was developed with best intentions in mind.
* [Diamond](https://github.com/python-diamond/Diamond) is a python daemon that collects metrics and publishes them to Graphite or other backends. It is capable of collecting cpu, memory, network, i/o, load and disk metrics. Additionally, it features an API for
implementing custom collectors for gathering metrics from almost any source.
* [Werkzeug](https://github.com/pallets/werkzeug) started as simple collection of various utilities for WSGI applications and has become one of the most advanced WSGI utility modules. It includes a powerful debugger, full-featured request and response objects, HTTP utilities to handle entity tags, cache control headers, HTTP dates, cookie handling, file uploads, a powerful URL routing system and a bunch of community-contributed addon modules.
* [Requests](https://github.com/requests/requests) is an Apache2 Licensed HTTP library, written in Python, for human beings.
* [Tablib](https://github.com/kennethreitz/tablib) is a format-agnostic tabular dataset library, written in Python.

## python --version
If you still see 2.7 ensure in PATH `/usr/local/bin/` takes pecedence over `/usr/bin/`.

## `PYTHONPATH` and `sys.path`
### `PYTHONPATH` environment variable
`PYTHONPATH` is an environment variable listing non-standard directories that Python looks for **modules** or **packages** in.

Note:
Python packages can be installed via package managers, Windows executables or Python specific tools such as pip.

### `sys.path`
The `sys` module has an attribute `path`. It stores a list of paths that determines where Python looks to import libraries.
```python
import sys
sys.path
```
`sys` module is NOT implemented in Python, but C (CPython). Check `sys.implementation`.

Note:
Typically you don’t manually set `sys.path` or `PYTHONPATH`, normally you install libraries, and the installer puts them in the correct location.


### look for library locations?
If you want to know the location of the library onclf()` or the current axes `plt.cla()`.


## Reading & Writing Files

[ref: docs.python.org](https://docs.python.org/3/tutorial/inputoutput.html#reading-and-writing-files)
Note: 
Windows paths use \ as a separator, which can be problematic. Python strings also use \ as an escape character. If you had a directory named ”test” and wrote "C:\test", Python would treat \t as a tab character.
The remedy for this is to use raw strings to represent Windows paths. Put an ==r== in 
front of the string: `r"C:\test"`

### open(filename, mode) binary v.s. text mode
* text mode 
	* 'r' read text file (default)
	* 'w' Write text file (overwrites if exists)
	* 'x' Write text file, throw FileExistsError if exists.
	* 'a' Append to text file (write to end)

	The default mode. Data strings are converted to files while reading and writing with a specific encoding (platform dependent).
In text mode, the default when reading is to convert platform-specific line endings (`\n` on Unix, `\r\n` on Windows) to just `\n`. When writing in text mode, the default is to convert occurrences of `\n` back to platform-specific line endings. This behind-the-scenes modification to file data is fine for text files, but will **corrupt** binary data like that in `JPEG` or `EXE` files.

* binary mode 
	* 'rb' read binary file
	* 'w+b' Open binary file for reading and writing
	* 'xb' Write binary file, throw FileExistsError if exists.
	* 'ab' Append to binary file (write to end)

	Data is read and written in the form of bytes objects. This mode should be used for all files that don't contain text.


Use the `with open` syntax to read from files. This will automatically close files for you.
```python
# Bad
f = open('file.txt')
a = f.read()
print a
f.close()


# Good
with open('file.txt') as f:
	for line in f:
		print line

```


## Exceptions and eError hHandlings
[ref: PYTHON – EXCEPTIONS AND ERROR HANDLINGS](http://devarea.com/python-exceptions-and-error-handlings/)

It is important to handle Exceptions & Errors when dealing with some functions. e.g.
* database connection (could not connect to the database due to incorrect IP, port# or password?)
* file handling (open a file which does not exist)
* process response from a server (which could be down)


## dDecorator
Decorator is a good example of closure. Decorator is a function that takes another function and extends the behavior of the latter function  _without_  explicitly modifying it.

This mechanism is useful for separating concerns and avoiding external un-related logic ‘polluting’ the core logic of the function or method. A good example of a piece of functionality that is better handled with decoration is ==memoization or caching==: you want to store the results of an expensive function in a table and use them directly instead of recomputing them when they have already been computed. This is clearly not part of the function logic.

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

## context manager
A context manager is a Python object that provides extra contextual information to an action. This extra information takes the form of running a callable upon initiating the context using the `with` statement, as well as running a callable upon completing all the code inside the with block. The most well known example of using a context manager is shown here, opening on a file:
```python
with open('file.txt') as f:
	contents = f.read()
```

Anyone familiar with this pattern knows that invoking open in this fashion ensures that f‘s close method will be called at some point. This reduces a developer’s cognitive load and makes the code easier to read. 

There are two easy ways to implement this functionality yourself: 
1. the class approach
using a class or using a generator. Let’s implement
the above functionality ourselves, starting with the class approach:
```python
class CustomOpen(object):
	def __init__(self, filename):
		self.file = open(filename)
	def __enter__(self):
		return self.file
	def __exit__(self, ctx_type, ctx_value, ctx_traceback):
		self.file.close()
		
with CustomOpen('file') as f:
	contents = f.read()

```
This is just a regular Python object with two extra methods that are used by the with statement. `CustomOpen` is first instantiated and then its `__enter__` method is called and whatever `__enter__` returns is assigned to f in the as `f` part of the statement. When the contents of the with block is finished executing, the `__exit__` method is then called.

2. the function approach
And now the generator approach using Python’s own `contextlib`:
```python
from contextlib import contextmanager

@contextmanager
def custom_open(filename):
	f = open(filename)
	try:
		yield f
	finally:
		f.close()

with custom_open('file') as f:
	contents = f.read()
```

This works in exactly the same way as the class example above, albeit it’s more terse. The custom_open function executes until it reaches the `yield` statement. It then **gives control back to the with statement**, which assigns whatever was `yield`‘ed to `f` in the `as f` portion. The finally clause ensures that `close()` is called whether or not there was an exception inside the with.

Summary:
Since the two approaches appear the same, we should follow the Zen of Python to decide when to use which. The class approach might be better if there’s a considerable amount of logic to encapsulate. The function approach might be better for situations where we’re dealing with a simple action.


## idiomatic python
### unpacking

```python
# enumerate() will provide a tuple of two elements for each item in list
for index, item in enumerate(some_list):
	# do something with index and item

# swap variables
a, b = b, a

# extended unpacking was introduced by PEP 3132
a, *rest = [1, 2, 3]
# a = 1, rest = [2, 3]

a, *middle, c = [1, 2, 3, 4]
# a = 1, middle = [2, 3], c = 4
```


### ignored variable with `_` or `__`
If you need to assign something (for instance, in Unpacking) but will not need that variable, use `__`:

```python
filename = 'foobar.txt'
basename, __, ext = filename.rpartition('.')
```
Note: 
Many Python style guides recommend the use of a single underscore `_` for throwaway variables rather than the double underscore `__` recommended here. 
The issue is that `_` is commonly used as an alias for the `gettext()` function, and is also used at the interactive prompt to hold the value of the last operation. Using a double underscore instead is just as clear and almost as convenient, and eliminates the risk of accidentally interfering with either of these other use cases.


### create a length-N list of the same thing
Use the Python ==list *== operator:
```python
four_nones = [None] * 4
# [None, None, None, None]
```

### create a length-N list of lists
Because lists are mutable, the * operator (as above) will create a list of N references to the same list, which is not likely what you want. 
Instead, use a list comprehension:
```python
four_lists = [[] for __ in xrange(4)]
# [[], [], [], []]
```
Note: Use range() instead of xrange() in Python 3

### create a string from a list
A common idiom for creating strings is to use `str.join()` on an empty string.
```python
letters = ['s', 'p', 'a', 'm']
word = ''.join(letters)
```
This will set the value of the variable word to ‘spam’. This idiom can be applied to **lists and tuples**.


### search an item in a collection e.g. list, set or dict
Search with the operator `in` with a collection.
Searches can be done much faster with set and dict than list. 
As for set & dict,  it can use hash value of the item to quickly locate it, while for the list, it has to go through each item until it finds a match.

```python
s = set(['s', 'p', 'a', 'm'])
l = ['s', 'p', 'a', 'm']
def lookup_set(s):
	return 's' in s

def lookup_list(l):
	return 's' in l
```



### PEP8
* pycodestyle (previously known as pep8),
```bash
$ pip install pycodestyle
# Then run it on a file or series of files to get a report of any violations.
$ pycodestyle optparse.py
optparse.py:69:11: E401 multiple imports on one line
optparse.py:77:1: E302 expected 2 blank lines, found 1
optparse.py:88:5: E301 expected 1 blank line, found 0
optparse.py:222:34: W602 deprecated form of raising exception
optparse.py:347:31: E211 whitespace before '('
optparse.py:357:17: E201 whitespace after '{'
optparse.py:472:29: E221 multiple spaces before operator
optparse.py:544:21: W601 .has_key() is deprecated, use 'in'
```
* autopep8
The program autopep8 can be used to automatically reformat code in the PEP 8 style.
```bash
$ pip install autopep8

$ autopep8 --in-place optparse.py
```
Excluding the `--in-place` flag will cause the program to output the modified code directly to the console for review.
The `--aggressive` flag will perform more substantial changes and can be applied multiple times for greater effect.

### line continuations
The Python interpreter will join consecutive lines if the last character of the line is a ==backslash `\`==. 
This is helpful in some cases, but should usually be avoided because of its fragility: **a white space added to the end of the line, after the backslash, will break the code and may have unexpected results.**

A better solution is to use parentheses around your elements. Left with an unclosed parenthesis on an end-of-line the Python interpreter will join the next line until the parentheses are closed. The same behaviour holds for curly and square braces.

```python
# Bad
my_very_big_string = """For a long time I used to go to bed early. Sometimes, \
	when I had put out my candle, my eyes would close so quickly that I had not even \
	time to say “I’m going to sleep.”"""

from some.deep.module.inside.a.module import a_nice_function, another_nice_function, \
yet_another_nice_function


# Good
my_very_big_string = (
	"For a long time I used to go to bed early. Sometimes, "
	"when I had put out my candle, my eyes would close so quickly "
	"that I had not even time to say “I’m going to sleep.”"
)

from some.deep.module.inside.a.module import (
	a_nice_function, another_nice_function,
	yet_another_nice_function)
```

Note:
More often than not, having to split a long logical line is a sign that you are **trying to do too many things at the same time**, which may hinder readability.

## colour coded

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


## Anonymous Functions (lLambda eExpressions)

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

## Plot `numpy.datetime64` values
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
# Use index of date arrary onas the filesystem, you can inspect the `__file__` attribute.
```

```python
import json
json.__file__
# 'C:\\Program Files\\Python35-32\\lib\\json\\__init__.py'
```

Note: This only works with libraries implemented in Python. 
The `sys` module is not implemented in Python, so this fails:
```python
import sys
sys.__file__
# Traceback (most recent call last):
# ...
# AttributeError: module 'sys' has no attribute '__file__'
```

x-tick.
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
Read–Eval–Print Loop### dir and help
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

### `__str__()` & `__repr__()`
The  `__str__()`  and  `__repr__()`  methods deal with how objects are presented as strings, so you’ll need to make sure you include at least one of those methods in your class definition. If you have to pick one, go with  `__repr__()`  because it can be used in place of  `__str__()`.

* The string returned by  `__str__()`  is the informal string representation of an object and should be readable. 
* The string returned by  `__repr__()`  is the official representation and should be unambiguous. 
* Calling  `str()`  and  `repr()`  is preferable to using  `__str__()`  and  `__repr__()`  directly.

By default, f-strings will use  `__str__()`, but you can make sure they use  `__repr__()`if you include the conversion flag  `!r`:
```python
f"{new_comedian}"
# 'Eric Idle is 74.'

f"{new_comedian!r}"
# 'Eric Idle is 74. Surprise!'
```






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


## Why ```if __name__ == '__main__'```?

In a nutshell, it checks if the currenta module is being `imported` or ran `directly`. 
[Refer to [Python Docs](https://docs.python.org/3/library/__main__.html).

```python
if __name__ == "__main__":
    # execute only if run as a script directly
    main()
```

* direct run: `__name__` = `'__main__'`
> if statement == True, and the script in __main__ will be executed

* imported: `__name__` = module's filename 
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



### dDivide oOperator
* 26 % 7 == 5 (you will get remainder)

* 26 / 7 == 3.7142857142857144 (you will get divisor can be float value )

* 26 // 7 == 3 (you will get divisor only integer value) )


## namespace and scope
The namespace holds the functions, classes, and variables you have access to.

[a very good ref](https://eli.thegreenplace.net/2015/the-scope-of-index-variables-in-pythons-for-loops/)

In Python, the scoping rules are fairly simple and elegant. A block is either 
* a module
* a function body
* a class body

Within a function body, names are visible from the point of their definition to the end of the block (including nested blocks such as nested functions).

The important point here is: ==the innermost possible scope is a function body.== Not a `if-else block` or `for loop block`. Not a `with block`. Python does not have nested lexical scopes below the level of a function, unlike some other languages (C and its progeny, for example).

P.S. Use the built-in function `locals()` and `globals()` to check variables in the scope.

## `import` and `as`
### Two scenarios to use `import x as y` or `from x import y as z`:
1. To avoid conflicting import names.
Assuming there is already a user defined `sin()` in the current namespace, below are the ways to get around conflicted names and use the `math` library.
```python
import math as other_math
other_math.sin(0)

from math import sin as other_sin
other_sin(0)
```
2. To reduce keystrokes.
```python
import numpy as np
import pandas as pd
```

Note: 
>Do not use star imports! Star imports make debugging harder because it is not explicit where code comes from.
Even worse are star imports from multiple libraries. Subsequent library imports might override something defined in an earlier library. As such, star imports are discouraged and frowned upon.


### organise imports
According to PEP 8, import statements should be located at the top of the file following the module docstring. 
There should be one import per line and imports should be grouped by:
1. Standard library imports
2. 3rd party imports
3. Local package imports

Preferably, imports should be grouped alphabetically.

Example as below:
```python
#!/usr/bin/env python3
"""
This module converts records into JSON
and shoves them into a database
"""
import json # standard libs
import sys

import psycopg2 # 3rd party lib

import recordconverter # local library
```

## str
Strings are ==immutable==.

This means that when constructing a string from its parts, it is much more efficient to accumulate the parts in a list, which is mutable, and then glue (‘join’) the parts together when the full string is needed. 

One thing to notice, however, is that list comprehensions are better
and faster than constructing a list in a loop with calls to append().

```python
# Bad
# create a concatenated string from 0 to 19 (e.g. "012..1819")
nums = ""
for n in range(20):
nums += str(n) # slow and inefficient
print nums


# Good
# create a concatenated string from 0 to 19 (e.g. "012..1819")
nums = []
for n in range(20):
nums.append(str(n))
print "".join(nums) # much more efficient


# Better
# create a concatenated string from 0 to 19 (e.g. "012..1819")
nums = [str(n) for n in range(20)]
print "".join(nums)


# Best
# create a concatenated string from 0 to 19 (e.g. "012..1819")
nums = map(str, range(20))
print "".join(nums)
```


### There are three ways to format  a string.
[great examples for string format](https://pyformat.info/)

1. built-in# Strings
[great examples for string format](https://pyformat.info/)

There are three ways to format  a string.
* % operator `%` - similar to C's printf (not recommended by the docs due to poor support to display tuples and dictionaries correctly) [Python docs](https://docs.python.org/3/library/stdtypes.html#printf-style-string-formatting)

	```python
	"Num: %d Hex: %x" % (12, 13)
	# 'Num: 12 Hex: d'
	
	"%s %s" % ('hello', 'world')
	# 'hello world'
	```
	
2. str.format() from Python 2.6 (much improved from the % operator) [Python docs](https://docs.python.org/3/library/stdtypes.html#str.format)
		
PEP 3101 discourages the usage of the % operator in favor of the `str.format()` method.

```python
foo = 'foo'
bar = 'bar'
foobar = '%s%s' % (foo, bar) # It is OK
foobar = '{0}{1}'.format(foo, bar) # It is better
foobar = '{foo}{bar}'.format(foo=foo, bar=bar) # It is best
```

It uses normal function call syntax and is  [extensible through the  `__format__()`  method](https://www.python.org/dev/peps/pep-3101/#controlling-formatting-on-a-per-type-basis)  on the object being converted to a string.
With  `str.format()`, the replacement fields are marked by curly braces:
	```python
	name = 'Eric'
	age = 74
	# 1. empty curly braces. 
	# refer variables in sequence as appeared in format method
	"
	```python
	"Num: %d Hex: %x" % (12, 13)
	# 'Num: 12 Hex: d'
	
	"%s %s" % ('hello', 'world')
	# 'hello world'
	```
	
* format
	```python
	name = 'Matt'
	print('Hello, {}. You are {}."'.format(name, age))
	# 'Hello, Eric. You are 74.'

	# 2. insert index insdie curly braces
	"Hello, {1}. You are {0}.".format(age, name)
	# 'Hello, Eric. You are 74.'
	
	# 3. insert variable names inside curly braces
	person = {'name': 'Eric', 'age': 74}
	"Hello, {name}. You are {age}.".format(name=person['name'], age=person['age'])
	# 'Hello, Eric. You are 74.'
	
	# 4. use ** to unpack the dictionary
	"Hello, {name}. You are {age}.".format(**person)
	# 'Hello, Eric. You are 74.'

 Matt

	print('I:{} R:{} S:{}'.format(1, 2.5, 'foo'))
	# I:1 R:2.5 S:foo
	
	"Name: {:*^12}".format("Ringo")
	# 'Name: ***Ringo****'
	
	"Percent: {:=+10.1%}".format(-44/100)
	# 'Percent: - 44.0%'
	```
	
4.* f-string from Python 3.6 [PEP 498](https://www.python.org/dev/peps/pep-0498/)
	Because f-strings are evaluated at **runtime**, you can put any and all valid Python expressions in them.
	```python
	f"{2 * 37}"
	# '74'
	
	name = 'matt'
	f"My name is {name.capitalize()}"
	# 'My name is Matt'
	
	f'Square root of two: {2**.5:5.3f}
	# 'Square root of two: 1.414'
	```
### Multi-lines
1. triple-quotes
	It may contains unwanted `\n` and `\t`
	```python
	s = """This string has
		many
		many
		lines."""
	# 'This string has\n\t\tmany\n\t\tmany\n\t\tlines.'
	```

3. space + backslash
	```python
	s = "This string has " \
		"many " \
		"many " \
		"lines."
	# 'This string has many many lines.'
	```

4. braces
	```python
	s = (
		"This string has "
		"many "
		"many "
		"lines."
	)
	# 'This string has many many lines.'
	```

### str.rpartition
`rpartition` can be quite handy in separate a file name and its extension.
```python
filename = 'foobar.txt'
basename, __, ext = filename.rpartition('.')
```


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

### copy# Copy of a lists
`names = ['John', 'Paul', 'George', 'Ringo']`
Below ==`[:]`== will create a **new** list object with a different identity. But the items' identity remains the same with `names`. 
`names2 = names[:]`

`id(names) is not id(names2)`
`id(names[0]) is id(names2[0])`

### manipulate lists with `filter` and `map`
List comprehensions provide a powerful, concise way to work with lists. Also, the `map()` and `filter()` functions can perform operations on lists using a different, more concise syntax.

```python
# Filter elements greater than 4
# Bad
a = [3, 4, 5]
b = []
for i in a:
	if i > 4:
		b.append(i)


# Good
a = [3, 4, 5]
b = [i for i in a if i > 4]

# Or:
b = filter(lambda x: x > 4, a)


# Add three to all list members.
# Bad:
a = [3, 4, 5]
for i in range(len(a)):
	a[i] += 3


# Good:
a = [3, 4, 5]
a = [i + 3 for i in a]

# Or:
a = map(lambda i: i + 3, a)


# Use enumerate() keep a count of your place in the list.
a = [3, 4, 5]
for i, item in enumerate(a):
	print(i, item)
# prints
# 0 3
# 1 4
# 2 5
```

## indexing & slicing
Python provides two constructs to pull data out of sequence-like types (**lists, tuples, and even strings**). These are the indexing and slicing constructs. Indexing allows you to access single items out of a sequence, while slicing allows you to pull out a sub-sequence from a sequence.
#### index with []
Remember that in Python indices start at 0. If you want to pull out the first item you reference it by 0, not 1. This is called ==zero-based indexing==.

> Guido van Rossum, the creator of Python, tweeted to explain how to understand negative index values:
[The] proper way to think of [negative indexing] is to reinterpret a[-X] as
a[len(a)-X]
@gvanrossum

Note: 
* sets don't support index operations.
* implement `.__getitem__` method if a self-defined class needs to support index operations.

#### slice with :
Python uses the ==half-open== interval convention. The list goes up to but
does not include the end index.
`my_pets = ["dog", "cat", "bird"]`
* The first index is optional. Be default, it is the first item of the list (the zeroth item). e.g. `my_pets[:1]`
* The final index is optional. By default, it is the end of the list. e.g. `my_pets[1:]`
* Default both start/first and final/end indices, the slice will return from the start to the end, which means a copy of the whole list. e.g. `my_pets[:]`
* The default stride is 1, which can be set as negative for reverse strides. e.g. `my_pets[::-1]` would reverse the whole sequence. 
	`'hello'[::-1]` would get 'olleh'.
	> the range function has a similar third parameter that specifies stride:
	list(range(0, 7, 3)) will get you [0, 3, 6]

['dog', 'cat']
* A negative index can be used in the start location or ending location. The index -1 represents the last item.

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

#### Note:
* Because sets must be able to compute a **hash value** for each item in the set, sets can only contain items that are hashable.
* Mutable items are not hashable in Python, which means you cannot hash a
list or dictionary.
* To hash your own user-created classes, you will need to implement `__hash__` and `__eq__`.
* To use the `in` operation, also implements the `__contains__` method.


### dictionary
It is a building block in Python. Classes, namespaces, and modules in Python are all implemented using a dictionary under the covers.
From Python 3.6, dictionary items are ordered based on key insertion order.

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
You can still use the `in` statement to check membership of a key.
To retrieve it:
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
Dictionary methods keys, values and items all return views of the dictionary, which reflects the current state. It is not a **copy** of keys, values or items.

#### sort / order
Sort the sequence of the iteration if a different order is desided.
```python
# sorted() function will return a NEW sorted list
for name in sorted(data.keys()):
	print(name)

```

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


### function
A function  implicitly returns ==None== if the function ends without return being called.
Do not use mutable types (lists, dictionaries) for default parameters unless you know what you are doing. Because of the way Python works, **the default parameters are created only once—at function definition time, not at function execution time**. If you use a mutable default value, you will end up re-using the same instance of the default parameter during each function invocation:
```python
# BAD! Used mutable list as a default argument.
def to_list(value, default=[]):
	default.append(value)
	return default

to_list(4) # [4]
to_list('hello') # [4, 'hello'], which means the same 'default' is reused.

# GOOD! Use an immutable default argument and then initiate it at execution time.
def to_list2(value, default=None):
	if default is None:
		default = []
	# above if can also be written as a single line using a conditional expression
	# default = default if default is not None else []
	default.append(value)
return default

to_list(4) # [4]
to_list('hello') # ['hello']
```

### arguments
There are four different ways to pass arguments to functions.

#### 1. positional arguments
Positional arguments are mandatory and have no default values. 

They are the simplest form of arguments and they can be used for the few function arguments that are fully part of the function’s meaning and their order is natural. 

For instance, in `send(message, recipient)` or `point(x, y)` the user of the function has no difficulty remembering that those two functions require two arguments, and in which order. In those two cases, it is possible to use argument names when calling the functions and, doing so, it is possible to **switch the order of arguments**, calling for instance `send(recipient=’World’, message=’Hello’)` and `point(y=2, x=1)` but this reduces readability and is unnecessarily verbose, compared to the more straightforward calls to `send(’Hello’, ’World’)` and `point(1, 2)`.


#### 2. keyword arguments
Keyword arguments are not mandatory and have default values. 
They are often used for **optional parameters** sent to the function. When a function has more than two or three positional parameters, its signature is more
difficult to remember and using keyword arguments with **default values** is helpful. For instance, a more complete send function could be defined as `send(message, to, cc=None, bcc=None)`. Here `cc` and `bcc` are
optional, and evaluate to `None` when they are not passed another value.

#### 3. arbitrary argument ==list==
The arbitrary argument list is the third way to pass arguments to a function. If the function intention is better expressed by a signature with an extensible number of positional arguments, it can be defined with the ==`*args`== constructs. In the function body, `args` will be a **tuple** of all the remaining positional arguments. 

For example, `send(message, *args)` can be called with each recipient as an argument: `send(’Hello’, ’God’, ’Mom’, ’Cthulhu’)`, and in the function body `args` will be equal to `(’God’, ’Mom’, ’Cthulhu’)`.

However, this construct has some drawbacks and should be used with caution. If a function receives a list of arguments of the same nature, it is often more clear to define it as a function of one argument, that argument being a list or any sequence. Here, if send has multiple recipients, it is better to define it explicitly: `send(message, recipients)` and call it with `send(’Hello’, [’God’, ’Mom’, ’Cthulhu’])`. This way, the user of the function can manipulate the recipient list as a list beforehand, and it opens the possibility to pass any sequence, including iterators, that cannot be unpacked as other sequences.

#### 4. arbitrary keyword argument ==dictionary==
The arbitrary keyword argument dictionary is the last way to pass arguments to functions. If the function requires an undetermined series of named arguments, it is possible to use the ==`**kwargs`== construct. In the function body, `kwargs` will be a dictionary of all the passed named arguments that have not been caught by other keyword arguments in the function signature.

The same caution as in the case of arbitrary argument list is necessary, for similar reasons: these powerful techniques are to be used when there is a proven necessity to use them, and they should not be used if the simpler and clearer
construct is sufficient to express the function’s intention.

Note:
It is up to the programmer writing the function to determine which arguments are *positional arguments* and which are *optional keyword arguments*, and to decide whether to use the advanced techniques of *arbitrary argument* passing. If the advice above is followed wisely, it is possible and enjoyable to write Python functions that are:
* easy to read (the name and arguments need no explanations)
* easy to change (adding a new keyword argument does not break other parts of the code)


## class
### dir
You can always use the built-in `dir` function to list attributes of an object.

### attribute types
1. class attributes
	Attributes that are **constant**, which are **shared** among all instances of a class, are put inside the class definition.

2. instance attributes
	Attributes that are **unique** to each instance, are put in the constructor method `__init__`.
	e.g. `__init__(self, id)`.

Python has a hierarchy for looking up attributes. 
Attribute lookup occurs first on the instance, then the class, then the parent classes, and will raise a `AttributeError` if the attribute was not found.

### `__class__` attribute
```python
chair.__class__
# <class '__main__.Chair'>
```

It is important that an instance know what its class is because ==the class stores the methods and class attributes==.

### the `self` parameter inside methods
`self` parameter represents the current instance of the class.
```python
class Chair:
	max_occupants = 4 # class attribute

	def __init__(self, id)
		self.id = id # instance attribute
		count = 0 # instance attribute
		
	def load(self, number):
		self.count += number

	def unload(self, number):
		self.count -= number
```
Python handles passing around the `self` parameter automatically.
e.g.
When you call:
`chiar.load(3)`
What happens under the covers is similar to this:
`Chair.load(chair, 3)`
Python will call the `.load` method by inserting `chair` as the 	`self` parameter and 3 as the `number` parameter.

### private & protected with a single underscore ==`_`==

Some languages have the notion of private attributes or methods. These are methods that are meant to be implementation details and end users can’t call them. But, Python does not make an effort to prevent users from doing much of anything. Rather, it takes the attitude that you are an adult and you should take responsibility for your actions. If you want to access something, you can do it. But you should be willing to accept the consequences.

In a nut shell, any client code can override an object’s properties and methods: there is no “private” keyword in Python. This philosophy, very different from highly defensive languages like Java, which give a lot of mechanisms to prevent any misuse, is expressed by the saying: “We are all responsible users”.

```python
Class Chair:
	''' A Chair on a chairlift '''
	max_occupants = 4

	def __init__(self, id):
	self.id = id
	self.count = 0

	def load(self, number):
		new_val = self._check(self.count + number)
		self.count = new_val

	def unload(self, number):
		new_val = self._check(self.count - number)
		self.count = new_val

	def _check(self, number): # considered private
		if number < 0 or number > self.max_occupants:
			raise ValueError('Invalid count:{}'.format(number))
		return number
```
The ._check method is considered private, only the instance should access it inside the class. In the class, the .load and .unload methods call the private method. If wanted, you could call it from outside the class. But you shouldn’t, as anything with an underscore should be ==considered an implementation detail== that might not exist in future versions of the class.
