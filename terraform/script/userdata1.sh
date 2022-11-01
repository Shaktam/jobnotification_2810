#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
cd /home/ec2-user/
aws s3 cp s3://job-terraform-bucket-alb/api_server.zip api_server.zip
unzip api_server.zip
rm api_server.zip
cd bucketfold
pip3 install -r requirements.txt
cd source_main
python3 job_code.py
