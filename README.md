SOPDS home library with MySQL database

# Introduction

Dockerfile to build a Simple OPDS server docker image.
http://www.sopds.ru

# Installation

Build the image yourself.

```
docker build -t edv64/sopds https://github.com/EDV64/sopds.git
```

# Quick Start

Run the image

```
docker run --name sopds -d \
   --volume /path/to/library:/books:ro \
   --publish 8081:8001 \
   edv64/sopds:latest
```

This will start the sopds server and you should now be able to browse the content on port 8081.
