package grad_project.seasonal_job_matching.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import grad_project.seasonal_job_matching.dto.requests.JobCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.JobEditDTO;
import grad_project.seasonal_job_matching.dto.responses.JobResponseDTO;
import grad_project.seasonal_job_matching.mapper.JobMapper;
import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.model.User;
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
        return jobRepository.findAll()
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
        job.setjobposter(user);
        List<Job> ownedjobs = user.getOwnedjobs();
        ownedjobs.add(job);
        user.setOwnedjobs(ownedjobs);
        return jobMapper.maptoreturnJob(jobRepository.save(job));

    }

    public JobResponseDTO editJob(JobEditDTO dto, long id){ 
        
        Job existingJob = jobRepository.findById(id).orElseThrow(()-> new RuntimeException("Job not found with ID: " + id));
        //has new fields that are changed
        Job updatedJob = jobMapper.maptoEditJob(dto);

        //if field thats updated is title and new title isn't empty
        if(dto.getTitle() != null){
            existingJob.setTitle(updatedJob.getTitle());
        }

        //update description
        if (updatedJob.getDescription() != null) {
            existingJob.setDescription(updatedJob.getDescription());
        }

        //update work arrangement
        if (updatedJob.getWorkarrangement() != null) {
            existingJob.setWorkarrangement(updatedJob.getWorkarrangement());
        }

        //add salary, checks if salary is updated
        if (updatedJob.getSalary() > 0) {
            existingJob.setSalary(updatedJob.getSalary());
        }


        //update start date
        if (updatedJob.getStartDate() != null) {
            existingJob.setStartDate(updatedJob.getStartDate());
        }

        //update end date
        if (updatedJob.getEndDate() != null) {
            existingJob.setEndDate(updatedJob.getEndDate());
        }

        //update status
        if (updatedJob.getStatus() != null) {
            existingJob.setStatus(updatedJob.getStatus());
        }

        //update salary
        if (updatedJob.getSalary() > 0) {
            existingJob.setSalary(updatedJob.getSalary());
        }

        //update location
        if (updatedJob.getLocation() != null ) {
            existingJob.setLocation(updatedJob.getLocation());
        }

        //update number of positions available
        if (updatedJob.getNumofpositions() > 0 ) {
            existingJob.setNumofpositions(updatedJob.getNumofpositions());
        }

        //update job type
        if (updatedJob.getType() != null) {
            existingJob.setType(updatedJob.getType());
        }

        if (dto.getWorkarrangement() != null) {
            existingJob.setWorkarrangement(dto.getWorkarrangement());
        }

        //cant edit userID, id of job
        Job savedjob = jobRepository.save(existingJob);
        return jobMapper.maptoreturnJob(savedjob);

    }


    public void deleteJob(Long id){
        jobRepository.deleteById(id);
    }

}
