package grad_project.seasonal_job_matching.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import grad_project.seasonal_job_matching.dto.JobDTO;
import grad_project.seasonal_job_matching.mapper.CustomMapper;
import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.repository.JobRepository;

@Service
public class JobService {

    public final List<Job> users = new ArrayList<>();
    private final JobRepository jobRepository;

    @Autowired
    private CustomMapper jobMapper;

    public JobService(JobRepository jobRepository){
        this.jobRepository = jobRepository;

    }
    public List<Job> findAllJobs(){
        return jobRepository.findAll();
    }

    public Optional<Job> findByID(long id){
        return jobRepository.findById(id);
    }

    public void createJob(JobDTO dto) { //does it need any validation like unique user email?
        Job job = jobMapper.maptoAddJob(dto);
        jobRepository.save(job);
    }

    public void editUser(JobDTO dto, long id){ //STILL NEEDS TO BE DONE
        
    }


    public void deleteUser(Long id){
        jobRepository.deleteById(id);
    }

}
