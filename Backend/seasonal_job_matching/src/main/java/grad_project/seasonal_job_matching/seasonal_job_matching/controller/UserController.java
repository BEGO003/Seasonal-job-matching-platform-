package grad_project.seasonal_job_matching.seasonal_job_matching.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import grad_project.seasonal_job_matching.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.seasonal_job_matching.services.UserService;


@RestController
@RequestMapping("/api/user")
public class UserController {
    final private UserService users_service;

    public UserController(UserService repository){
        this.users_service = repository;
    }

    //empty because once usercontroller is called, it will automatically redirect to this function and get all jobseekers
    @GetMapping("")
    public List<User> findAll(){
        return users_service.findAllUsers();
    }
    

    @GetMapping("/{email}")
    public Optional<User> findByEmail(String email){
        return users_service.findUserbyEmail(email);
    }

    @PostMapping("")
    public void createUser(User user){//if user is from mobile than type is jobseeker, else it is employer
        users_service.createUser(user);
    }

    //CRUD methods here, add 4 updates one for each field of jobseeker
}
