package grad_project.seasonal_job_matching.seasonal_job_matching.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import grad_project.seasonal_job_matching.seasonal_job_matching.repository.UserRepository;
import grad_project.seasonal_job_matching.seasonal_job_matching.model.JobSeeker;


@RestController
@RequestMapping("/api/user")
public class UserController {
    final private UserRepository repo;

    public UserController(UserRepository repository){
        this.repo = repository;
    }

    //empty because once usercontroller is called, it will automatically redirect to this function and get all jobseekers
    @GetMapping("")
    public List<JobSeeker> findAll(){
        return repo.findAllJobSeekers();
    }

    //CRUD methods here
}
