mkdir bucketfold

echo "zip files for s3"
cd api_server
zip ../bucketfold/api_server.zip requirements.txt
zip -r ../bucketfold/api_server.zip source_code
cd ..

echo "upload to s3"
aws s3 cp bucketfold/api_server.zip s3://jobnotification-s3/