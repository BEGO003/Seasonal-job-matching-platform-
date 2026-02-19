package grad_project.seasonal_job_matching.security;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.repository.UserRepository;
/*
The Workflow: How it works in real life
When someone tries to log in with the email student@example.com:

Spring Security asks: "Hey CustomUserDetailsService, do we have a user with the username student@example.com?"

Your Code (The Repository): Checks your database.

Your Code (The Builder): If found, it wraps your database data into a standard UserDetails object that Spring Security understands.

Spring Security: Takes that object, looks at the hashed password inside it, and compares it to the password the user just typed in
*/
@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    public CustomUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override // now loads user by ID (passed as String)
    public UserDetails loadUserByUsername(String userIdString) throws UsernameNotFoundException {
        long userId;
        try {
            userId = Long.parseLong(userIdString);
        } catch (NumberFormatException e) {
            throw new UsernameNotFoundException("Invalid user ID: " + userIdString);
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with ID: " + userIdString));
        
        return org.springframework.security.core.userdetails.User.builder()
                // use the userId as the principal username in the security context
                .username(String.valueOf(user.getId()))
                .password(user.getPassword())
                .authorities("ROLE_USER") // You can add roles later
                .build();
    }
}