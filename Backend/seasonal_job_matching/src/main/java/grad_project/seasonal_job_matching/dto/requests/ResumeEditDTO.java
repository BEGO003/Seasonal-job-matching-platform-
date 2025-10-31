package grad_project.seasonal_job_matching.dto.requests;

import java.util.List;

import lombok.Data;

@Data
public class ResumeEditDTO {
    
    private String education;

    private String experience;

    private String certificates;

    private List<String> skillsToAdd;
    private List<String> skillsToRemove;
        
    private String languages;
}
