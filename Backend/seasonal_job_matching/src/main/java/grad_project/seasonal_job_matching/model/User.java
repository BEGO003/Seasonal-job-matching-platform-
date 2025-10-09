package grad_project.seasonal_job_matching.model;



import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "Users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column//turn to UUID, review it first
    private long id;
    
    @Column(nullable = false,length = 100)
    private String name;

    @OneToMany(mappedBy = "jobposter", cascade = CascadeType.ALL)
    private List<Job> ownedjobs;
    
    @Column
    private String address;

    @Column(length=11)
    private String number;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column
    private Type type;

    // Default constructor required for JPA
    public User() {

    }
    
    // can use autowired/automapping which is a wrapper that automatically parses the data and places them in the correct place
    // public static User fromDTO(createuserDTO dto){
    //     User user = new User();
    //     user.setAddress(dto.getAddress());
    //     user.setEmail(dto.getEmail());
    //     user.setName(dto.getName());
    //     user.setPassword(dto.getPassword());
    //     user.setNumber(dto.getNumber());
    //     user.setType(detectType());
    //     return user;
    // }


    public User(String name, String address, String number, String email, String password, Type type){

        this.name = name;
        this.address = address;
        this.email = email;
        this.password = password;
        this.number = number;
        this.type = type;
    }

    // Getters
    public long getId() {
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
    public void setId(int id) {
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
