package grad_project.seasonal_job_matching.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import grad_project.seasonal_job_matching.model.JobStatus;
import grad_project.seasonal_job_matching.model.JobType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;

//request dto has different parameters and fields than response (they take objects)
public class JobDTO {

    private int id;
    
    @NotBlank
    private String title;
    private String description;
    @NotNull
    private JobType type;
    private String location;
    @JsonFormat(pattern = "dd-MM-yyyy")
    private Date startDate; 
    @JsonFormat(pattern = "dd-MM-yyyy")
    private Date endDate;   
    @NotNull
    private long jobposterID;
    @PositiveOrZero
    private float salary;
    private JobStatus status;
    private int numofpositions;

    public int getId() {
        return id;
    }

    public void setId(int id) {
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

    public long getjobposterID() {
        return jobposterID;
    }

    public void setjobposterID(long jobposterID) {
        this.jobposterID = jobposterID;
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
