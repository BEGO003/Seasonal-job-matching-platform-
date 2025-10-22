package grad_project.seasonal_job_matching.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import grad_project.seasonal_job_matching.dto.requests.JobCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.JobEditDTO;
import grad_project.seasonal_job_matching.dto.responses.JobResponseDTO;
import grad_project.seasonal_job_matching.model.Job;

@Mapper(componentModel = "spring")
public interface JobMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "jobposter", ignore = true)
    Job maptoAddJob(JobCreateDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "jobposter", ignore = true)
    Job maptoEditJob(JobEditDTO dto);

    @Mapping(target = "jobposterId", source = "jobposter.id")
    @Mapping(target = "jobposterName", source = "jobposter.name")
    JobResponseDTO maptoreturnJob(Job job);
}
