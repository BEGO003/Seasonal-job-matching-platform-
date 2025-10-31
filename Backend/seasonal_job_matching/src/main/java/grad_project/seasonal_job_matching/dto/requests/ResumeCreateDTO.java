package grad_project.seasonal_job_matching.dto.requests;

import java.util.List;

import lombok.Data;

@Data
public class ResumeCreateDTO {

    private String education;

    private String experience;

    private String certificates;

    private List<String> skills;
    
    private String languages;

}
