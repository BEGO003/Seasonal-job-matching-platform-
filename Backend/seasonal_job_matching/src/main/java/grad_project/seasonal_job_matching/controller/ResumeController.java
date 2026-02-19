package grad_project.seasonal_job_matching.controller;

import java.util.Map;
import java.util.Optional;

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
import org.springframework.web.bind.annotation.RestController;
import grad_project.seasonal_job_matching.services.ResumeService;
import grad_project.seasonal_job_matching.dto.responses.ResumeResponseDTO;
import grad_project.seasonal_job_matching.security.CurrentUserService;
import grad_project.seasonal_job_matching.dto.requests.ResumeCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.ResumeEditDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/resumes")
public class ResumeController {

    final private ResumeService resume_service;
    final private CurrentUserService currentUserService;

    public ResumeController(ResumeService resume_service, CurrentUserService currentUserService){
        this.resume_service = resume_service;
        this.currentUserService = currentUserService;
        
    }

    // @GetMapping
    // public List<JobResponseDTO> findAll(){
    //     return job_service.findAllJobs();
    // }

    @GetMapping("/{id}")//using user ID, if has no resume returns 500, could add try catch to avoid this
    public ResponseEntity<?> findByID(@PathVariable long id, HttpServletRequest request){
        Long currentUserId = currentUserService.getCurrentUserId(request);
        if (currentUserId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        if (currentUserId != id) return ResponseEntity.status(HttpStatus.FORBIDDEN).build();

        Optional<ResumeResponseDTO> resume = resume_service.findResumeByUserId(id);
        if(resume.isEmpty()){
            return ResponseEntity.ok("Resume not found!");
        }else{
            return ResponseEntity.ok(resume.get());
        }

    }

    @PostMapping("/{userId}")
    public ResponseEntity<?> createResume(@Valid @RequestBody ResumeCreateDTO dto, @PathVariable long userId, HttpServletRequest request){//if user is from mobile than type is jobseeker, else it is employer  
        Long currentUserId = currentUserService.getCurrentUserId(request);
        if (currentUserId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        if (currentUserId != userId) return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
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
    public ResponseEntity<?> editResume(@PathVariable long userId,@Valid @RequestBody ResumeEditDTO dto, HttpServletRequest request){
        Long currentUserId = currentUserService.getCurrentUserId(request);
        if (currentUserId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        if (currentUserId != userId) return ResponseEntity.status(HttpStatus.FORBIDDEN).build();

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
    public ResponseEntity<String> deleteResume(@PathVariable Long userId, HttpServletRequest request){
        Long currentUserId = currentUserService.getCurrentUserId(request);
        if (currentUserId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        if (currentUserId != userId) return ResponseEntity.status(HttpStatus.FORBIDDEN).build();

        if (resume_service.findResumeByUserId(userId).isPresent()) { 
        resume_service.deleteResume(userId);
        return ResponseEntity.ok("Resume deleted successfully!");
        } else {
            return ResponseEntity.ok("Resume not found!");
        }
    }

}