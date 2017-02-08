#!/bin/bash
cd /tmp && wget http://nginx.org/keys/nginx_signing.key; cd /tmp &&  apt-key add     nginx_signing.key;

