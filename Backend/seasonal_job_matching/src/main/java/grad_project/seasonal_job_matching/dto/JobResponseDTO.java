package grad_project.seasonal_job_matching.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import grad_project.seasonal_job_matching.model.JobStatus;
import grad_project.seasonal_job_matching.model.JobType;
import grad_project.seasonal_job_matching.model.User;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.Data;

@Data
public class JobResponseDTO {

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
    private User jobposter;
    @PositiveOrZero
    private float salary;
    private JobStatus status;
    private int numofpositions;

}