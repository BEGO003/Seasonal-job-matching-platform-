// package grad_project.seasonal_job_matching.services;

// public class ApplicationService {

// }
package grad_project.seasonal_job_matching.services;

import grad_project.seasonal_job_matching.dto.requests.ApplicationCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.ApplicationStatusUpdateDTO;
import grad_project.seasonal_job_matching.dto.responses.ApplicationResponseDTO;
import grad_project.seasonal_job_matching.mapper.ApplicationMapper;
import grad_project.seasonal_job_matching.model.Application;
import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.model.enums.ApplicationStatus;
import grad_project.seasonal_job_matching.repository.ApplicationRepository;
import grad_project.seasonal_job_matching.repository.JobRepository;
import grad_project.seasonal_job_matching.repository.UserRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ApplicationService {

    private final ApplicationRepository applicationRepository;
    private final UserRepository userRepository;
    private final JobRepository jobRepository;
    private final ApplicationMapper applicationMapper;

    // Constructor to inject all dependencies
    public ApplicationService(ApplicationRepository applicationRepository,
                              UserRepository userRepository,
                              JobRepository jobRepository,
                              ApplicationMapper applicationMapper) {
        this.applicationRepository = applicationRepository;
        this.userRepository = userRepository;
        this.jobRepository = jobRepository;
        this.applicationMapper = applicationMapper;
    }

    /**
     * Creates a new application.
     * This method links the application to both the User and the Job.
     */
    @Transactional
    public ApplicationResponseDTO createApplication(ApplicationCreateDTO dto, long userId, long jobId) {
        
        // 1. Find the parent User and Job entities
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));
        
        Job job = jobRepository.findById(jobId)
                .orElseThrow(() -> new RuntimeException("Job not found with ID: " + jobId));

        // 2. Map the DTO to the Application entity
        Application application = applicationMapper.maptoAddApplication(dto);

        // 3. Set the relationships and business logic fields
        application.setUser(user);
        application.setJob(job);
        application.setApplicationStatus(ApplicationStatus.PENDING); // Set default status
        application.setCreatedAt(new Date(System.currentTimeMillis())); // Set current date

        // 4. Save the new application
        // Because Application is the "owning" side of the relationship (with @JoinColumn),
        // saving it is what creates the foreign key links in the database.
        Application savedApplication = applicationRepository.save(application);

        // 5. Return the DTO
        return applicationMapper.maptoreturnApplication(savedApplication);
    }

    /**
     * Gets all applications that a specific user has submitted.
     */
    @Transactional(readOnly = true)
    public List<ApplicationResponseDTO> getApplicationsForUser(long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));
        
        // Use the 'ownedApplications' list from the User entity
        List<Application> applications = applicationRepository.findByUserId(userId);

        // Map the list of entities to a list of DTOs
        return applications.stream()
                .map(applicationMapper::maptoreturnApplication)
                .collect(Collectors.toList());
    }

    /**
     * Gets all applications that have been submitted for a specific job.
     */
    @Transactional(readOnly = true)
    public List<ApplicationResponseDTO> getApplicationsForJob(long jobId) {
        Job job = jobRepository.findById(jobId)
                .orElseThrow(() -> new RuntimeException("Job not found with ID: " + jobId));

        // Use the 'listofJobApplications' list from the Job entity
        List<Application> applications = job.getListofJobApplications();

        // Map the list of entities to a list of DTOs
        return applications.stream()
                .map(applicationMapper::maptoreturnApplication)
                .collect(Collectors.toList());
    }

    /**
     * Deletes an application by its ID.
     * This will automatically remove it from the User's and Job's lists 
     * on the next database read because the record is gone.
     */
    @Transactional
    public void deleteApplication(long applicationId) {
        if (!applicationRepository.existsById(applicationId)) {
            throw new RuntimeException("Application not found with ID: " + applicationId);
        }
        
        // Deleting the application record is enough.
        // The @OneToMany lists in User and Job are managed by Hibernate 
        // and will no longer include this application after it's deleted.
        applicationRepository.deleteById(applicationId);
    }
    @Transactional
    public ApplicationResponseDTO updateApplicationStatus(long applicationId, long requestingUserId, ApplicationStatusUpdateDTO dto) {
        
        Application application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new RuntimeException("Application not found with ID: " + applicationId));

        Job job = application.getJob();

        long jobPosterId = job.getJobPoster().getId();

        // Compare the ID of the person making the request (requestingUserId) 
        // with the ID of the person who owns the job (jobPosterId).
        if (requestingUserId != jobPosterId) {
            throw new RuntimeException("Authorization Failed: You are not the owner of this job and cannot update its applications.");
        }

        // 5. Authorization Passed: Update the status
        application.setApplicationStatus(dto.getStatus());
        
        // 6. Save the updated application
        Application savedApplication = applicationRepository.save(application);

        // 7. Map and return the updated DTO
        return applicationMapper.maptoreturnApplication(savedApplication);
    }
}