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
3. DTOs for responses and requests - Done requests, responses to return maybe edited data?
7. add volume in docker compose
8. Add hashing for passwords and verification for email, number, etc
9. security when data entered in url that can be edited to access unauthorized data.
 */