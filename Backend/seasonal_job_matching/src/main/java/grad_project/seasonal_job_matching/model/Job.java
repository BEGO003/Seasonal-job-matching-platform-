package grad_project.seasonal_job_matching.model;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import grad_project.seasonal_job_matching.model.enums.JobStatus;
import grad_project.seasonal_job_matching.model.enums.JobType;
import grad_project.seasonal_job_matching.model.enums.WorkArrangement;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Jobs")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Job {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private long id;

    @Column(nullable = false)
    private String title;

    @Column
    private String description;

    @Column
    private JobType type;

    @Column(nullable = false)
    private String location;

    @Column
    private Date startDate;

    @Column
    private Date endDate;

    @ManyToOne
    @JoinColumn(name = "jobposterID", nullable = false, referencedColumnName = "id")// foreign key from user table
    //@Column
    @JsonIgnoreProperties //to prevent infinite loop of getting user and all his info and then getting all of users jobs which is this one and so on
    private User jobposter;

    @Column
    private float salary;

    @Column(nullable = false)
    private JobStatus status;

    @Column
    private int numofpositions;

    @Column
    private WorkArrangement workarrangement;


    public Job(int id, String title, String description, JobType type, String location, Date startDate, Date endDate, User jobposter, float salary, int numofpositions, JobStatus status, WorkArrangement workarrangement){
        this.id = id;
        this.title = title;
        this.description = description;
        this.type = type;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.jobposter = jobposter;
        this.salary = salary;
        this.numofpositions = numofpositions;
        this.status = status;
        this.workarrangement = workarrangement;
    }
    //create setters and getters

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public JobType getType() {
        return type;
    }

    public void setType(JobType type) {
        this.type = type;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public User getjobposter() {
        return jobposter;
    }

    public void setjobposter(User jobposter) {
        this.jobposter = jobposter;
    }

    public float getSalary() {
        return salary;
    }

    public void setSalary(float salary) {
        this.salary = salary;
    }

    public JobStatus getStatus() {
        return status;
    }

    public void setStatus(JobStatus status) {
        this.status = status;
    }

    public int getNumofpositions() {
        return numofpositions;
    }

    public void setNumofpositions(int numofpositions) {
        this.numofpositions = numofpositions;
    }
}
