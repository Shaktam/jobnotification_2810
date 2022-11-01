#!/bin/bash
cd /home/ec2-user/
aws s3 cp s3://job-terraform-bucket-alb/api_server.zip api_server.zip
unzip api_server.zip
rm api_server.zip
cd bucketfold/source_code
pip3 install -r requirements.txt
cd bucketfold/source_code/source_main
python3 job_code.py
