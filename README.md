#Production Environment

---

##Set up an App Directory and a Virtualenv

We will start by creating a folder for 'Waste Education System'. This can hold a nested folder containing the actual application code in a more complete application. For our purposes, this directory will simply hold our virtual environment and our WSGI entry point:

`mkdir ~/weserver/`

Next, move into the directory so that we can set up the environment for our system:

`cd ~/weserver`

Create a virtual environment with the virtualenv command. We will call this weserverenv for simplicity:

`virtualenv weserverenv`

A new Python environment will be set up under a directory called weserverenv. We can activate this environment by typing:

`source weserverenv/bin/activate`

Your prompt should change to indicate that you are now operating within the virtual environment. It will look something like this:

`(weserverenv)username@host:~/we_server$`

If you wish to leave this environment at any time, you can simply type:

`deactivate`

If you have deactivated your environment, re-activate it again to continue with the guide.

With this environment active, any Python packages installed will be contained within this directory hierarchy. They will not interfere with the system's Python environment. 

We should install the dependencies in our project.

`pip install django`
`pip install MySQL-python`
`pip install djangorestframework`


We can now install the uWSGI server into our environment using pip. The package for this is called uwsgi (this is still the uWSGI server and not the uwsgi protocol):

`pip install uwsgi`

##Start the server

Go to the directory which contains the file 'wsgi.py' and run the command:

`uwsgi --socket 0.0.0.0:8080 --protocol=http -w wsgi`

Now the server is running on the 8080 port. You can change the port whatever you want.

---

Tips:

* Yon can also choose the Nginx to serve the whole system. The reverse proxy will enable all user access from the default port thought the domain name.
* Before you start the server you may need to run the command `python manage.py collectstatic` to generate the static directory for system access a variety of resources files.




