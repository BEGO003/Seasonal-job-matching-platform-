package grad_project.seasonal_job_matching.repository;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Date;
import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import grad_project.seasonal_job_matching.model.Job;
import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.model.enums.JobStatus;






import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.boot.autoconfigure.ImportAutoConfiguration;
import grad_project.seasonal_job_matching.SeasonalJobMatchingApplication;







@SpringBootTest(
    classes = SeasonalJobMatchingApplication.class,
    webEnvironment = SpringBootTest.WebEnvironment.NONE
)
@ActiveProfiles("test")
@Transactional
@DisplayName("JobRepository Tests")
@ImportAutoConfiguration(exclude = {
    org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class
})
class JobRepositoryTest {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private JobRepository jobRepository;

    private User testUser;
    private Job openJob;
    private Job draftJob;
    private Job closedJob;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setName("Test User");
        testUser.setEmail("test@example.com");
        testUser.setPassword("password");
        entityManager.persistAndFlush(testUser);

        openJob = createJob("Software Developer", JobStatus.OPEN, testUser);
        draftJob = createJob("Draft Job", JobStatus.DRAFT, testUser);
        closedJob = createJob("Closed Job", JobStatus.CLOSED, testUser);
    }

    private Job createJob(String title, JobStatus status, User user) {
        Job job = new Job();
        job.setTitle(title);
        job.setStatus(status);
        job.setJobPoster(user);
        job.setLocation("New York");
        job.setCreatedAt(Date.valueOf(java.time.LocalDate.now()));
        return entityManager.persistAndFlush(job);
    }

    @Test
    @DisplayName("Should find jobs excluding DRAFT and CLOSED statuses")
    void testFindAllByStatusNotIn_ExcludesDraftAndClosed() {
        // Arrange
        List<JobStatus> excludedStatuses = Arrays.asList(JobStatus.DRAFT, JobStatus.CLOSED);
        Pageable pageable = PageRequest.of(0, 50, Sort.by(Sort.Direction.DESC, "createdAt"));

        // Act
        Page<Job> result = jobRepository.findAllByStatusNotIn(excludedStatuses, pageable);

        // Assert
        assertEquals(1, result.getContent().size());
        assertEquals("Software Developer", result.getContent().get(0).getTitle());
        assertNotEquals(JobStatus.DRAFT, result.getContent().get(0).getStatus());
        assertNotEquals(JobStatus.CLOSED, result.getContent().get(0).getStatus());
    }

    @Test
    @DisplayName("Should search jobs by title case-insensitively")
    void testFindByTitleContainingIgnoreCaseAndStatusNotIn() {
        // Arrange
        Pageable pageable = PageRequest.of(0, 50);
        List<JobStatus> excludedStatuses = Arrays.asList(JobStatus.DRAFT, JobStatus.CLOSED);

        // Act
        Page<Job> result = jobRepository.findByTitleContainingIgnoreCaseAndStatusNotIn(
                "developer", excludedStatuses, pageable);

        // Assert
        assertEquals(1, result.getContent().size());
        assertTrue(result.getContent().get(0).getTitle().toLowerCase().contains("developer"));
    }

    @Test
    @DisplayName("Should return empty page when no jobs match search criteria")
    void testFindByTitleContainingIgnoreCaseAndStatusNotIn_NoMatches() {
        // Arrange
        Pageable pageable = PageRequest.of(0, 50);
        List<JobStatus> excludedStatuses = Arrays.asList(JobStatus.DRAFT, JobStatus.CLOSED);

        // Act
        Page<Job> result = jobRepository.findByTitleContainingIgnoreCaseAndStatusNotIn(
                "nonexistent", excludedStatuses, pageable);

        // Assert
        assertEquals(0, result.getContent().size());
        assertTrue(result.isEmpty());
    }
}
