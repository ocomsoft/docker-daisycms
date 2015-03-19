#!/bin/bash
sudo docker build -t daisycms .
sudo docker run  -d -p 8888:8888 daisycms /daisy/setup/run.sh
