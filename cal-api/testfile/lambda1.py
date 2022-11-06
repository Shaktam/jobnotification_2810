
import boto3
import requests
import json

  
url = "https://www.arbeitnow.com/api/job-board-api"
response = requests.get(url)
jobdata = response.json()
data = jobdata["data"][0]
s3 = boto3.resource("s3")

job_info = {
            "Id":data["slug"],
            "Job_title":data["title"],
            "Job_description":data["description"],
            "Remote":data["remote"]
            } 
with open('job_data.json', "w") as f:
    f.write(json.dumps(job_info))  

i =1
for data in jobdata["data"]:
    s3.meta.client.upload_file('job_data.json', 'jobdatas3buck', 'job_data' + str(i)+'.json')
    i+=1



