GIT
==============================================================================
$ git config --global user.name "George Brocklehurst"
$ git config --global user.email george@georgebrock.com


$ git status
$ git diff
$ git diff --staged

$ git commit --patch

$ git log --oneline --decorate

# Reword the last commit message
$ git commit --amend

	# This can be useful to include files you forgot to track, or include modifications to the files you just commited. To do so, you can add the changes and then perform the amend:
	$ git add README.md config/routes.rb
	$ git rm notes.txt
	$ git commit --amend




DJANGO
==============================================================================




PYTHON
==============================================================================
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




## Divide Operator
* 26 % 7 == 5 (you will get remainder)

* 26 / 7 == 3.7142857142857144 (you will get divisor can be float value )

* 26 // 7 == 3 (you will get divisor only integer value) )



==============================================================================




==============================================================================




Test
==============================================================================
## Text Basics

asterisk: this is *italic* and this is **bold**.

underscore: another _italic_ and another __bold__.

the backticks represent `important` text.

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


==============================================================================

==============================================================================

==============================================================================

==============================================================================

==============================================================================

==============================================================================

==============================================================================

==============================================================================

==============================================================================

==============================================================================

==============================================================================

