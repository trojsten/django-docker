#!/bin/bash

exec gunicorn --bind 127.0.0.1:8001 --access-logfile - --max-requests 2000 --max-requests-jitter 100 $1
