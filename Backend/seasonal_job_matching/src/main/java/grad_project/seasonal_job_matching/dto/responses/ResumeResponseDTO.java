package grad_project.seasonal_job_matching.dto.responses;

import java.util.List;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class ResumeResponseDTO {

    private List<String> education;

    private List<String> experience;

    private List<String> certificates;

    @NotBlank
    private List<String> skills;

    private List<String> languages;
}