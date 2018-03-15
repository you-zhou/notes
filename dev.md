Dev Notes
----------
# GIT
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



# Matplotlib
It's a Python plotting library, inspired by MATLAB, meaning that the terms used (**Axis, Figure, Plots**) will be similar to those used in MATLAB. [ref](http://queirozf.com/entries/matplotlib-pylab-pyplot-etc-what-s-the-different-between-these)

## Figure
`This is the entire window where one or more subplots live. A Figure object (new window) is created with the figure() command.`
You can use it to configure things like:
* Image size (set_size_inches())
* Whether to use tight_layout (set_tight_layout())
  This adjusts the subplot padding; generally makes things look better.

 
## Axes
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

### plot()
This is a command that draws points or lines and returns a list of Line2D objects. One sublety is that plot() will automatically call figure() and/or subplot() if neccesary to create the underlying Figure and Axes objects.
### subplot()
This is a command that creates and returns a new subplot (Axes) object which will be used for subsequent plotting commands.


### plt.gcf() `gcf: Get Current Figure`
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
### plt.gca() `gca: Get Current Axes`
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

### plt.cla() / plt.clf() `clear figure/axes`
These methods are used to clear the current figure `plt.clf()` or the current axes `plt.cla()`.


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
# Use index of date array as the x-tick.
xticks = [i for i in range(len(xticklabels))]

ax.plot(xticks, y)
ax.set_xticklabels(xticklabels, rotation=45)
```


## plot vertical lines
```python
# Add a vertical line separator.
ax.axvline(x=5, color='r', linestyle='dashed')
```

## plot small grid lines
```python
ax.grid(True, linestyle=':')
```

# PYTHON
## Why ```if __name__ == '__main__'```?

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


## self
TODO



## Divide Operator
* 26 % 7 == 5 (you will get remainder)

* 26 / 7 == 3.7142857142857144 (you will get divisor can be float value )

* 26 // 7 == 3 (you will get divisor only integer value) )


# Django
## Slug
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


# Markdown
## Text
asterisk: this is *italic* and this is **bold**.

underscore: another _italic_ and another __bold__.

the back ticks represent `important` text.

the % is `%`

## Indentation
> some indentation
>> more indentation
>>> even more intendation

## Bullets
+ item-1
- item-2
* item-3
  + sub-item-1
  - sub-item-2
  * sub-item-3


# Proxy
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


## Check proxy details from Chrome
chrome and go to below URL to see the proxy details:
chrome://net-internals/#proxy

## Check proxy setttings from regedt in Windows 
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
eyJoaXN0b3J5IjpbLTU4NTU2NDk0MV19
-->