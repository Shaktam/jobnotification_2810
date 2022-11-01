mkdir build

echo "zip files for server"
cd api-server
zip ../build/api-server.zip requirements.txt
zip -r ../build/api-server.zip  
cd ..

echo  "upload to s3"
aws s3 cp build/api-server.zip s3://job-notifier-src-bucket-2134/