package grad_project.seasonal_job_matching.model;



import grad_project.seasonal_job_matching.dto.createuserDTO;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;
    
    @Column
    private String name;

    @Column
    private String address;

    @Column
    private String number;

    @Column
    private String email;

    @Column
    private String password;

    @Column
    private Type type;

    // Default constructor required for JPA
    public User() {

    }
    
    // can use autowired/automapping which is a wrapper that 
    public static User fromDTO(createuserDTO dto){
        User user = new User();
        user.setAddress(dto.getAddress());
        user.setEmail(dto.getEmail());
        user.setName(dto.getName());
        user.setPassword(dto.getPassword());
        user.setNumber(dto.getNumber());
        user.setType(detectType());
        return user;
    }

    private static Type detectType(){
        //if mobile, type is jobseeker, else employer
        return Type.JOB_SEEKER;
    }

    public User(String name, String address, String number, String email, String password, Type type){

        this.name = name;
        this.address = address;
        this.email = email;
        this.password = password;
        this.number = number;
        this.type = type;
    }

    // Getters
    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getAddress() {
        return address;
    }

    public String getNumber() {
        return number;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public Type getType() {
        return type;
    }

    // Setters
    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setType(Type type) {
        this.type = type;
    }
}
