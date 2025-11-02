package grad_project.seasonal_job_matching.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import grad_project.seasonal_job_matching.model.User;

public interface UserRepository extends JpaRepository<User, Long>{

    //can use @Query to write the query and specific implementation, simple functions are automatically handled by JPArepository
    public boolean existsByEmail(String email);

    Optional<User> findByEmail(String email);
}