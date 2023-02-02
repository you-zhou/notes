# Python plot


This variable is usually left ==empty==. Leave it e# Matplotlib
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

#s or `
### mpy in tur cplt. `plt.ray  the 

## pyplot
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
This is a command that draws points for WSGI applications and has become one of the most advanced WSGI utility modules. It includes a powerful debugger, full-featured request and response objects, HTTP utilities to handle entity tags, cache control headers, HTTP dates, cookie handling, file uploads, a powerful URL routing system and a bunch of community-contributed addon modules.
* [Requests](https://github.com/requests/requests) is an Apache2 Licensed HTTP library, written in Python, for human beings.
* [Tablib](https://github.com/kennethreitz/tablib) is a format-agnostic tabular dataset library, written in Python.

## python --version
If you still see 2.7 ensure in PATH `/usr/local/bin/` takes pecedence over `/usr/bin/`.

## `PYTHONPATH` and `sys.pathlines and returns a list of Line2D objects. One sublety is that plot() will automatically call figure() and/or subplot() if neccesary to create the underlying Figure and Axes objects.
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
#### `PYTHONPATH` environment variable
`PYTHONPATH` is an environment variable listing non-standard directories that Python looks for **modules** or **packages** in.

This variable is usually left ==empty==. Leave it eplt.gca() `gca: Get Current Axes`
Same as with plt.gcf(), you can use plt.gca() to get a reference to the current axes, if you need to change the limits on the y-axis, for example.

```python
import matplotlib.pyplot as plt
import numpty unless you are developing code and want to use libraries that have not been installed. Otherwise, changing `PYTHONPATH` can be confusing to others tryas np

x = np.linspace(0,10,9)
y = np.randn(9)

# this call creates a figure in the background
plt.scatter(x,y)

# this allows you to retrieve the axis
# ing to debug yohe figure code who forget that `PYTHONPATH` has been changed.

If you had some code in `/home/test/a/reated 
# by the call to scatter() above
axis = plt.gca()
axis.set_ylim(-3,3)

plt.show()
```

#### plt.cla() / plot.py`, but were working out of `/home/test/b/`, using `PYTHONPATH` allows access to that code. Otherwise, ifclf() `clear figure/axes`
These methods are used to clear the current figure `plot.py` was not installed using system or Python tools, trying to import it would raise an `ImportError`:
```python
 import plot
Traceback (most recent call last):
File "<stdin>", line 1, in <module>
ImportError: No module named plot
```
You can start Python by setting the `PYTHONPATH` to point to a directory that contains the required libraries:
`$ PYTHONPATH=/home/test/a python3`
```python
import plot
plot.histogram() # found plot
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

## pyplot
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
