package grad_project.seasonal_job_matching.dto.requests;

import java.sql.Date;

import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.model.enums.ApplicationStatus;
import lombok.Data;

@Data
public class ApplicationCreateDTO {

    private User user; //user that applied, has ID 

    private ApplicationStatus applicationStatus; 

    private Job job;

    private Date createdAt;

    private String describeYourself;

}
