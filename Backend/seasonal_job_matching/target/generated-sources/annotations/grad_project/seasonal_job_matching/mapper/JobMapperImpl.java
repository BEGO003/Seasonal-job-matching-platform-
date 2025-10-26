package grad_project.seasonal_job_matching.mapper;

import grad_project.seasonal_job_matching.dto.requests.JobCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.JobEditDTO;
import grad_project.seasonal_job_matching.dto.responses.JobResponseDTO;
import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.model.User;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-10-22T22:29:05+0300",
    comments = "version: 1.5.5.Final, compiler: Eclipse JDT (IDE) 3.44.0.v20251001-1143, environment: Java 21.0.8 (Eclipse Adoptium)"
)
@Component
public class JobMapperImpl implements JobMapper {

    @Override
    public Job maptoAddJob(JobCreateDTO dto) {
        if ( dto == null ) {
            return null;
        }

        Job job = new Job();

        job.setTitle( dto.getTitle() );
        job.setDescription( dto.getDescription() );
        job.setType( dto.getType() );
        job.setLocation( dto.getLocation() );
        job.setStartDate( dto.getStartDate() );
        job.setEndDate( dto.getEndDate() );
        job.setSalary( dto.getSalary() );
        job.setStatus( dto.getStatus() );
        job.setNumofpositions( dto.getNumofpositions() );

        return job;
    }

    @Override
    public Job maptoEditJob(JobEditDTO dto) {
        if ( dto == null ) {
            return null;
        }

        Job job = new Job();

        job.setWorkarrangement( dto.getWorkarrangement() );
        job.setTitle( dto.getTitle() );
        job.setDescription( dto.getDescription() );
        job.setType( dto.getType() );
        job.setLocation( dto.getLocation() );
        job.setStartDate( dto.getStartDate() );
        job.setEndDate( dto.getEndDate() );
        job.setSalary( dto.getSalary() );
        job.setStatus( dto.getStatus() );
        job.setNumofpositions( dto.getNumofpositions() );

        return job;
    }

    @Override
    public JobResponseDTO maptoreturnJob(Job job) {
        if ( job == null ) {
            return null;
        }

        JobResponseDTO jobResponseDTO = new JobResponseDTO();

        jobResponseDTO.setJobposterId( jobJobposterId( job ) );
        jobResponseDTO.setJobposterName( jobJobposterName( job ) );
        jobResponseDTO.setDescription( job.getDescription() );
        jobResponseDTO.setEndDate( job.getEndDate() );
        jobResponseDTO.setId( job.getId() );
        jobResponseDTO.setLocation( job.getLocation() );
        jobResponseDTO.setNumofpositions( job.getNumofpositions() );
        jobResponseDTO.setSalary( job.getSalary() );
        jobResponseDTO.setStartDate( job.getStartDate() );
        jobResponseDTO.setStatus( job.getStatus() );
        jobResponseDTO.setTitle( job.getTitle() );
        jobResponseDTO.setType( job.getType() );
        jobResponseDTO.setWorkarrangement( job.getWorkarrangement() );

        return jobResponseDTO;
    }

    private long jobJobposterId(Job job) {
        if ( job == null ) {
            return 0L;
        }
        User jobposter = job.getjobposter();
        if ( jobposter == null ) {
            return 0L;
        }
        long id = jobposter.getId();
        return id;
    }

    private String jobJobposterName(Job job) {
        if ( job == null ) {
            return null;
        }
        User jobposter = job.getjobposter();
        if ( jobposter == null ) {
            return null;
        }
        String name = jobposter.getName();
        if ( name == null ) {
            return null;
        }
        return name;
    }
}
