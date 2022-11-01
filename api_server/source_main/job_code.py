### 1. Setup Fast api
## 1. Setup fastapi to return jobs with id, title and description
# 1. "/job" a list of jobs 
# 1. "/job/:id" "single job matching the id

from http.client import HTTPException
from fastapi import FastAPI
import uvicorn

app =FastAPI()

jobs = [{
        "id": "01",
        "job_Title": "Human Resource(HR)",
        "job_Description": "Recruting employees, Employee Benefits planning and administration to build a community culture" 
    },
    {
        "id": "02",
        "Job_Title": "IT System Administator",
        "Job_Description": "participate in the creation of IT concepts, emergency plans and the direct maintenance of customers documentation"
    },
    { 
        "id": "03",
        "job_Title": "Sales Representative",
        "job_Description": "Sales reps ensure current customers have the right products and services, identify new markets and customer leads, and pitch prospective customers."
    },
    {
        "id": "04",
        "job_Title": "Manager",
        "job_Description": "Accomplishes department objectives by managing staff; planning and evaluating department activities.Establishes strategic goals by gathering pertinent business, financial, service, and operations information."
    },
    {
        "id": "05",
        "job_Title": "Software Engineer",
        "job_Description": "Software Development, Analysis, Maintenance, Planning and Project Management"
    }]

@app.get("/job")
def joblist():
    return jobs

@app.get("/job/{id}")
def joblist(id):
    for job in jobs :
        if job["id"] == id:
            return job      
    raise HTTPException(status_code=404,detail="Job with id" + id + "not found")         

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)