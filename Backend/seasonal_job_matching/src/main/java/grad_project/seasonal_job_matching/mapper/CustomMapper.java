package grad_project.seasonal_job_matching.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import grad_project.seasonal_job_matching.dto.JobDTO;
import grad_project.seasonal_job_matching.dto.UserDTO;
import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.model.User;

@Mapper(componentModel = "spring")
public interface CustomMapper {

    //Legacy way of getting instance of interface
    CustomMapper usermapper = Mappers.getMapper(CustomMapper.class);

    @Mapping(target = "id", ignore = true)//ignore displaying id
    @Mapping(target = "password", ignore = true)//ignore password, will hash in service layer
    @Mapping(target = "type", ignore = true)//ignore type, determine it in service 
    User maptoAddUser(UserDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "type", ignore = true)
    User maptoEditUser(UserDTO dto);

    @Mapping(target = "id", ignore = true)
    Job maptoAddJob(JobDTO dto);
}
