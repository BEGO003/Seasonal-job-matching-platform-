package grad_project.seasonal_job_matching.seasonal_job_matching.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Repository;

import grad_project.seasonal_job_matching.seasonal_job_matching.model.Type;
import grad_project.seasonal_job_matching.seasonal_job_matching.model.User;
import jakarta.annotation.PostConstruct;

@Repository
public class UserService {

    public final List<User> users = new ArrayList<>();

    public UserService(){

    }
    public List<User> findAllUsers(){
        return users;
    }

    //Optional is when a return might or might not return a null value
    public Optional<User> findUserbyEmail(String email){
        return users.stream().filter(user -> user.getEmail().equals(email)).findFirst();
    }

    //means we do this method after dependency injection 
    @PostConstruct
    public void init(){
        User seeker = new User("Baher", "Egypt", "0122234344", "test@gmail.com", "1234", Type.JOB_SEEKER);
        users.add(seeker);
    }
    public void createUser(User user) {
        users.add(user);
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'createUser'");
    }

}
