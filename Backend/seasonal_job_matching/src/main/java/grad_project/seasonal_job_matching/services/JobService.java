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
        User user = userRepository.findById(dto.getJobposterID()).orElseThrow(() -> new RuntimeException("User not found"));

        // Fetch the User ID using user repo?  
        job.setjobposter(user);
        
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
        if (updatedJob.getNumofpositions() > 0 ) {
            existingjJob.setNumofpositions(updatedJob.getNumofpositions());
        }

        //update job type
        if (updatedJob.getType() != null) {
            existingjJob.setType(updatedJob.getType());
        }

        if (dto.getWorkarrangment() != null) {
            existingjJob.setWorkarrangement(dto.getWorkarrangment());
        }

        //cant edit userID, id of job
        Job savedjob = jobRepository.save(existingjJob);
        return jobMapper.maptoreturnJob(savedjob);

    }


    public void deleteJob(Long id){
        jobRepository.deleteById(id);
    }

}
