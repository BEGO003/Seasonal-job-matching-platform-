package grad_project.seasonal_job_matching.seasonal_job_matching.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class JobSeeker {

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

    public JobSeeker(String name, String address, String number, String email, String password){

        this.name = name;
        this.address = address;
        this.email = email;
        this.password = password;
        this.number = number;
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
}
