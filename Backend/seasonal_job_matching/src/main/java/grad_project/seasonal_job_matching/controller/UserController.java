package grad_project.seasonal_job_matching.controller;

import java.util.List;
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

import grad_project.seasonal_job_matching.dto.requests.UserCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.UserEditDTO;
import grad_project.seasonal_job_matching.dto.requests.UserLoginDTO;
import grad_project.seasonal_job_matching.dto.responses.JobResponseDTO;
import grad_project.seasonal_job_matching.dto.responses.UserFieldsOfInterestResponseDTO;
import grad_project.seasonal_job_matching.dto.responses.UserResponseDTO;
import grad_project.seasonal_job_matching.services.ApplicationService;
import grad_project.seasonal_job_matching.services.UserService;
import jakarta.validation.Valid;


@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/users")
public class UserController {
    final private UserService users_service;
    final private ApplicationService application_service;

    public UserController(UserService service, ApplicationService application_service){
        this.users_service = service;
        this.application_service = application_service;
    }

    
    @GetMapping
    public List<UserResponseDTO> findAll(){
        return users_service.findAllUsers();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findByID(@PathVariable long id){
        Optional<UserResponseDTO> user = users_service.findByID(id);
        if(user.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(user.get());

    }

    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@Valid @RequestBody UserLoginDTO dto) {
        try {
            UserResponseDTO user = users_service.loginUser(dto);
            // Authentication successful
            return ResponseEntity.ok().body(Map.of(
                "message", "Login successful",
                "user", user
            ));
        } catch (RuntimeException e) {
            // Authentication failed (from service)
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                                 .body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/{id}/jobs")
    public List<JobResponseDTO> findUserJobs(@PathVariable long id) {
        return users_service.findUserJobs(id);
    }

    @GetMapping("/{userId}/applied/{jobId}")
    public ResponseEntity<?> hasUserAppliedToJob(
            @PathVariable long userId, 
            @PathVariable long jobId) {
        try {
            boolean hasApplied = application_service.hasUserAppliedToJob(userId, jobId);
            return ResponseEntity.ok(Map.of("hasApplied", hasApplied));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }


    @GetMapping("/FOI/{userId}")
    public ResponseEntity<?> getFieldsOfInterest(@PathVariable long userId) {
        try {
            UserFieldsOfInterestResponseDTO foi = users_service.getFieldsOfInterest(userId);
            if (foi.getFieldsOfInterest() == null || foi.getFieldsOfInterest().isEmpty()) {
                // Return 200 OK with an empty list rather than an error
                return ResponseEntity.ok(foi);
            }
            return ResponseEntity.ok(foi);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
    
    
    @PostMapping
    public ResponseEntity<?> createUser(@Valid @RequestBody UserCreateDTO userdto){//if user is from mobile than type is jobseeker, else it is employer  
        try {
            UserResponseDTO user = users_service.createUser(userdto);
            return ResponseEntity.ok()
            .body(Map.of(
                "message", "User created successfully",
                "user", user
            ));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest()
            .body(Map.of("error", e.getMessage()));
        }
    }
        
        
    
    @PatchMapping("/{id}")
    public ResponseEntity<?> editUser(@PathVariable long id,@Valid @RequestBody UserEditDTO dto){
        try {
            UserResponseDTO user = users_service.editUser(dto, id);
            return ResponseEntity.ok().body(Map.of(
                "message", "User edited successfully",
                "user", user
            ));
        } catch (RuntimeException e) {
            return ResponseEntity.ok("Update failed");
        }
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteUser(@PathVariable Long id){
        Optional<UserResponseDTO> user = users_service.findByID(id);
        if (user.isPresent()) {
            users_service.deleteUser(id);
            return ResponseEntity.ok("User deleted successfully!");
        }
        return ResponseEntity.notFound().build();
    }

}
