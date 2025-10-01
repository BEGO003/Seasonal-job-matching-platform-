package grad_project.seasonal_job_matching.seasonal_job_matching.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Repository;

import grad_project.seasonal_job_matching.seasonal_job_matching.model.JobSeeker;
import jakarta.annotation.PostConstruct;

@Repository
public class UserRepository {

    public final List<JobSeeker> jobSeekers = new ArrayList<>();

    public UserRepository(){

    }
    public List<JobSeeker> findAllJobSeekers(){
        return jobSeekers;
    }

    //Optional is when a return might or might not return a null value
    public Optional<JobSeeker> findJobSeekerbyEmail(String email){
        return jobSeekers.stream().filter(jobseeker -> jobseeker.getEmail().equals(email)).findFirst();
    }

    //means we do this method after dependency injection 
    @PostConstruct
    public void init(){
        JobSeeker seeker = new JobSeeker("Baher", "Egypt", "0122234344", "test@gmail.com", "1234");
        jobSeekers.add(seeker);
    }

}
