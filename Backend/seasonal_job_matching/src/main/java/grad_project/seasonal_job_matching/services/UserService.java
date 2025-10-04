package grad_project.seasonal_job_matching.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import grad_project.seasonal_job_matching.dto.createuserDTO;
import grad_project.seasonal_job_matching.model.Type;
import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.repository.UserRepository;
import jakarta.annotation.PostConstruct;

@Service
public class UserService {

    public final List<User> users = new ArrayList<>();
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository){
        this.userRepository = userRepository;

    }
    public List<User> findAllUsers(){
        return userRepository.findAll();
    }

    //Optional is when a return might or might not return a null value
    public Optional<User> findUserbyEmail(String email){
        return users.stream().filter(user -> user.getEmail().equals(email)).findFirst();
    }

    //means we do this method after dependency injection 
    @PostConstruct
    public void init(){
        User seeker = new User("Baher", "Egypt", "0122234344", "test@gmail.com", "1234", Type.JOB_SEEKER);
        //return user dto
        userRepository.save(seeker);
    }
    
    public void createUser(createuserDTO dto) {
        User user = User.fromDTO(dto);
        userRepository.save(user);
    }

}
