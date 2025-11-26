package grad_project.seasonal_job_matching.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import grad_project.seasonal_job_matching.dto.requests.UserCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.UserEditDTO;
import grad_project.seasonal_job_matching.dto.requests.UserLoginDTO;
import grad_project.seasonal_job_matching.dto.responses.JobResponseDTO;
import grad_project.seasonal_job_matching.dto.responses.UserFieldsOfInterestResponseDTO;
import grad_project.seasonal_job_matching.dto.responses.UserResponseDTO;
import grad_project.seasonal_job_matching.mapper.JobMapper;
import grad_project.seasonal_job_matching.mapper.UserMapper;
import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.repository.UserRepository;

@Service
public class UserService {

    public final List<User> users = new ArrayList<>();
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    //like singleton, only one instantiation of code which is in mapper so it gets that one instead of creating a new one in this class
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private JobMapper jobMapper;
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder){
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;

    }
    public List<UserResponseDTO> findAllUsers(){
        return userRepository.findAll()
        .stream() //turns from List into type stream<user> which can use map and collect
        
        //can(user -> userMapper.maptoreturnUser(user))
        .map(userMapper::maptoreturnUser) // applies maptoreturn user from usermapper to each user in stream, turns user into a DTO
        .collect(Collectors.toList()); //gathers all transformer users back into list 
    }

    public List<JobResponseDTO> findUserJobs(long id){
        User user = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found with ID: " + id));
        return user.getOwnedJobs().stream().map(jobMapper::maptoreturnJob).collect(Collectors.toList());
    }

    public UserResponseDTO loginUser(UserLoginDTO dto) {
        
        // 1. Find the user by their email
        User user = userRepository.findByEmail(dto.getEmail())
                .orElseThrow(() -> new RuntimeException("Authentication failed: Invalid credentials."));

        // 2. Check if the provided password matches the stored hashed password
        if (passwordEncoder.matches(dto.getPassword(), user.getPassword())) {
            // 3. Passwords match, return the user's data (without the password)
            return userMapper.maptoreturnUser(user);
        } else {
            // 4. Passwords do not match
            throw new RuntimeException("Authentication failed: Invalid credentials.");
        }
    }

    public Optional<UserResponseDTO> findByID(long id){
        return userRepository.findById(id)
            .map(userMapper::maptoreturnUser);
    }
/* 
    //means we do this method after dependency injection 
     @PostConstruct
    public void init(){
        User seeker = new User("Baher", "Egypt", "0122234344", "test@gmail.com", "1234");
        //return user dto
        userRepository.save(seeker);
    }
*/    
    @Transactional(readOnly = true)
    public UserFieldsOfInterestResponseDTO getFieldsOfInterest(long userId) {
        //User user = userRepository.findById(userId)
        //    .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));
        
        //    List<Application> apps = user.getOwnedApplications();
        Optional<User> user = userRepository.findById(userId);

        List<String> foi = user.map(User::getFieldsOfInterest)
            .orElse(new ArrayList<>());

        UserFieldsOfInterestResponseDTO dto = new UserFieldsOfInterestResponseDTO();
        dto.setFieldsOfInterest(foi);
        return dto;

    }

    public UserResponseDTO createUser(UserCreateDTO dto) {
        //if email is NOT present, save new user
        if (!userRepository.existsByEmail(dto.getEmail())) {
            User user1 = userMapper.maptoAddUser(dto);
          
            //encrypt password
            user1.setPassword(passwordEncoder.encode(dto.getPassword()));
            
            //better practice especially since user1 is being edited
            User saveduser = userRepository.save(user1);
            return userMapper.maptoreturnUser(saveduser);
            
        }else{
            throw new RuntimeException("Cannot create user");    
        }
    }

    public UserResponseDTO editUser(UserEditDTO dto, long id){
        User existingUser = userRepository.findById(id).orElseThrow(()-> new RuntimeException("User not found with ID: " + id));

        //checks to see if we are editing email
        //in case we're editing a different field than email, check new email isn't empty, checks new email isnt same as OLD email
        if (dto.getEmail()!=null && !dto.getEmail().trim().isEmpty() && !dto.getEmail().equals(existingUser.getEmail())) {
            //after confirming that we are editing email, checks new email isnt as another email in db
            if (userRepository.existsByEmail(existingUser.getEmail())) {
                throw new RuntimeException("Cannot update user, email already exists: " + dto.getEmail());
            }
        }

        //has new fields that are changed
        User updatedUser = userMapper.maptoEditUser(dto);
        
        //if field thats updated is name and new name isn't empty
        if(dto.getName() != null && !dto.getName().trim().isEmpty()){
            existingUser.setName(updatedUser.getName());
        }

        if(dto.getCountry() != null && !dto.getCountry().trim().isEmpty()){
        existingUser.setCountry(updatedUser.getCountry());
        }

        if(dto.getEmail() != null && !dto.getEmail().trim().isEmpty()){
            existingUser.setEmail(updatedUser.getEmail());
        }

        if (dto.getNumber() != null && !dto.getNumber().trim().isEmpty()) {
            existingUser.setNumber(updatedUser.getNumber());
        }
        
        if (dto.getPassword() != null && !dto.getPassword().trim().isEmpty()) {
            existingUser.setPassword(passwordEncoder.encode(updatedUser.getNumber()));
        }

        if (dto.getFieldsOfInterestToAdd() != null) {
            for (String field : dto.getFieldsOfInterestToAdd()) {
                if (!existingUser.getFieldsOfInterest().contains(field)) {
                    existingUser.getFieldsOfInterest().add(field);
                }
            }
        }

        if (dto.getFieldsOfInterestToRemove() != null) {
            existingUser.getFieldsOfInterest().removeAll(dto.getFieldsOfInterestToRemove());
        }

        User saveduser = userRepository.save(existingUser);
        return userMapper.maptoreturnUser(saveduser);
    }

    public void deleteUser(Long id){
        userRepository.deleteById(id);
    }


}
