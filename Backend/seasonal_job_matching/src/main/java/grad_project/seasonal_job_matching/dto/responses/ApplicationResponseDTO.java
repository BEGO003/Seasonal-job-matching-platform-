package grad_project.seasonal_job_matching.dto.responses;

import java.sql.Date;

import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.model.enums.ApplicationStatus;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;  // Add this import
import lombok.Data;

@Data
public class ApplicationResponseDTO {

    private long id;

    private long userId;  

    private ApplicationStatus applicationStatus; 

    @JsonIgnoreProperties({"listofJobApplications", "jobPoster"})  // Add this annotation
    private Job job;

    private Date createdAt;

    private String describeYourself;

}
