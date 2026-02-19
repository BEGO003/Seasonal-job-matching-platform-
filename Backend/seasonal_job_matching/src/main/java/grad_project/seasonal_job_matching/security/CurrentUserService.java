package grad_project.seasonal_job_matching.security;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class CurrentUserService {

    private final JWTService jwtService;
    
    public CurrentUserService(JWTService jwtService){
        this.jwtService = jwtService;
    }
    // since used in all controllers to compare id with id in token so user can't check data of other users 
    public Long getCurrentUserId(HttpServletRequest request){
        String authHeader = request.getHeader("Authorization");
        if (authHeader == null || !authHeader.startsWith("Bearer ")) return null;
        String token = authHeader.substring(7);
        return jwtService.extractUserId(token);
    }
}
