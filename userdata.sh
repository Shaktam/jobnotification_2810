#!/bin/bash
cd /home/ec2-user/
aws s3 cp s3://jobs3bucket24/api_server.zip api_server.zip
unzip api_server.zip
rm api_server.zip
cd bucketfold/source_main
pip3 install -r requirements.txt
python3 job_code.py

