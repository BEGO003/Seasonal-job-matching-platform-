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
        
        Job existingjJob = jobRepository.findById(id).orElseThrow(()-> new RuntimeException("Job not found with ID: " + id));
        //has new fields that are changed
        Job updatedJob = jobMapper.maptoEditJob(dto);

        //if field thats updated is title and new title isn't empty
        if(dto.getTitle() != null){
            existingjJob.setTitle(updatedJob.getTitle());
        }

        //update description
        if (updatedJob.getDescription() != null) {
            existingjJob.setDescription(updatedJob.getDescription());
        }

        //update work arrangement
        if (updatedJob.getWorkArrangement() != null) {
            existingjJob.setWorkArrangement(updatedJob.getWorkArrangement());
        }

        //add salary, checks if salary is updated
        if (updatedJob.getSalary() > 0) {
            existingjJob.setSalary(updatedJob.getSalary());
        }


        //update start date
        if (updatedJob.getStartDate() != null) {
            existingjJob.setStartDate(updatedJob.getStartDate());
        }

        //update end date
        if (updatedJob.getEndDate() != null) {
            existingjJob.setEndDate(updatedJob.getEndDate());
        }

        //update status
        if (updatedJob.getStatus() != null) {
            existingjJob.setStatus(updatedJob.getStatus());
        }

        //update salary
        if (updatedJob.getSalary() > 0) {
            existingjJob.setSalary(updatedJob.getSalary());
        }

        //update location
        if (updatedJob.getLocation() != null ) {
            existingjJob.setLocation(updatedJob.getLocation());
        }

        //update number of positions available
        if (updatedJob.getNumOfPositions() > 0 ) {
            existingjJob.setNumOfPositions(updatedJob.getNumOfPositions());
        }

        //update job type
        if (updatedJob.getType() != null) {
            existingjJob.setType(updatedJob.getType());
        }

        if (dto.getWorkArrangement() != null) {
            existingjJob.setWorkArrangement(dto.getWorkArrangement());
        }
        // Handle requirements - add/remove with deduplication
    if (dto.getRequirementsToAdd() != null || dto.getRequirementsToRemove() != null) {
        List<String> currentRequirements = existingjJob.getRequirements() != null 
            ? new ArrayList<>(existingjJob.getRequirements()) 
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
        
        existingjJob.setRequirements(currentRequirements);
    }

    // Handle categories - add/remove with deduplication
    if (dto.getCategoriesToAdd() != null || dto.getCategoriesToRemove() != null) {
        List<String> currentCategories = existingjJob.getCategories() != null 
            ? new ArrayList<>(existingjJob.getCategories()) 
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
        
        existingjJob.setCategories(currentCategories);
    }

    // Handle benefits - add/remove with deduplication
    if (dto.getBenefitsToAdd() != null || dto.getBenefitsToRemove() != null) {
        List<String> currentBenefits = existingjJob.getBenefits() != null 
            ? new ArrayList<>(existingjJob.getBenefits()) 
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
        
        existingjJob.setBenefits(currentBenefits);
    }

        //cant edit userID, id of job
        Job savedjob = jobRepository.save(existingjJob);
        return jobMapper.maptoreturnJob(savedjob);

    }


    public void deleteJob(Long id){
        jobRepository.deleteById(id);
    }

}
