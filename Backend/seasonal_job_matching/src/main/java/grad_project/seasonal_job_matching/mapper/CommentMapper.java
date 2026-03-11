package grad_project.seasonal_job_matching.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import grad_project.seasonal_job_matching.dto.responses.JobCommentResponseDTO;
import grad_project.seasonal_job_matching.model.JobComment;

@Mapper(componentModel = "spring")
public interface CommentMapper {

    @Mapping(target = "userName", source = "user.name")
    @Mapping(target = "userId", source = "user.id")
    JobCommentResponseDTO mapToReturnComment(JobComment comment);

}
