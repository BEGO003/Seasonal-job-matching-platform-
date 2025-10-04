package grad_project.seasonal_job_matching.model;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Jobs")
public class Job {

    @Id
    @Column
    private int id;

    @Column
    private String title;

    @Column
    private String description;

    @Column
    private JobType type;

    @Column
    private String location;

    @Column
    private Date startDate;

    @Column
    private Date endDate;

    @Column// foreign key from user table
    private String userID;

    @Column
    private float salary;

    @Column
    private JobStatus status;

    @Column
    private int numofpositions;

    public Job(int id, String title, String description, JobType type, String location, Date startDate, Date endDate, String userID, float salary, int numofpositions, JobStatus status){
        this.id = id;
        this.title = title;
        this.description = description;
        this.type = type;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.userID = userID;
        this.salary = salary;
        this.numofpositions = numofpositions;
        this.status = status;
    }
    //create setters and getters
}
