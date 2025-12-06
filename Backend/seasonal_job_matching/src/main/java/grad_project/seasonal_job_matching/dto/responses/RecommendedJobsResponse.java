package grad_project.seasonal_job_matching.dto.responses;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class RecommendedJobsResponse {
    private Long user_id;
    private List<RecommendedJobDTO> recommendations;
}