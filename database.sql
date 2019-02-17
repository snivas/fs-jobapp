DROP DATABASE snivas$jobconsultant;

CREATE DATABASE IF NOT EXISTS snivas$jobconsultant;
USE snivas$jobconsultant;


/* Company table */
CREATE TABLE IF NOT EXISTS companies (
    company_id INT AUTO_INCREMENT,
    company_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (company_id)
)  ENGINE=INNODB;

/* Jobs Table */
CREATE TABLE IF NOT EXISTS jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    job_title VARCHAR(255) NOT NULL,
    posted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status TINYINT NOT NULL DEFAULT '0',
    company_id INT NOT NULL REFERENCES companies(company_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
)  ENGINE=INNODB;

/* Candidates Table */
CREATE TABLE IF NOT EXISTS candidates (
    candidate_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_name VARCHAR(255) NOT NULL,
    works_at VARCHAR(255) NOT NULL,
    experience DECIMAL(3,1) DEFAULT '00.0',
    ctc DECIMAL(9,2) DEFAULT '00000.00'
)  ENGINE=INNODB;


/* Shortlisted Table */
CREATE TABLE IF NOT EXISTS shortlisted (
    sl_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL REFERENCES candidates(candidate_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    job_id INT NOT NULL REFERENCES jobs(job_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    updated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)  ENGINE=INNODB;

/* Interviews Table */
CREATE TABLE IF NOT EXISTS interviews (
    interview_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL REFERENCES candidates(candidate_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    job_id INT NOT NULL REFERENCES jobs(job_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    interview_round VARCHAR(255) NOT NULL,
    interviewer VARCHAR(255) NOT NULL,
    status TINYINT NOT NULL DEFAULT '0',
    updated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)  ENGINE=INNODB;



/* Insert Default companies */
INSERT INTO companies (company_name) VALUES  ("Company1");
INSERT INTO companies (company_name) VALUES  ("Company2");
INSERT INTO companies (company_name) VALUES  ("Company3");
INSERT INTO companies (company_name) VALUES  ("Company4");
INSERT INTO companies (company_name) VALUES  ("Company5");
INSERT INTO companies (company_name) VALUES  ("Company6");
INSERT INTO companies (company_name) VALUES  ("Company7");
INSERT INTO companies (company_name) VALUES  ("Company8");
INSERT INTO companies (company_name) VALUES  ("Company9");
INSERT INTO companies (company_name) VALUES  ("Company10");
INSERT INTO companies (company_name) VALUES  ("Company11");
INSERT INTO companies (company_name) VALUES  ("Company12");

/* Insert Default Jobs */
INSERT INTO jobs (job_title, company_id) VALUES  ("Company0 Job1", 3);
INSERT INTO jobs (job_title, company_id) VALUES  ("Company0Job2", 3);
INSERT INTO jobs (job_title, company_id) VALUES  ("Company1-Job1", 1);
INSERT INTO jobs (job_title, company_id) VALUES  ("Hello_Job2", 1);
INSERT INTO jobs (job_title, company_id) VALUES  ("Test Job1", 2);
INSERT INTO jobs (job_title, company_id) VALUES  ("Dev Job2", 2);
INSERT INTO jobs (job_title, company_id) VALUES  ("Dev4 job", 4);
INSERT INTO jobs (job_title, company_id) VALUES  ("Company5-Job", 5);
INSERT INTO jobs (job_title, company_id) VALUES  ("Hello_Job6", 6);
INSERT INTO jobs (job_title, company_id) VALUES  ("Test Job7", 7);
INSERT INTO jobs (job_title, company_id) VALUES  ("Dev Job8", 8);

INSERT INTO jobs (job_title, company_id) VALUES  ("Company0 Job1", 9);
INSERT INTO jobs (job_title, company_id) VALUES  ("Company0Job2", 8);
INSERT INTO jobs (job_title, company_id) VALUES  ("Company1-Job1", 9);
INSERT INTO jobs (job_title, company_id) VALUES  ("Hello_Job2", 8);
INSERT INTO jobs (job_title, company_id) VALUES  ("Test Job1", 9);
INSERT INTO jobs (job_title, company_id, status) VALUES  ("Dev Job2", 8, 1);
INSERT INTO jobs (job_title, company_id, status) VALUES  ("Dev4 job", 7, 1);
INSERT INTO jobs (job_title, company_id, status) VALUES  ("Company5-Job", 8, 1);
INSERT INTO jobs (job_title, company_id, status) VALUES  ("Hello_Job6", 8, 1);
INSERT INTO jobs (job_title, company_id, status) VALUES  ("Test Job7", 9, 1);
INSERT INTO jobs (job_title, company_id, status) VALUES  ("Dev Job8", 6, 1);


/* Insert Default candidates */
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate1", "Employer1", 8.0, 1200000.00);
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate2", "Employer2", 6.5, 800000.00);
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate3", "Employer3", 1.5, 600000.00);
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate4", "Employer1", 6.0, 1200000.00);
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate5", "Employer2", 4.5, 800000.00);
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate6", "Employer3", 5.5, 600000.00);
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate7", "Employer4", 6.0, 1200000.00);
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate8", "Employer5", 4.5, 800000.00);
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate9", "Employer6", 5.5, 600000.00);
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate10", "Employer7", 3.0, 1200000.00);
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate11", "Employer8", 2.5, 800000.00);
INSERT INTO candidates (candidate_name, works_at, experience, ctc) VALUES  ("Candidate12", "Employer9", 1.5, 600000.00);


/* Insert Shortlisted candidates */
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (1, 1);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (1, 2);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (2, 1);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (2, 2);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (3, 3);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (3, 4);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (4, 1);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (4, 2);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (4, 5);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (4, 6);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (5, 1);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (5, 2);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (5, 4);
INSERT INTO shortlisted (candidate_id, job_id) VALUES  (6, 4);

/* Insert Default Interview Schedule */
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (1, 1, "4rd Round", "Interviewer4", 0);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (1, 1, "3rd Round", "Interviewer3", 1);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (1, 1, "2rd Round", "Interviewer2", 2);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (1, 1, "1rd Round", "Interviewer1", 3);

INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (2, 2, "4rd Round", "Interviewer4", 0);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (2, 2, "3rd Round", "Interviewer3", 1);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (2, 2, "2rd Round", "Interviewer2", 2);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (2, 2, "1rd Round", "Interviewer1", 3);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (2, 2, "5rd Round", "Interviewer1", 4);

INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (3, 1, "4rd Round", "Interviewer4", 0);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (3, 1, "3rd Round", "Interviewer3", 1);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (3, 1, "2rd Round", "Interviewer2", 2);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (3, 1, "1rd Round", "Interviewer1", 3);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (3, 1, "5rd Round", "Interviewer1", 4);

INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (1, 3, "4rd Round", "Interviewer4", 0);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (1, 3, "3rd Round", "Interviewer3", 1);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (1, 3, "2rd Round", "Interviewer2", 2);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (1, 3, "1rd Round", "Interviewer1", 3);
INSERT INTO interviews (candidate_id, job_id,interview_round, interviewer, status) VALUES  (1, 3, "5rd Round", "Interviewer1", 4);
