package grad_project.seasonal_job_matching.dto.requests;

import java.util.List;

import lombok.Data;

@Data
public class ResumeEditDTO {

    private List<String> educationToAdd;
    private List<String> educationToRemove;

    private List<String> experienceToAdd;
    private List<String> experienceToRemove;


    private List<String> certificatesToAdd;
    private List<String> certificatesToRemove;


    private List<String> languagesToAdd;
    private List<String> languagesToRemove;

    
    private List<String> skillsToAdd;
    private List<String> skillsToRemove;
}