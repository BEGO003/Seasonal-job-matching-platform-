package grad_project.seasonal_job_matching.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import grad_project.seasonal_job_matching.dto.JobDTO;
import grad_project.seasonal_job_matching.dto.JobResponseDTO;
import grad_project.seasonal_job_matching.mapper.CustomMapper;
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
    private CustomMapper jobMapper;

    public JobService(JobRepository jobRepository, UserRepository userRepository){
        this.jobRepository = jobRepository;
        this.userRepository = userRepository;
    }
    public List<Job> findAllJobs(){
        return jobRepository.findAll();
    }

    public Optional<Job> findByID(long id){
        return jobRepository.findById(id);
    }

    @Transactional
    public JobResponseDTO createJob(JobDTO dto) { //does it need any validation like unique user email?
        Job job = jobMapper.maptoAddJob(dto);
        User user = userRepository.findById(dto.getjobposterID()).orElseThrow(() -> new RuntimeException("User not found"));

        // Fetch the User ID using user repo?  
        job.setjobposter(user);
        
        return jobMapper.maptoreturnJob(jobRepository.save(job));

        
    }

    public void editJob(JobDTO dto, long id){ 
        
        Job existingjJob = jobRepository.findById(id).orElseThrow(()-> new RuntimeException("Job not found with ID: " + id));

        //has new fields that are changed
        Job updatedJob = jobMapper.maptoEditJob(dto);

        //if field thats updated is title and new title isn't empty
        if(dto.getTitle() != null && !dto.getTitle().trim().isEmpty()){
            existingjJob.setTitle(updatedJob.getTitle());
        }

        //using dto or updated job should be the same but I still didn't test
        //update description
        if (updatedJob.getDescription() != null && !updatedJob.getDescription().trim().isEmpty()) {
            existingjJob.setDescription(updatedJob.getDescription());
        }

        //add salary, checks if salary is updated
        if (updatedJob.getSalary() != existingjJob.getSalary()) {
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

        //update location
        if (updatedJob.getLocation() != null && !updatedJob.getLocation().trim().isEmpty()) {
            existingjJob.setLocation(updatedJob.getLocation());
        }

        //update number of positions available
        if (updatedJob.getNumofpositions() != 0 ) {
            existingjJob.setNumofpositions(updatedJob.getNumofpositions());
        }

        //update job type
        if (updatedJob.getType() != existingjJob.getType()) {
            existingjJob.setType(updatedJob.getType());
        }

        //cant edit userID, id of job
        jobRepository.save(existingjJob);

    }


    public void deleteJob(Long id){
        jobRepository.deleteById(id);
    }

}
