package grad_project.seasonal_job_matching.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import grad_project.seasonal_job_matching.dto.requests.ApplicationCreateDTO;
import grad_project.seasonal_job_matching.dto.responses.ApplicationResponseDTO;
import grad_project.seasonal_job_matching.model.Application;

@Mapper(componentModel = "spring")
public interface ApplicationMapper {
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "user", ignore = true)
    @Mapping(target = "job", ignore = true)
    @Mapping(target = "applicationStatus", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    //@Mapping(target = "updatedAt", ignore = true)
    Application maptoAddApplication(ApplicationCreateDTO dto);


    @Mapping(source = "user.id", target = "userId")//gets user id, basically like application.getUser().getId()
    @Mapping(source = "job", target = "job")
    ApplicationResponseDTO maptoreturnApplication(Application application);
}
