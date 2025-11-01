package grad_project.seasonal_job_matching.controller;

import grad_project.seasonal_job_matching.dto.requests.ApplicationCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.ApplicationStatusUpdateDTO;
import grad_project.seasonal_job_matching.dto.responses.ApplicationResponseDTO;
import grad_project.seasonal_job_matching.services.ApplicationService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/applications")
public class ApplicationController {

    private final ApplicationService applicationService;

    // Inject the service
    public ApplicationController(ApplicationService applicationService) {
        this.applicationService = applicationService;
    }

    /**
     * Creates a new application, linking a user to a job.
     * Since security is not yet implemented, we pass both IDs in the path.
     */
    @PostMapping("/user/{userId}/job/{jobId}")
    public ResponseEntity<?> createApplication(
            @PathVariable long userId,
            @PathVariable long jobId,
            @Valid @RequestBody ApplicationCreateDTO dto) {
        
        try {
            ApplicationResponseDTO application = applicationService.createApplication(dto, userId, jobId);
            return ResponseEntity.ok().body(Map.of(
                "message", "Application submitted successfully",
                "application", application
            ));
        } catch (RuntimeException e) {
            // Handle errors (e.g., User or Job not found)
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    /**
     * Gets all applications submitted by a specific user (Job Seeker view).
     */
    @GetMapping("/user/{userId}")
    public ResponseEntity<?> getApplicationsForUser(@PathVariable long userId) {
        try {
            List<ApplicationResponseDTO> applications = applicationService.getApplicationsForUser(userId);
            if (applications.isEmpty()) {
                // Return 200 OK with an empty list rather than an error
                return ResponseEntity.ok(applications);
            }
            return ResponseEntity.ok(applications);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PatchMapping("/{applicationId}/status/employer/{employerId}")
    public ResponseEntity<?> updateStatus(
            @PathVariable long applicationId,
            @PathVariable long employerId,
            @Valid @RequestBody ApplicationStatusUpdateDTO dto) {
        
        try {
            ApplicationResponseDTO updatedApplication = applicationService.updateApplicationStatus(applicationId, employerId, dto);
            return ResponseEntity.ok().body(Map.of(
                "message", "Application status updated successfully",
                "application", updatedApplication
            ));
        } catch (RuntimeException e) {
            // Catches both "Not Found" and "Authorization Failed" errors
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
    
    /**
     * Gets all applications submitted for a specific job (Employer view).
     */
    @GetMapping("/job/{jobId}")
    public ResponseEntity<?> getApplicationsForJob(@PathVariable long jobId) {
        try {
            List<ApplicationResponseDTO> applications = applicationService.getApplicationsForJob(jobId);
            if (applications.isEmpty()) {
                 // Return 200 OK with an empty list
                return ResponseEntity.ok(applications);
            }
            return ResponseEntity.ok(applications);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    /**
     * Deletes (withdraws) an application by its unique ID.
     */
    @DeleteMapping("/{applicationId}")
    public ResponseEntity<?> deleteApplication(@PathVariable long applicationId) {
        try {
            applicationService.deleteApplication(applicationId);
            return ResponseEntity.ok(Map.of("message", "Application deleted successfully."));
        } catch (RuntimeException e) {
            // Catches "Application not found" error from the service
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
}