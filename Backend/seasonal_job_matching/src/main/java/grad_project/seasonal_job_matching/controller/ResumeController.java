package grad_project.seasonal_job_matching.controller;

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
import grad_project.seasonal_job_matching.services.ResumeService;
import grad_project.seasonal_job_matching.dto.responses.ResumeResponseDTO;
import grad_project.seasonal_job_matching.dto.requests.ResumeCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.ResumeEditDTO;

import jakarta.validation.Valid;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/resumes")
public class ResumeController {

    final private ResumeService resume_service;
    //final private UserService user_service; will add once sessions are created

    public ResumeController(ResumeService resume_service){
        this.resume_service = resume_service;
        //this.user_service = user_service;
    }

    // @GetMapping
    // public List<JobResponseDTO> findAll(){
    //     return job_service.findAllJobs();
    // }

    @GetMapping("/{id}")//using user ID, if has no resume returns 500, could add try catch to avoid this
    public ResponseEntity<?> findByID(@PathVariable long id){
        Optional<ResumeResponseDTO> resume = resume_service.findResumeByUserId(id);
        if(resume.isEmpty()){
            return ResponseEntity.ok("Resume not found!");
        }else{
            return ResponseEntity.ok(resume.get());
        }

    }

    @PostMapping("/{userId}")
    public ResponseEntity<?> createResume(@Valid @RequestBody ResumeCreateDTO dto, @PathVariable long userId){//if user is from mobile than type is jobseeker, else it is employer  
        try {
            ResumeResponseDTO resume = resume_service.createResume(dto,userId);
            return ResponseEntity.ok()
            .body(Map.of(
                "message", "Resume created successfully",
                "resume", resume
            )); 
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest()
            .body(Map.of("error", e.getMessage()));
        }
    }


    @PatchMapping("/{userId}")
    public ResponseEntity<?> editResume(@PathVariable long userId,@Valid @RequestBody ResumeEditDTO dto){
        try {
            ResumeResponseDTO resume = resume_service.editResume(dto, userId);
            return ResponseEntity.ok()
            .body(Map.of(
                "message", "Job edited successfully",
                "resume", resume
            )); 
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest()
            .body(Map.of("error", e.getMessage()));
        }
    }


    @DeleteMapping("/{userId}")
    public ResponseEntity<String> deleteResume(@PathVariable Long userId){
        // if ("Resume found!".equals(findByID(userId).getBody())) {
        //     resume_service.deleteResume(userId);
        //     return ResponseEntity.ok("Resume deleted successfully!");
        // }else{
        //     return ResponseEntity.ok("Resume not found!");
        // }
        if (resume_service.findResumeByUserId(userId).isPresent()) { 
        resume_service.deleteResume(userId);
        return ResponseEntity.ok("Resume deleted successfully!");
        } else {
            return ResponseEntity.ok("Resume not found!");
        }
    }

}