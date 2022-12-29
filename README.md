SOPDS home library with MySQL database

# Introduction

Dockerfile and docker-compose files to build a Simple OPDS server docker image.
http://www.sopds.ru

# Installation and start

First create file .env and fill it with variables:

```
DB_USER=<user>
DB_NAME=<sopds>
DB_PASS=<pass>
DB_HOST=<db.hostname>
PORT=8081
LIBRARY_PATH=</library>
HOSTNAME=<host.com>
```

Then build image and start the container:

```
sudo docker-compose up -d
```

This will start the sopds server and you should now be able to browse the content on port 8081.
