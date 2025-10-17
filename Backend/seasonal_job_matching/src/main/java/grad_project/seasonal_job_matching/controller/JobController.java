package grad_project.seasonal_job_matching.controller;


import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import grad_project.seasonal_job_matching.dto.requests.JobCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.JobEditDTO;
import grad_project.seasonal_job_matching.dto.responses.JobResponseDTO;
import grad_project.seasonal_job_matching.services.JobService;
import jakarta.validation.Valid;


@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/jobs")
public class JobController {

    final private JobService job_service;

    public JobController(JobService job_service){
        this.job_service = job_service;
    }


    @GetMapping
    public List<JobResponseDTO> findAll(){
        return job_service.findAllJobs();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findByID(@PathVariable long id){
        Optional<JobResponseDTO> job = job_service.findByID(id);
        if(job.isEmpty()){
            return ResponseEntity.ok("Job not found!");
        }else{
            return ResponseEntity.ok(job.get());
        }

    }

    @PostMapping("")
    public ResponseEntity<?> createJob(@Valid @RequestBody JobCreateDTO jobdto){//if user is from mobile than type is jobseeker, else it is employer  
        try {
            JobResponseDTO job = job_service.createJob(jobdto);
            return ResponseEntity.ok()
            .body(Map.of(
                "message", "Job created successfully",
                "job", job
            )); 
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest()
            .body(Map.of("error", e.getMessage()));
        }
    }
             

    @PatchMapping("/{id}")
    public ResponseEntity<?> editUser(@PathVariable long id,@Valid @RequestBody JobEditDTO dto){
        try {
            JobResponseDTO job = job_service.editJob(dto, id);
            return ResponseEntity.ok()
            .body(Map.of(
                "message", "Job edited successfully",
                "job", job
            )); 
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest()
            .body(Map.of("error", e.getMessage()));
        }
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteJob(@PathVariable Long id){
        if ("Job found!".equals(findByID(id).getBody())) {
            job_service.deleteJob(id);
            return ResponseEntity.ok("Job deleted successfully!");
        }else{
            return ResponseEntity.ok("Job not found!");
        }
        
    }
 
}
