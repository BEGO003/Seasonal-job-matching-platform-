package grad_project.seasonal_job_matching.controller;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.util.Arrays;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import grad_project.seasonal_job_matching.dto.responses.JobResponseDTO;
import grad_project.seasonal_job_matching.services.JobService;

@WebMvcTest(JobController.class)
@DisplayName("JobController Tests")
class JobControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private JobService jobService;

    @Test
    @DisplayName("GET /api/jobs should return paginated jobs")
    void testFindAll_ReturnsPaginatedJobs() throws Exception {
        // Arrange
        JobResponseDTO jobDTO = new JobResponseDTO();
        jobDTO.setId(1L);
        jobDTO.setTitle("Software Developer");
        
        Page<JobResponseDTO> page = new PageImpl<>(
            Arrays.asList(jobDTO), 
            PageRequest.of(0, 50), 
            1
        );
        
        when(jobService.getJobsPaged(0)).thenReturn(page);

        // Act & Assert
        mockMvc.perform(get("/api/jobs")
                .param("page", "0")
                .contentType(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.content").isArray())
            .andExpect(jsonPath("$.content[0].id").value(1L))
            .andExpect(jsonPath("$.content[0].title").value("Software Developer"))
            .andExpect(jsonPath("$.totalElements").value(1))
            .andExpect(jsonPath("$.totalPages").value(1));
    }

    @Test
    @DisplayName("GET /api/jobs/search should return searched jobs")
    void testFindJobsFromSearch_ReturnsSearchedJobs() throws Exception {
        // Arrange
        JobResponseDTO jobDTO = new JobResponseDTO();
        jobDTO.setId(1L);
        jobDTO.setTitle("Software Developer");
        
        Page<JobResponseDTO> page = new PageImpl<>(Arrays.asList(jobDTO));
        when(jobService.getSearchedJobs(0, "developer")).thenReturn(page);

        // Act & Assert
        mockMvc.perform(get("/api/jobs/search")
                .param("page", "0")
                .param("title", "developer")
                .contentType(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.content").isArray())
            .andExpect(jsonPath("$.content[0].title").value("Software Developer"));
    }
}