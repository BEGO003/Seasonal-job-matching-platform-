package grad_project.seasonal_job_matching.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class JobController {

    @GetMapping("/test")
    public String getTest() {
        return "✅ GET /api/test reached the controller";
    }


    @PostMapping("/test")
    public String postTest() {
        return "✅ POST /api/test reached the controller";
    }
}
