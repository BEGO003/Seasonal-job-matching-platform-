package grad_project.seasonal_job_matching.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.NullValuePropertyMappingStrategy;

import grad_project.seasonal_job_matching.model.Resume;
import grad_project.seasonal_job_matching.dto.requests.ResumeCreateDTO;
import grad_project.seasonal_job_matching.dto.responses.ResumeResponseDTO;

@Mapper(componentModel = "spring",nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface ResumeMapper {

    @Mapping(target = "id", ignore = true)
    Resume maptoAddResume(ResumeCreateDTO dto);

    // @Mapping(target = "id", ignore = true)
    // @Mapping(target = "education", ignore = true)
    // @Mapping(target = "experience", ignore = true)
    // @Mapping(target = "certificates", ignore = true)
    // @Mapping(target = "skills", ignore = true)
    // @Mapping(target = "languages", ignore = true)
    // Resume maptoEditResume(ResumeEditDTO dto, @MappingTarget Resume entity);

    ResumeResponseDTO maptoreturnResume(Resume resume);

}