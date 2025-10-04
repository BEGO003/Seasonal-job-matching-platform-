package grad_project.seasonal_job_matching.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import grad_project.seasonal_job_matching.dto.UserDTO;
import grad_project.seasonal_job_matching.mapper.CustomMapper;
import grad_project.seasonal_job_matching.model.Type;
import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.repository.UserRepository;
import jakarta.annotation.PostConstruct;

@Service
public class UserService {

    public final List<User> users = new ArrayList<>();
    private final UserRepository userRepository;

    //like singleton, only one instantiation of code which is in mapper so it gets that one instead of creating a new one in this class
    @Autowired
    private CustomMapper userMapper;

    public UserService(UserRepository userRepository){
        this.userRepository = userRepository;

    }
    public List<User> findAllUsers(){
        return userRepository.findAll();
    }

    public Optional<User> findByID(long id){
        return userRepository.findById(id);
    }
    //Optional is when a return might or might not return a null value
    // public Optional<User> findUserbyEmail(String email){
    //     return users.stream().filter(user -> user.getEmail().equals(email)).findFirst();
    // }

    //means we do this method after dependency injection 
    @PostConstruct
    public void init(){
        User seeker = new User("Baher", "Egypt", "0122234344", "test@gmail.com", "1234", Type.JOB_SEEKER);
        //return user dto
        userRepository.save(seeker);
    }
    
    public void createUser(UserDTO dto) {
        //if email is NOT present, save new user
        if (!userRepository.existsByEmail(dto.getEmail())) {
            User user1 = userMapper.maptoAddUser(dto);
            //still need to encrypt password
            user1.setPassword(dto.getPassword());
            user1.setType(detectType());
            //User user = User.fromDTO(dto);
            userRepository.save(user1);
        }else{
            throw new RuntimeException("Cannot create user, email already exists: " + dto.getEmail());    
        }
    }

    public void editUser(UserDTO dto, long id){
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

        if(dto.getAddress() != null && !dto.getAddress().trim().isEmpty()){
        existingUser.setAddress(updatedUser.getAddress());
        }

        if(dto.getEmail() != null && !dto.getEmail().trim().isEmpty()){
            existingUser.setEmail(updatedUser.getEmail());
        }

        if (dto.getNumber() != null && !dto.getNumber().trim().isEmpty()) {
            existingUser.setNumber(updatedUser.getNumber());
        }
        
        if (dto.getPassword() != null && !dto.getPassword().trim().isEmpty()) {
            existingUser.setPassword(updatedUser.getPassword());
        }

        userRepository.save(existingUser);
    }

    private Type detectType(){
        //if mobile, type is jobseeker, else employer
        return Type.JOB_SEEKER;
    }

    public void deleteUser(Long id){
        userRepository.deleteById(id);
    }

}
