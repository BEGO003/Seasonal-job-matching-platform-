package grad_project.seasonal_job_matching;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication()
public class SeasonalJobMatchingApplication {

	public static void main(String[] args) {
		SpringApplication.run(SeasonalJobMatchingApplication.class, args);
	}

}
/*
1. Make Sure MVN is always clean before running docker compose 
2. JPA Interfaces  (repository functions findbyemail, or builtin functions) - DONE
3. DTOs for responses and requests - kinda Done?
4. Implement CRUD operations in service layers -DONE
5. Update Controllers to use new services - DONE
6. Commit and push latest stable version - DONE
7. add volume in docker compose
8. Add hashing for passwords and verification for email, number, etc
 */