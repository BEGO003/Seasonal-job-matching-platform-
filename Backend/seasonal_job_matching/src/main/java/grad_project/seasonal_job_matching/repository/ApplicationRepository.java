package grad_project.seasonal_job_matching.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import grad_project.seasonal_job_matching.model.Application;

public interface ApplicationRepository extends JpaRepository <Application, Long> {

    @Query("SELECT a FROM Application a JOIN FETCH a.job WHERE a.user.id = :userId")
    List<Application> findByUserId(@Param("userId") long userId);

}
