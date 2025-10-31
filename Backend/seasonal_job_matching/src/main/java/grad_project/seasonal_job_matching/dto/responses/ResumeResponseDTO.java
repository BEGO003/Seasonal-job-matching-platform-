package grad_project.seasonal_job_matching.dto.responses;

import java.util.List;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class ResumeResponseDTO {

    private String education;

    private String experience;

    private String certificates;

    @NotBlank
    private List<String> skills;
    
    private String languages;
}
