package grad_project.seasonal_job_matching.dto.requests;

import java.util.List;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UserEditDTO {

    private String name;

    private String country;

    @Pattern(regexp = "^[0-9]{11}$") 
    private String number;

    @Email
    private String email;

    @Size(min = 8, max = 100)
    private String password;

     // Fields of Interest - add/remove pattern
     private List<String> fieldsOfInterestToAdd;
     private List<String> fieldsOfInterestToRemove;
 
}
