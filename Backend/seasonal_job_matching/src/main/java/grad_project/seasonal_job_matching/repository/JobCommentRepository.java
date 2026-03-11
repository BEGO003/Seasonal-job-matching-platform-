package grad_project.seasonal_job_matching.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import grad_project.seasonal_job_matching.model.JobComment;

@Repository
public interface JobCommentRepository extends JpaRepository<JobComment, Long> {

    List<JobComment> findByJobIdAndParentCommentIsNullOrderByCreatedAtDesc(Long jobId);
}
