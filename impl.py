import json

JOB_STATUS= { "open": 0, "closed":1 }

def sqldata_as_json(db, sqlcmd):
    """
    To convert sql results as json
    """
    db.execute(sqlcmd);
    row_headers=[x[0] for x in db.description]
    json_data=[]
    rows = db.fetchall()
    for result in rows:
        json_data.append(dict(zip(row_headers,result.values())))
    return json.dumps(json_data,indent=4, sort_keys=True, default=str)

def query_jobs(db, status, q):
    """
    To query jobs table
    """
    sqlcmd = "select * from jobs "
    sqlcmd += "inner join companies on jobs.company_id=companies.company_id"
    if status != "all":
        sqlcmd += " where status = {0}".format(JOB_STATUS[status])
    likeq = q.replace(" ","%")
    sqlcmd = sqlcmd + " AND job_title like '%" + likeq + "%'"
    return sqldata_as_json(db, sqlcmd)


def query_shortlisted(db, position):
    """
    To query shortlisted candidates for particular job
    """

    sqlcmd = "select * from shortlisted"
    sqlcmd += " inner join candidates on shortlisted.candidate_id=candidates.candidate_id"
    sqlcmd += " inner join jobs on shortlisted.job_id=jobs.job_id"
    sqlcmd += " where shortlisted.job_id=" + position
    return sqldata_as_json(db, sqlcmd)


def query_interviews(db, jobid, candid):
    """
    To query interview schedule
    """
    sqlcmd = "select * from interviews where job_id={0} and candidate_id={1} ORDER BY updated_on DESC".format(jobid, candid)
    return sqldata_as_json(db, sqlcmd)
