package grad_project.seasonal_job_matching.dto.responses;

import java.util.List;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import lombok.Data;
import grad_project.seasonal_job_matching.model.Job;
@Data
public class UserResponseDTO {

    private String name;

    private String country;

    @Pattern(regexp = "^[0-9]{11}$") 
    private String number;

    @Email
    private String email;

    private List<JobResponseDTO> ownjobList;

}
