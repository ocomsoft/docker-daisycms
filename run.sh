#!/bin/bash
docker build -t daisycms .
docker run  --name daisycms -d -p 8888:8888 daisycms /daisy/setup/run.sh
