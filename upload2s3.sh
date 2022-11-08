sh terraform/s3bucket_terraform.sh
sh setup_source_jobnotifier.sh

mkdir bucketfold

echo "zip files for s3"
cd api_server
zip ../bucketfold/api_server.zip requirements.txt
zip -r ../bucketfold/api_server.zip source_main
cd ..

echo "upload to s3"
aws s3 cp bucketfold/api_server.zip s3://job-notifier-src-bucket/

cd cal-api/job_crawler
zip -r ../../bucketfold/job_crawler.zip .

cd ..

echo "upload to s3"
aws s3 cp bucketfold/job_crawler.zip s3://job-notifier-src-bucket/

cd requests-layer
pip3 install -r requirements.txt --target python/lib/python3.9/site-packages
zip -r ../bucketfold/requests-layer.zip .
cd ..

echo  "upload to s3"
aws s3 cp bucketfold/requests-layer.zip s3://job-notifier-src-bucket/
