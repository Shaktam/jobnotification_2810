# write a lambda python function that fetch the job data from (https://www.arbeitnow.com/api/job-board-api) and creates a json file for every job inside of the s3 bucket
#  (hint: to use requests you need to upload a source package or a layer with the dependency)
# get data from s3, transfer data and svae the data to s3.


from s3_utlities import save_jobs_to_s3
from arbeitnowapi import load_jobs

def map_jobs(jobs_from_api):
    jobs= []
    for api_job in jobs_from_api:
        jobs.append({
            "id":api_job["slug"],
            "job_title":api_job["title"],
            "job_description":api_job["description"],
            "remote":api_job["remote"]
        })
    return jobs

def handler(event, context):
    jobs_from_api=load_jobs()
    jobs=map_jobs(jobs_from_api)
    save_jobs_to_s3(jobs)
    
 
if __name__ == "__main__":
    handler({},{})   