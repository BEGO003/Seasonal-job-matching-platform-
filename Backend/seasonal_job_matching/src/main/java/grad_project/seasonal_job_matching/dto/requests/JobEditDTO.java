package grad_project.seasonal_job_matching.dto.requests;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import grad_project.seasonal_job_matching.model.enums.JobStatus;
import grad_project.seasonal_job_matching.model.enums.JobType;
import grad_project.seasonal_job_matching.model.enums.WorkArrangement;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.Data;

@Data
public class JobEditDTO {
    private String title;
    private String description;
    private JobType type;
    private String location;
    @JsonFormat(pattern = "dd-MM-yyyy")
    private Date startDate; 
    @JsonFormat(pattern = "dd-MM-yyyy")
    private Date endDate;   
    @PositiveOrZero
    private float salary;
    private JobStatus status;
    private int numofpositions;
    private WorkArrangement workarrangement;
}
