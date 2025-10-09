package grad_project.seasonal_job_matching.controller;


import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import grad_project.seasonal_job_matching.dto.JobDTO;
import grad_project.seasonal_job_matching.dto.JobResponseDTO;
import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.services.JobService;
import jakarta.validation.Valid;


@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/job")
public class JobController {

    final private JobService job_service;

    public JobController(JobService job_service){
        this.job_service = job_service;
    }

    @GetMapping("/test")
    public String test(){
        return "Test";
    }

    @GetMapping("/all")
    public List<Job> findAll(){
        return job_service.findAllJobs();
    }

    @GetMapping("/{id}")
    public ResponseEntity<String> findByID(@PathVariable long id){
        if(job_service.findByID(id).isEmpty()){
            return ResponseEntity.ok("Job not found!");
        }else{
            return ResponseEntity.ok("Job found!");
        }
    }

    @PostMapping("/new")
    public JobResponseDTO createJob(@Valid @RequestBody JobDTO jobdto){//if user is from mobile than type is jobseeker, else it is employer  
        try {
            return job_service.createJob(jobdto);
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
             
    }

    @PostMapping("/edit/{id}")
    public ResponseEntity<String> editUser(@PathVariable long id,@Valid @RequestBody JobDTO dto){
        try {
            job_service.editJob(dto, id);
            return ResponseEntity.ok("Job updated successfully");
        } catch (RuntimeException e) {
            return ResponseEntity.ok("Job failed to update");
        }
    }


    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteJob(@PathVariable Long id){
        if (ResponseEntity.ok()==findByID(id)) {
            job_service.deleteJob(id);
            return ResponseEntity.ok("Job deleted successfully!");
        }else{
            return ResponseEntity.ok("Job not found!");
        }
        
    }
 
}
