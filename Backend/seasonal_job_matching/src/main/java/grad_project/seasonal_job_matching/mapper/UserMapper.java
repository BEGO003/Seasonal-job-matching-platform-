package grad_project.seasonal_job_matching.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import grad_project.seasonal_job_matching.dto.requests.UserCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.UserEditDTO;
import grad_project.seasonal_job_matching.dto.responses.UserResponseDTO;
import grad_project.seasonal_job_matching.model.User;

@Mapper(componentModel = "spring")
public interface UserMapper {


    @Mapping(target = "id", ignore = true)//ignore displaying id
    @Mapping(target = "password", ignore = true)//ignore password, will hash in service layer
    @Mapping(target = "ownedjobs", ignore = true)
    @Mapping(target = "favoritedjobs", ignore = true)
    User maptoAddUser(UserCreateDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "ownedjobs", ignore = true)
    @Mapping(target = "favoritedjobs", ignore = true)
    User maptoEditUser(UserEditDTO dto);

    UserResponseDTO maptoreturnUser(User user);

}
