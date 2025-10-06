package grad_project.seasonal_job_matching.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import grad_project.seasonal_job_matching.dto.UserDTO;
import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.services.UserService;
import jakarta.validation.Valid;




@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/user")
public class UserController {
    final private UserService users_service;

    public UserController(UserService service){
        this.users_service = service;
    }

    
    @GetMapping("/all")
    public List<User> findAll(){
        return users_service.findAllUsers();
    }

    @GetMapping("/{id}")
    public ResponseEntity<String> findByID(@PathVariable long id){
        if(users_service.findByID(id).isEmpty()){
            return ResponseEntity.ok("User not found!");
        }else{
            return ResponseEntity.ok("User found!");
        }
    }
    
    @PostMapping("/new")
    public ResponseEntity<String> createUser(@Valid @RequestBody UserDTO userdto){//if user is from mobile than type is jobseeker, else it is employer  
        try {
            users_service.createUser(userdto);
            return ResponseEntity.ok("User created successfully");
        } catch (RuntimeException e) {
            return ResponseEntity.ok("Email already in use!");
        }
        
        
    }

    @PostMapping("/edit/{id}")
    public ResponseEntity<String> editUser(@PathVariable long id,@Valid @RequestBody UserDTO dto){
        try {
            users_service.editUser(dto, id);
            return ResponseEntity.ok("User updated successfully");
        } catch (RuntimeException e) {
            return ResponseEntity.ok("Update failed");
        }
    }


    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteUser(@PathVariable Long id){
        if (ResponseEntity.ok()==findByID(id)) {
            users_service.deleteUser(id);
            return ResponseEntity.ok("User deleted successfully!");
        }else{
            return ResponseEntity.ok("User not found!");
        }
        

    }

}
