package grad_project.seasonal_job_matching.controller;


import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import grad_project.seasonal_job_matching.dto.requests.JobCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.JobEditDTO;
import grad_project.seasonal_job_matching.dto.responses.JobResponseDTO;
import grad_project.seasonal_job_matching.model.enums.JobType;
import grad_project.seasonal_job_matching.model.enums.Salary;
import grad_project.seasonal_job_matching.model.enums.WorkArrangement;
import grad_project.seasonal_job_matching.security.CurrentUserService;
import grad_project.seasonal_job_matching.services.JobService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;


@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/jobs")
public class JobController {

    final private JobService job_service;
    final private CurrentUserService currentUserService;

    public JobController(JobService job_service, CurrentUserService currentUserService){
        this.job_service = job_service;
        this.currentUserService = currentUserService;
    }


    @GetMapping
    public Page<JobResponseDTO> findAll(@RequestParam(defaultValue = "0") int page){
        //return job_service.findAllJobs(); old method that gets all jobs
        return job_service.getJobsPaged(page);
    }

    //MAYBE USE SLICE INSTEAD OF PAGE TO MAKE IT FASTER
    @GetMapping("/search")
    public Page<JobResponseDTO> findJobsFromSearch(@RequestParam(defaultValue = "0") int page, @RequestParam(required = false) String title){
        return job_service.getSearchedJobs(page, title);
    }

    @GetMapping("/filter")
    public ResponseEntity<Page<JobResponseDTO>> filterJobs(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(required = false) List<WorkArrangement> arrangements,
            @RequestParam(required = false) List<JobType> jobTypes,
            @RequestParam(required = false) List<Salary> salaryTypes,
            @RequestParam(required = false) String location,
            @RequestParam(required = false) String title) {
        
        Page<JobResponseDTO> jobs = job_service.getJobsWithAdvancedFilters(
            page, arrangements, jobTypes, salaryTypes, location, title
        );
        return ResponseEntity.ok(jobs);
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
    public ResponseEntity<?> createJob(@Valid @RequestBody JobCreateDTO jobdto, HttpServletRequest request){//if user is from mobile than type is jobseeker, else it is employer  
        Long currentUserId = currentUserService.getCurrentUserId(request);
        if (currentUserId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        if (currentUserId != jobdto.getJobposterId()) return ResponseEntity.status(HttpStatus.FORBIDDEN).build();

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
    public ResponseEntity<?> editJob(@PathVariable long id, @Valid @RequestBody JobEditDTO dto, HttpServletRequest request) {
        Long currentUserId = currentUserService.getCurrentUserId(request);
        if (currentUserId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        Optional<JobResponseDTO> jobDetails = job_service.findByID(id);
        if (jobDetails.isEmpty()) return ResponseEntity.notFound().build();
        if (currentUserId != jobDetails.get().getJobposterId()) return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
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
    public ResponseEntity<String> deleteJob(@PathVariable Long id, HttpServletRequest request) {
        Long currentUserId = currentUserService.getCurrentUserId(request);
        if (currentUserId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        Optional<JobResponseDTO> jobDetails = job_service.findByID(id);
        if (jobDetails.isEmpty()) return ResponseEntity.notFound().build();
        if (currentUserId != jobDetails.get().getJobposterId()) return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        job_service.deleteJob(id);
        return ResponseEntity.ok("Job deleted successfully!");
    }
 
}
