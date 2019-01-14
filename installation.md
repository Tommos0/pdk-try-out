
https://passivedatakit.org/getting-started/django-server

## Install postgresql with django
https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-django-application-on-ubuntu-14-04


## Install postgis

~~~~
sudo apt-get install postgis
~~~~

## Create database, database user, and postgis extension

http://suite.opengeo.org/docs/latest/dataadmin/pgGettingStarted/firstconnect.html
https://stackoverflow.com/questions/16527806/cannot-create-extension-without-superuser-role

https://docs.djangoproject.com/en/2.1/intro/tutorial01/
https://docs.djangoproject.com/en/2.1/intro/tutorial02/

~~~~
PostGres scripts (copy and paste all after running 'psql'):
CREATE DATABASE pdkdatabase;
CREATE USER pdkuser WITH PASSWORD 'wachtwoord';
ALTER ROLE pdkuser SET client_encoding TO 'utf8';
ALTER ROLE pdkuser SET default_transaction_isolation TO 'read committed';
ALTER ROLE pdkuser SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE pdkdatabase TO pdkuser;
ALTER ROLE pdkuser SUPERUSER;
CREATE EXTENSION postgis;
~~~~

## Install Django and connect it to database

- Make sure database name, username, and password match the names and password used above.
- Follow instructions on: https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-django-application-on-ubuntu-14-04
- I got an error similar to [post on stackoverflow](https://stackoverflow.com/questions/40582423/invalid-http-host-header) and fixed it by adding ALLOWED_HOSTS = ['0.0.0.0','localhost'] to settings.pu
- To test it, use trick on [link](https://www.ssh.com/ssh/tunneling/example): ssh -L 0.0.0.0:8000:0.0.0.0:8000 username@myserver.nl

# Install PDK
- path/to/django on our Server is /myproject/myprojectenv/local/lib/python2.7/site-packages/django
- The following command was not clear to me: '''source ../venv/bin/activate''' is this a virtual enviroment that comes with the repository code or does this refer to the virtual environment we already created as part of the django installation?
- Also confusing is when to implement the changes as suggested below:
...


Add to settings.py (see https://stackoverflow.com/questions/36760549/python-django-youre-using-the-staticfiles-app-without-having-set-the-static-ro):
~~~~
# All settings common to all environments
PROJECT_ROOT = os.path.dirname(os.path.abspath(__file__))
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(PROJECT_ROOT, 'static')
~~~~

In urls.py, use 'path' or 're.path' instead of 'url' (see https://stackoverflow.com/questions/47947673/is-it-better-to-use-path-or-url-in-urls-py-for-django-2-0 and https://docs.djangoproject.com/en/2.1/ref/urls/#url):
~~~~
path('data/', include('passive_data_kit.urls')),
~~~~

When using Django 2.1.3, solve the following errors:
1. "TypeError: __init__() missing 1 required positional argument: 'on_delete'" which I solved by editing the 'models.py' file and adding 'on_delete=models.CASCADE' as an argument to each 'models.ForeignKey' call. I guess this has something to do with my Django version (see https://stackoverflow.com/questions/44026548/getting-typeerror-init-missing-1-required-positional-argument-on-delete).
2. "ImportError: cannot import name 'logout'" which I solved by editing the 'urls.py' file to read  "from django.contrib.auth import logout" (see https://stackoverflow.com/questions/50669185/python-from-django-contrib-auth-views-import-logout-importerror-cannot-import-n).


Once installed, verify that the database is online ('service postgresql status') and otherwise turn it on ('service postgresql start'). Then run Django ('python manage.py runserver') and log into the admin page ('http://127.0.0.1:8000/admin/') with 'admin' and 'wachtwoord'.
