package grad_project.seasonal_job_matching.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.config.Customizer; 


@Configuration
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }
    
    @Bean
    // public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    //     http
    //         .csrf(csrf -> csrf.disable())
    //         // Starts the configuration chain on the HttpSecurity object.
    //         // Disables Cross-Site Request Forgery (CSRF) protection. 
    //         // This is typically done for stateless REST APIs that use tokens (JWT/Bearer) instead of sessions/cookies.
            
    //         .authorizeHttpRequests(auth -> auth
    //         // Starts configuration for URL-based access control (authorization).
    //             .requestMatchers("/api/**").permitAll() // allow all API calls (dev only)
    //             // .permitAll() explicitly allows access to these URLs without requiring any authentication.
    //             .anyRequest().authenticated()
    //             // Rule 2: Acts as a catch-all for any other request path not covered by the previous rules (e.g., /admin, /metrics).
    //         // .authenticated() requires the user to be logged in (authenticated) to access these resources.
    //         )
            
    //         .httpBasic(Customizer.withDefaults()); // enable basic auth for other endpoints if needed
    //         // Configures HTTP Basic Authentication as the default mechanism for authentication challenges.
    //         // If an unauthorized user accesses an authenticated endpoint, the server requests credentials (username/password)
    //         // using the standard HTTP Basic challenge header (401 Unauthorized response).

    //     return http.build();
    // }
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/**").permitAll() // allow all API calls (dev only)
                .anyRequest().permitAll()
            )
            .httpBasic(basic -> basic.disable()) // Disable HTTP Basic for /api/** endpoints
            .formLogin(form -> form.disable()) // Disable form login
            .logout(logout -> logout.disable());
        return http.build();
    }

}
