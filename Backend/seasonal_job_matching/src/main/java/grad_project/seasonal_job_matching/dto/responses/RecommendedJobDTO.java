package grad_project.seasonal_job_matching.dto.responses;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class RecommendedJobDTO {
    private Long id;
    private String title;
    private String description;
    private Double score;
}