package grad_project.seasonal_job_matching.model;



import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "Users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column//turn to UUID, review it first
    private long id;
    
    @Column(nullable = false,length = 100)
    private String name;
    
    @Column
    private String country;

    @Column(length=11)
    private String number;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @OneToMany(mappedBy = "jobposter", cascade = CascadeType.ALL)
    private List<Job> ownedjobs;
    
    @JsonIgnoreProperties
    @OneToMany(mappedBy = "id", cascade = CascadeType.ALL)
    @JoinColumn(name = "favorited_jobs", referencedColumnName = "id")
    private List<Job> favoritedjobs;
    /*
    @OneToMany(mappedBy = "id")
    private List<Application> ownedApplications;
     */

    // Default constructor required for JPA

    public User(String name, String country, String number, String email, String password){

        this.name = name;
        this.country = country;
        this.email = email;
        this.password = password;
        this.number = number;
    }


}
