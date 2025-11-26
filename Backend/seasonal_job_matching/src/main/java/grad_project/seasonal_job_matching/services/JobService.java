package grad_project.seasonal_job_matching.services;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import grad_project.seasonal_job_matching.dto.requests.JobCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.JobEditDTO;
import grad_project.seasonal_job_matching.dto.responses.JobResponseDTO;
import grad_project.seasonal_job_matching.mapper.JobMapper;
import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.model.enums.JobStatus;
import grad_project.seasonal_job_matching.repository.JobRepository;
import grad_project.seasonal_job_matching.repository.UserRepository;
import jakarta.transaction.Transactional;

@Service
public class JobService {

    public final List<Job> users = new ArrayList<>();
    private final JobRepository jobRepository;
    private final UserRepository userRepository;


    @Autowired
    private JobMapper jobMapper;

    public JobService(JobRepository jobRepository, UserRepository userRepository){
        this.jobRepository = jobRepository;
        this.userRepository = userRepository;
    }
    public List<JobResponseDTO> findAllJobs(){
        return jobRepository.findAllByStatusNot(JobStatus.DRAFT)
        .stream()
        .map(jobMapper::maptoreturnJob)
        .collect(Collectors.toList());
    }

    public Optional<JobResponseDTO> findByID(long id){
        return jobRepository.findById(id)
        .map(jobMapper::maptoreturnJob);
    }

    @Transactional
    public JobResponseDTO createJob(JobCreateDTO dto) { //does it need any validation like unique user email?
        Job job = jobMapper.maptoAddJob(dto);
        User user = userRepository.findById(dto.getJobposterId()).orElseThrow(() -> new RuntimeException("User not found"));

        // Fetch the User Id using user repo?  
        job.setJobPoster(user);
        List<Job> ownedjobs = user.getOwnedJobs();
        ownedjobs.add(job);
        user.setOwnedJobs(ownedjobs);
        job.setCreatedAt(Date.valueOf(java.time.LocalDate.now()));
        return jobMapper.maptoreturnJob(jobRepository.save(job));

    }

    public JobResponseDTO editJob(JobEditDTO dto, long id){ 
        
        Job existingJob  = jobRepository.findById(id).orElseThrow(()-> new RuntimeException("Job not found with ID: " + id));
        //has new fields that are changed
        Job updatedJob = jobMapper.maptoEditJob(dto);

        //if field thats updated is title and new title isn't empty
        if(dto.getTitle() != null){
            existingJob .setTitle(updatedJob.getTitle());
        }

        //update description
        if (updatedJob.getDescription() != null) {
            existingJob .setDescription(updatedJob.getDescription());
        }

        //update work arrangement
        if (updatedJob.getWorkArrangement() != null) {
            existingJob .setWorkArrangement(updatedJob.getWorkArrangement());
        }

        //update start date
        if (updatedJob.getStartDate() != null) {
            existingJob .setStartDate(updatedJob.getStartDate());
        }


        //update status
        if (updatedJob.getStatus() != null) {
            existingJob .setStatus(updatedJob.getStatus());
        }

        //update duration
        if (updatedJob.getDuration() != null) {
            existingJob .setDuration(updatedJob.getDuration());
        }

        //update amount
        if (updatedJob.getAmount() > 0) {
            existingJob.setAmount(updatedJob.getAmount());
        }

        //update salary type
        if (updatedJob.getSalary() != null) {
            existingJob.setSalary(updatedJob.getSalary());
        }

        //update location
        if (updatedJob.getLocation() != null ) {
            existingJob .setLocation(updatedJob.getLocation());
        }

        //update number of positions available
        if (updatedJob.getNumOfPositions() > 0 ) {
            existingJob .setNumOfPositions(updatedJob.getNumOfPositions());
        }

        //update job type
        if (updatedJob.getType() != null) {
            existingJob .setType(updatedJob.getType());
        }

        if (dto.getWorkArrangement() != null) {
            existingJob .setWorkArrangement(dto.getWorkArrangement());
        }
        // Handle requirements - add/remove with deduplication
    if (dto.getRequirementsToAdd() != null || dto.getRequirementsToRemove() != null) {
        List<String> currentRequirements = existingJob .getRequirements() != null 
            ? new ArrayList<>(existingJob .getRequirements()) 
            : new ArrayList<>();
        
        // Remove items
        if (dto.getRequirementsToRemove() != null) {
            currentRequirements.removeAll(dto.getRequirementsToRemove());
        }
        
        // Add items (avoid duplicates)
        if (dto.getRequirementsToAdd() != null) {
            Set<String> uniqueSet = new HashSet<>(currentRequirements);
            for (String requirement : dto.getRequirementsToAdd()) {
                if (requirement != null && !requirement.trim().isEmpty() && !uniqueSet.contains(requirement)) {
                    currentRequirements.add(requirement);
                    uniqueSet.add(requirement);
                }
            }
        }
        
        existingJob .setRequirements(currentRequirements);
    }

    // Handle categories - add/remove with deduplication
    if (dto.getCategoriesToAdd() != null || dto.getCategoriesToRemove() != null) {
        List<String> currentCategories = existingJob .getCategories() != null 
            ? new ArrayList<>(existingJob .getCategories()) 
            : new ArrayList<>();
        
        // Remove items
        if (dto.getCategoriesToRemove() != null) {
            currentCategories.removeAll(dto.getCategoriesToRemove());
        }
        
        // Add items (avoid duplicates)
        if (dto.getCategoriesToAdd() != null) {
            Set<String> uniqueSet = new HashSet<>(currentCategories);
            for (String category : dto.getCategoriesToAdd()) {
                if (category != null && !category.trim().isEmpty() && !uniqueSet.contains(category)) {
                    currentCategories.add(category);
                    uniqueSet.add(category);
                }
            }
        }
        
        existingJob .setCategories(currentCategories);
    }

    // Handle benefits - add/remove with deduplication
    if (dto.getBenefitsToAdd() != null || dto.getBenefitsToRemove() != null) {
        List<String> currentBenefits = existingJob .getBenefits() != null 
            ? new ArrayList<>(existingJob .getBenefits()) 
            : new ArrayList<>();
        
        // Remove items
        if (dto.getBenefitsToRemove() != null) {
            currentBenefits.removeAll(dto.getBenefitsToRemove());
        }
        
        // Add items (avoid duplicates)
        if (dto.getBenefitsToAdd() != null) {
            Set<String> uniqueSet = new HashSet<>(currentBenefits);
            for (String benefit : dto.getBenefitsToAdd()) {
                if (benefit != null && !benefit.trim().isEmpty() && !uniqueSet.contains(benefit)) {
                    currentBenefits.add(benefit);
                    uniqueSet.add(benefit);
                }
            }
        }
        
        existingJob .setBenefits(currentBenefits);
    }

        //cant edit userID, id of job
        Job savedjob = jobRepository.save(existingJob );
        return jobMapper.maptoreturnJob(savedjob);

    }


    public void deleteJob(Long id){
        jobRepository.deleteById(id);
    }

}
