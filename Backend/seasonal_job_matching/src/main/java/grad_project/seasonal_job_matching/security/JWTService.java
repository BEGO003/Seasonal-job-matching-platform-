package grad_project.seasonal_job_matching.security;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

import javax.crypto.SecretKey;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


@Service
public class JWTService {

    @Value("${jwt.secret}")
    private String secretKey; // Pulls a Base64 string from application.properties

    // public JWTService(){ //create a new key each time calling this object
    //     try {
    //         KeyGenerator keyGen = KeyGenerator.getInstance("HmacSHA256");
    //         SecretKey sk =  keyGen.generateKey(); //generates key in type secret key so we need to turn it into string
    //         Base64.getEncoder().encodeToString(sk.getEncoded()); //sk.getencoded turns secret key into butes and base64 encoder takes bytes and turns them into other types like string here
    //     } catch (NoSuchAlgorithmException e) {
    //         throw new RuntimeException();
    //     }
    // }

    // public Key getKey(){
    //     byte[] keyBytes = Decoders.Base64.decode(secretKey);
    //     return Keys.hmacShaKeyFor(keyBytes);
    // }

    //have name as an extra parameter in case I want to add it later to the tokens, can add helper  function to extract name 
    public String generateToken(Long userId, String email, String phoneNumber, String name){
        
        Map <String, Object> claims = new HashMap<>();
        
        // store full user identity as claims
        claims.put("userId", userId);
        claims.put("email", email);
        claims.put("name", name);
        claims.put("phoneNumber", phoneNumber);
                
        // use the stable userId as the JWT subject
        return createToken(claims, String.valueOf(userId));

    }

    private SecretKey getSigningKey() {
        // Uses your Base64 decoding method on the static key
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    // Extract username (email) from token (stored as a claim)
    public String extractEmail(String token) {
        Claims claims = extractAllClaims(token);
        return claims.get("email", String.class);
    }

    // Extract user ID from token (stored as subject)
    public Long extractUserId(String token) {
        String subject = extractClaim(token, Claims::getSubject);
        return Long.parseLong(subject);
    }

    // Extract expiration date from token
    public Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    // Generic method to extract a claim
    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }

    // Extract all claims from token
    private Claims extractAllClaims(String token) {
        try {
            return Jwts.parser()
                    .verifyWith(getSigningKey())
                    .build()
                    .parseSignedClaims(token)
                    .getPayload();
        } catch (Exception e) {
            throw new RuntimeException("Invalid JWT token", e);
        }
    }

    private Boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    public String createToken(Map<String, Object> claims, String subject){
        return Jwts.builder()
                .claims(claims) // Adds name, phone, userId
                .subject(subject) //adds userId as main identifier
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + 7 * 24 * 60 * 60 * 1000L)) //expiration after 1 week
                .signWith(getSigningKey())
                .compact();
    }

    //takes email and validates
    public Boolean validateToken(String token, String email) {
        final String tokenEmail = extractEmail(token);
        return (tokenEmail.equals(email) && !isTokenExpired(token));
    }

    // Validate token without email check (just check if valid and not expired)
    public Boolean validateToken(String token) {
        try {
            Claims claims = extractAllClaims(token);
            return !isTokenExpired(token);
        } catch (Exception e) {
            return false;
        }
    }

}
