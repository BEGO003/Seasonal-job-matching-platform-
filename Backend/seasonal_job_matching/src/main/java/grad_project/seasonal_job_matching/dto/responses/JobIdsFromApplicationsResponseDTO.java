package grad_project.seasonal_job_matching.dto.responses;

import java.util.List;

import lombok.Data;

@Data
public class JobIdsFromApplicationsResponseDTO {
    private List<Long> jobIds;
}
