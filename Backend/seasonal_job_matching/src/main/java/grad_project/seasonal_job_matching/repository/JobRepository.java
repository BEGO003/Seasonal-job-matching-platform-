package grad_project.seasonal_job_matching.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.model.enums.JobStatus;

public interface JobRepository extends JpaRepository<Job, Long> {
    
    List<Job> findAllByStatusNot(JobStatus status);
}
