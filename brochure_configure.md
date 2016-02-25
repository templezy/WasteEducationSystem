# Django production environment configuration

* Settings module haven't been found (caused by the directory not found) Solutions:
	* Open the wsgi.py add ```import sys```
	* Add the project directory ```sys.path.append('path/to/your.project')```
* Using the proxy to bind the port 8080 to 80 => Try to use Unix port
* Figure out the relationships between the unicorn, Nginx and uwsgi
* Write the configuration file to boot up the server
* Solve the problem of unaccessible of the static files (images/js/css) => Define the static directories

---

* ** Directory of the Nginx virtual environment => /usr/share/wa-server/ **
* ** /bin/activate to boot up the server **
* ** ini file is under the project directory **

---

Solution to static accessing:

* Add the ```STATIC_ROOT = os.path.join(BASE_DIR, "static")```
* Run command ```python manage.py collect static```
* Set the directory to the static files directory in the Nginx configuration file

---

CMD:

* Boot up the server```uwsgi --socket 0.0.0.0:8080 --protocol=http -w wsgi```
* *** Make it run at the background ***

---

# Secure RESTful API enhancement

* Use the secure RESTful API fetch the information form server

---

1. Fetch the token by given the specific username and password, if the user not existed the system will return an error
2. Set the header of request by the token
3. Get the data from the server

---

# Facebook API

* Use username and password log in to the Facebook through the Facebook API
* Fetch the the user information and generate a unique id
* Bind the id to the feedback submission system

---

* Figure out the UI problem for the Facebook API


---

# Abstract data model design

* Fundamental data model




