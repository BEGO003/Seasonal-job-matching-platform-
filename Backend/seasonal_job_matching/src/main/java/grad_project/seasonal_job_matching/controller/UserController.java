package grad_project.seasonal_job_matching.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import grad_project.seasonal_job_matching.dto.createuserDTO;
import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.services.UserService;




@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/user")
public class UserController {
    final private UserService users_service;

    public UserController(UserService service){
        this.users_service = service;
    }

    //empty because once usercontroller is called, it will automatically redirect to this function and get all jobseekers
    
    @GetMapping("")
    public List<User> findAll(){
        return users_service.findAllUsers();
    }
    

    @GetMapping("/{email}")
    public Optional<User> findByEmail(@PathVariable String email){
        return users_service.findUserbyEmail(email);
    }

    
    @PostMapping("")
    public void createUser(@RequestBody createuserDTO userdto){//if user is from mobile than type is jobseeker, else it is employer
        
        users_service.createUser(userdto);


    }


    //CRUD methods here, add 4 updates one for each field of jobseeker
}
