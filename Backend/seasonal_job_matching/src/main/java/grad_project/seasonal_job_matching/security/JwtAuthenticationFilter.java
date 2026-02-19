package grad_project.seasonal_job_matching.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

//every time a request is sent, filter is executed only once
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter{
    
    private final JWTService jwtService;
    private final CustomUserDetailsService userDetailsService;
    
    public JwtAuthenticationFilter(JWTService jwtService, CustomUserDetailsService userDetailsService) {
        this.jwtService = jwtService;
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void doFilterInternal(
        HttpServletRequest request,
        HttpServletResponse response,
        FilterChain filterChain) throws ServletException, IOException {

        final String authHeader = request.getHeader("Authorization");
        final String jwt;
        final Long userId;

        //if header doesn't have bearer or is empty, that not authorized and return empty
        if (authHeader == null || !authHeader.startsWith("Bearer ")){
            filterChain.doFilter(request, response);
            return ;
        }

        jwt = authHeader.substring(7); //remove the bearer and get the actual token that holds email

        try{
            userId = jwtService.extractUserId(jwt);

            //if user id extracted and user not authenticated
            if (userId != null && SecurityContextHolder.getContext().getAuthentication() == null){
                UserDetails userDetails = userDetailsService.loadUserByUsername(String.valueOf(userId));

                //checks token is valid (signature + expiration)
                if(jwtService.validateToken(jwt)){ 
                    //takes principles (user details), credentials, and authorities
                    UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                    //makes token learn about request details
                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                
                     // Set authentication in SecurityContext
                     SecurityContextHolder.getContext().setAuthentication(authToken);
                }
            }
        } catch (Exception e){
            logger.error("JWT validation failed", e);
        }
        // Continue filter chain
        filterChain.doFilter(request, response);
    }
}
