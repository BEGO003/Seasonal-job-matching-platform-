package grad_project.seasonal_job_matching.dto.requests;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

//can make responsedto if we want to return data to frontend
@Data
public class UserCreateDTO {

    private long id;

    private String name;

    private String country;

    @Pattern(regexp = "^[0-9]{11}$") 
    private String number;

    @Email
    private String email;

    @Size(min = 8, max = 100)
    private String password;

}
