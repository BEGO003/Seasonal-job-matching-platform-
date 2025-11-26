package grad_project.seasonal_job_matching.dto.requests;

import java.util.List;

import lombok.Data;

@Data
public class ResumeCreateDTO {

    private List<String> education;

    private List<String> experience;

    private List<String> certificates;

    private List<String> skills;

    private List<String> languages;

}