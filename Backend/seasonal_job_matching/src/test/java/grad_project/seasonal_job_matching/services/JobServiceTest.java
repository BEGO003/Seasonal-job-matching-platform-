package grad_project.seasonal_job_matching.services;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import java.sql.Date;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import grad_project.seasonal_job_matching.dto.responses.JobResponseDTO;
import grad_project.seasonal_job_matching.mapper.JobMapper;
import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.model.enums.JobStatus;
import grad_project.seasonal_job_matching.model.enums.JobType;
import grad_project.seasonal_job_matching.model.enums.Salary;
import grad_project.seasonal_job_matching.model.enums.WorkArrangement;
import grad_project.seasonal_job_matching.repository.JobRepository;
import grad_project.seasonal_job_matching.repository.UserRepository;

@ExtendWith(MockitoExtension.class)
@DisplayName("JobService Tests")
class JobServiceTest {

    @Mock
    private JobRepository jobRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private JobMapper jobMapper;

    @InjectMocks
    private JobService jobService;

    private Job testJob;
    private User testUser;
    private JobResponseDTO testJobResponseDTO;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setId(1L);
        testUser.setEmail("test@example.com");

        testJob = new Job();
        testJob.setId(1L);
        testJob.setTitle("Software Developer");
        testJob.setStatus(JobStatus.OPEN);
        testJob.setJobPoster(testUser);
        testJob.setCreatedAt(Date.valueOf(java.time.LocalDate.now()));
        testJob.setLocation("New York");
        testJob.setType(JobType.FULL_TIME);
        testJob.setWorkArrangement(WorkArrangement.REMOTE);
        testJob.setSalary(Salary.HOURLY);

        testJobResponseDTO = new JobResponseDTO();
        testJobResponseDTO.setId(1L);
        testJobResponseDTO.setTitle("Software Developer");
    }

    @Test
    @DisplayName("Should return paginated jobs sorted by createdAt DESC")
    void testGetJobsPaged_Success() {
        // Arrange
        int page = 0;
        List<Job> jobs = Arrays.asList(testJob);
        Page<Job> jobPage = new PageImpl<>(jobs, PageRequest.of(page, 50, Sort.by(Sort.Direction.DESC, "createdAt")), 1);
        
        when(jobRepository.findAllByStatusNotIn(anyList(), any(Pageable.class)))
            .thenReturn(jobPage);
        when(jobMapper.maptoreturnJob(any(Job.class)))
            .thenReturn(testJobResponseDTO);

        // Act
        Page<JobResponseDTO> result = jobService.getJobsPaged(page);

        // Assert
        assertNotNull(result);
        assertEquals(1, result.getContent().size());
        assertEquals(1, result.getTotalElements());
        assertEquals(1, result.getTotalPages());
        assertTrue(result.isFirst());
        assertTrue(result.isLast());
        
        verify(jobRepository).findAllByStatusNotIn(
            eq(Arrays.asList(JobStatus.DRAFT, JobStatus.CLOSED)),
            any(Pageable.class)
        );
        verify(jobMapper, times(1)).maptoreturnJob(testJob);
    }

    @Test
    @DisplayName("Should exclude DRAFT and CLOSED jobs from pagination")
    void testGetJobsPaged_ExcludesDraftAndClosed() {
        // Arrange
        int page = 0;
        Page<Job> jobPage = new PageImpl<>(Collections.emptyList());
        
        when(jobRepository.findAllByStatusNotIn(anyList(), any(Pageable.class)))
            .thenReturn(jobPage);

        // Act
        Page<JobResponseDTO> result = jobService.getJobsPaged(page);

        // Assert
        verify(jobRepository).findAllByStatusNotIn(
            eq(Arrays.asList(JobStatus.DRAFT, JobStatus.CLOSED)),
            any(Pageable.class)
        );
    }

    @Test
    @DisplayName("Should return 50 jobs per page")
    void testGetJobsPaged_PageSizeIs50() {
        // Arrange
        int page = 0;
        List<Job> jobs = Collections.nCopies(50, testJob);
        Page<Job> jobPage = new PageImpl<>(jobs, PageRequest.of(page, 50), 100);
        
        when(jobRepository.findAllByStatusNotIn(anyList(), any(Pageable.class)))
            .thenReturn(jobPage);
        when(jobMapper.maptoreturnJob(any(Job.class)))
            .thenReturn(testJobResponseDTO);

        // Act
        Page<JobResponseDTO> result = jobService.getJobsPaged(page);

        // Assert
        assertEquals(50, result.getContent().size());
        assertEquals(50, result.getSize());
    }

    @Test
    @DisplayName("Should search jobs by title case-insensitively")
    void testGetSearchedJobs_WithTitle() {
        // Arrange
        int page = 0;
        String searchTitle = "developer";
        List<Job> jobs = Arrays.asList(testJob);
        Page<Job> jobPage = new PageImpl<>(jobs, PageRequest.of(page, 50), 1);
        
        when(jobRepository.findByTitleContainingIgnoreCaseAndStatusNotIn(
            eq(searchTitle), anyList(), any(Pageable.class)))
            .thenReturn(jobPage);
        when(jobMapper.maptoreturnJob(any(Job.class)))
            .thenReturn(testJobResponseDTO);

        // Act
        Page<JobResponseDTO> result = jobService.getSearchedJobs(page, searchTitle);

        // Assert
        assertNotNull(result);
        assertEquals(1, result.getContent().size());
        verify(jobRepository).findByTitleContainingIgnoreCaseAndStatusNotIn(
            eq(searchTitle),
            eq(Arrays.asList(JobStatus.DRAFT, JobStatus.CLOSED)),
            any(Pageable.class)
        );
    }

    @Test
    @DisplayName("Should return all jobs when title is null or empty")
    void testGetSearchedJobs_EmptyTitle() {
        // Arrange
        int page = 0;
        Page<Job> jobPage = new PageImpl<>(Arrays.asList(testJob));
        
        when(jobRepository.findAllByStatusNotIn(anyList(), any(Pageable.class)))
            .thenReturn(jobPage);
        when(jobMapper.maptoreturnJob(any(Job.class)))
            .thenReturn(testJobResponseDTO);

        // Act
        Page<JobResponseDTO> resultNull = jobService.getSearchedJobs(page, null);
        Page<JobResponseDTO> resultEmpty = jobService.getSearchedJobs(page, "");

        // Assert
        assertNotNull(resultNull);
        assertNotNull(resultEmpty);
        verify(jobRepository, times(2)).findAllByStatusNotIn(anyList(), any(Pageable.class));
    }

    @Test
    @DisplayName("Should filter jobs by work arrangement, job type, salary, location, and title")
    void testGetJobsWithAdvancedFilters_AllFilters() {
        // Arrange
        int page = 0;
        List<WorkArrangement> arrangements = Arrays.asList(WorkArrangement.REMOTE);
        List<JobType> jobTypes = Arrays.asList(JobType.FULL_TIME);
        List<Salary> salaryTypes = Arrays.asList(Salary.HOURLY);
        String location = "New York";
        String title = "Developer";
        
        List<Job> jobs = Arrays.asList(testJob);
        Page<Job> jobPage = new PageImpl<>(jobs, PageRequest.of(page, 50), 1);
        
        when(jobRepository.findJobsWithAdvancedFilters(
            anyList(), any(), any(), any(), anyString(), anyString(), any(Pageable.class)))
            .thenReturn(jobPage);
        when(jobMapper.maptoreturnJob(any(Job.class)))
            .thenReturn(testJobResponseDTO);

        // Act
        Page<JobResponseDTO> result = jobService.getJobsWithAdvancedFilters(
            page, arrangements, jobTypes, salaryTypes, location, title);

        // Assert
        assertNotNull(result);
        verify(jobRepository).findJobsWithAdvancedFilters(
            eq(Arrays.asList(JobStatus.DRAFT, JobStatus.CLOSED)),
            eq(arrangements),
            eq(jobTypes),
            eq(salaryTypes),
            eq(location),
            eq(title),
            any(Pageable.class)
        );
    }

    @Test
    @DisplayName("Should handle null filters gracefully")
    void testGetJobsWithAdvancedFilters_NullFilters() {
        // Arrange
        int page = 0;
        Page<Job> jobPage = new PageImpl<>(Arrays.asList(testJob));
        
        when(jobRepository.findJobsWithAdvancedFilters(
            anyList(), isNull(), isNull(), isNull(), isNull(), isNull(), any(Pageable.class)))
            .thenReturn(jobPage);
        when(jobMapper.maptoreturnJob(any(Job.class)))
            .thenReturn(testJobResponseDTO);

        // Act
        Page<JobResponseDTO> result = jobService.getJobsWithAdvancedFilters(
            page, null, null, null, null, null);

        // Assert
        assertNotNull(result);
        verify(jobRepository).findJobsWithAdvancedFilters(
            anyList(), isNull(), isNull(), isNull(), isNull(), isNull(), any(Pageable.class)
        );
    }

    @Test
    @DisplayName("Should handle empty filter lists")
    void testGetJobsWithAdvancedFilters_EmptyLists() {
        // Arrange
        int page = 0;
        Page<Job> jobPage = new PageImpl<>(Arrays.asList(testJob));
        
        when(jobRepository.findJobsWithAdvancedFilters(
            anyList(), isNull(), isNull(), isNull(), isNull(), isNull(), any(Pageable.class)))
            .thenReturn(jobPage);
        when(jobMapper.maptoreturnJob(any(Job.class)))
            .thenReturn(testJobResponseDTO);

        // Act
        Page<JobResponseDTO> result = jobService.getJobsWithAdvancedFilters(
            page, Collections.emptyList(), Collections.emptyList(), 
            Collections.emptyList(), "", "");

        // Assert
        assertNotNull(result);
        verify(jobRepository).findJobsWithAdvancedFilters(
            anyList(), isNull(), isNull(), isNull(), isNull(), isNull(), any(Pageable.class)
        );
    }
}