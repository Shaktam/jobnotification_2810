import boto3
import json

s3_client = boto3.client("s3")

job_data_bucket = "job-terraform-bucket-alb" 

def save_job_to_s3(job):
    job_data_string = json.dumps(job)
    job_data_bytes = str.encode(job_data_string)
    s3_client.put_object(
        Body = job_data_bytes,
        Bucket = job_data_bucket,
        Key = job["id"]+".json"
    )
def save_jobs_to_s3(jobs):
    for job in jobs:
        save_job_to_s3(job)