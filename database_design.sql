CREATE TABLE "Users"(
    "id" BIGINT NOT NULL,
    "name" TEXT NOT NULL,
    "number" BIGINT NOT NULL,
    "country" BIGINT NOT NULL,
    "email" BIGINT NOT NULL,
    "password" BIGINT NOT NULL,
    "ownedjobs" TEXT NULL,
    "ownedapplications" TEXT NULL,
    "favorite jobs (list of jobs)" BIGINT NOT NULL,
    "resume" BIGINT NOT NULL
);
ALTER TABLE
    "Users" ADD PRIMARY KEY("id");
CREATE TABLE "Jobs"(
    "id" BIGINT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "type" VARCHAR(255) CHECK
        ("type" IN('')) NOT NULL,
        "location" BIGINT NOT NULL,
        "startdate" DATE NOT NULL,
        "enddate" DATE NOT NULL,
        "jobposter" BIGINT NOT NULL,
        "salary" FLOAT(53) NOT NULL,
        "numofpositions" BIGINT NOT NULL,
        "status" VARCHAR(255)
    CHECK
        ("status" IN('')) NOT NULL,
        "workarrangement" VARCHAR(255)
    CHECK
        ("workarrangement" IN('')) NOT NULL,
        "listofjobapplications" BIGINT NOT NULL
);
ALTER TABLE
    "Jobs" ADD PRIMARY KEY("id");
CREATE TABLE "Resumes"(
    "id" BIGINT NOT NULL,
    "education" TEXT NOT NULL,
    "experience" TEXT NOT NULL,
    "certificates" TEXT NOT NULL,
    "skills" TEXT NOT NULL,
    "languages" TEXT NOT NULL
);
ALTER TABLE
    "Resumes" ADD PRIMARY KEY("id");
CREATE TABLE "JobApplication"(
    "id" BIGINT NOT NULL,
    "jobID" BIGINT NOT NULL,
    "userID" BIGINT NOT NULL,
    "applicationstatus" VARCHAR(255) CHECK
        ("applicationstatus" IN('')) NOT NULL,
        "createdat" TIME(0) WITHOUT TIME ZONE NOT NULL,
        "updatedat" TIME(0) WITHOUT TIME ZONE NOT NULL,
        "describeyourself" TEXT NOT NULL
);
ALTER TABLE
    "JobApplication" ADD PRIMARY KEY("id");
ALTER TABLE
    "Users" ADD CONSTRAINT "users_resume_foreign" FOREIGN KEY("resume") REFERENCES "Resumes"("id");
ALTER TABLE
    "JobApplication" ADD CONSTRAINT "jobapplication_jobid_foreign" FOREIGN KEY("jobID") REFERENCES "Jobs"("id");
ALTER TABLE
    "Users" ADD CONSTRAINT "users_ownedjobs_foreign" FOREIGN KEY("ownedjobs") REFERENCES "Jobs"("id");
ALTER TABLE
    "JobApplication" ADD CONSTRAINT "jobapplication_userid_foreign" FOREIGN KEY("userID") REFERENCES "Users"("id");