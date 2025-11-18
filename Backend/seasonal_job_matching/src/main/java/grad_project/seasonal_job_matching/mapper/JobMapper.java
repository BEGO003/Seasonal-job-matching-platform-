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
    @Mapping(target = "jobPoster", ignore = true)
    @Mapping(target = "workArrangement", source = "workArrangement") 
    @Mapping(target = "listOfJobApplications", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "numOfPositions", source = "numofpositions")  // Fix syntax later
    Job maptoAddJob(JobCreateDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "jobPoster", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "numOfPositions", source = "numofpositions")  //fix this spelling so you can remove this line
    @Mapping(target = "listOfJobApplications", ignore = true) 
    @Mapping(target = "requirements", ignore = true) 
    @Mapping(target = "categories", ignore = true) 
    @Mapping(target = "benefits", ignore = true)  
    Job maptoEditJob(JobEditDTO dto);

    @Mapping(target = "jobposterId", source = "jobPoster.id")
    @Mapping(target = "jobposterName", source = "jobPoster.name")
    @Mapping(target = "numofpositions", source = "numOfPositions") //fix this spelling
    JobResponseDTO maptoreturnJob(Job job);
}
