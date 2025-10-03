package grad_project.seasonal_job_matching.seasonal_job_matching.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Users")
public class User {

    @Column
    private String name;

    @Column
    private String address;

    @Column
    private String number;

    @Id
    @Column
    private String email;

    @Column
    private String password;

    @Column
    private Type type;

    public User(String name, String address, String number, String email, String password, Type type){

        this.name = name;
        this.address = address;
        this.email = email;
        this.password = password;
        this.number = number;
        this.type = type;
    }

    // Getters
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
