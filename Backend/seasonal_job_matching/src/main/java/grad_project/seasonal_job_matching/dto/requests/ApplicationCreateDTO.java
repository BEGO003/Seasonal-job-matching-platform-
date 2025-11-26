package grad_project.seasonal_job_matching.dto.requests;


import lombok.Data;

@Data
public class ApplicationCreateDTO {

    //private User user; //automatically assigned from pathvariable

    //private ApplicationStatus applicationStatus;  //always pending at start

    //private Job job; //will be automatically assigned

    //private Date createdAt; //using time function,, automatically assigned

    private String describeYourself;

}
