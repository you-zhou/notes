# Django

## how to start a django project properly with cookiecutter

### create a virtual environment for the project

1. virtualenvwrapper

  `mkvirtualenv bitsroom` # new virtual environement will be activated after the creation
  or
* pipenv
  
  `$ cd ~/Dev/bitsroom` # **ENTER** project directory first
  `$ pipenv install` # create/prepare a virtual environment (the venv name will be assigned based on the project folder name)
	`$ pipenv shell` # activate virtual environment

1. use cookiecutter

	`$ pip install "cookiecutter>=1.4.0"` # do this within a virtual environment, as it will install several dependant packages.
	`$ cookiecutter -h` # check options
	`$ cookiecutter https://github.com/pydanny/cookiecutter-django` # this prompt values for the project.

2. track files with git

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

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}

```

And replace it with this:

```python
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

#### Setup Hheroku CLI

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

Inside the virtualenv, run `$ pip3 install dj. In  `settings/production.py`, at the very bottom:

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
