package grad_project.seasonal_job_matching.mapper;

import grad_project.seasonal_job_matching.dto.requests.UserCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.UserEditDTO;
import grad_project.seasonal_job_matching.dto.responses.JobResponseDTO;
import grad_project.seasonal_job_matching.dto.responses.UserResponseDTO;
import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.model.User;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.processing.Generated;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-10-22T22:29:05+0300",
    comments = "version: 1.5.5.Final, compiler: Eclipse JDT (IDE) 3.44.0.v20251001-1143, environment: Java 21.0.8 (Eclipse Adoptium)"
)
@Component
public class UserMapperImpl implements UserMapper {

    @Autowired
    private JobMapper jobMapper;

    @Override
    public User maptoAddUser(UserCreateDTO dto) {
        if ( dto == null ) {
            return null;
        }

        User user = new User();

        user.setCountry( dto.getCountry() );
        user.setEmail( dto.getEmail() );
        user.setName( dto.getName() );
        user.setNumber( dto.getNumber() );

        return user;
    }

    @Override
    public User maptoEditUser(UserEditDTO dto) {
        if ( dto == null ) {
            return null;
        }

        User user = new User();

        user.setCountry( dto.getCountry() );
        user.setEmail( dto.getEmail() );
        user.setName( dto.getName() );
        user.setNumber( dto.getNumber() );
        user.setPassword( dto.getPassword() );

        return user;
    }

    @Override
    public UserResponseDTO maptoreturnUser(User user) {
        if ( user == null ) {
            return null;
        }

        UserResponseDTO userResponseDTO = new UserResponseDTO();

        userResponseDTO.setOwnjobList( jobListToJobResponseDTOList( user.getOwnedjobs() ) );
        userResponseDTO.setCountry( user.getCountry() );
        userResponseDTO.setEmail( user.getEmail() );
        userResponseDTO.setName( user.getName() );
        userResponseDTO.setNumber( user.getNumber() );

        return userResponseDTO;
    }

    protected List<JobResponseDTO> jobListToJobResponseDTOList(List<Job> list) {
        if ( list == null ) {
            return null;
        }

        List<JobResponseDTO> list1 = new ArrayList<JobResponseDTO>( list.size() );
        for ( Job job : list ) {
            list1.add( jobMapper.maptoreturnJob( job ) );
        }

        return list1;
    }
}
