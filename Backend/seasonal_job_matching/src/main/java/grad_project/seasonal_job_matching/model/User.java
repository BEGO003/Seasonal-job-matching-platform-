package grad_project.seasonal_job_matching.model;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
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
@JsonIgnoreProperties("favoriteJobIds")
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column // turn to UUID, review it first
    private long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column
    private String country;

    @Column
    private String number;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @JsonIgnoreProperties("jobPoster")
    @OneToMany(mappedBy = "jobPoster", cascade = CascadeType.ALL)
    private List<Job> ownedJobs;

    @JsonIgnoreProperties("user")
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL) // user has many application
    private List<Application> ownedApplications;

    @Column(columnDefinition = "text[]")
    private List<String> fieldsOfInterest = new ArrayList<>();

    @OneToOne(fetch = FetchType.LAZY, optional = true, cascade = CascadeType.ALL) // user has one resume, might change
                                                                                  // later on
    @JoinColumn(name = "resume_id", referencedColumnName = "id") // foreign key from user table
    private Resume resume;

    @JsonIgnoreProperties({ "jobPoster", "listOfJobApplications" })
    @ManyToMany
    @JoinTable( // creates a new table that stores this because cant have a onetomany
                // relationship between user and job without creating an inverse side in the job
                // class
            name = "user_favorite_jobs", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "job_id"))
    private Set<Job> favoriteJobs = new HashSet<>(); // faster operations on hashlist

    // Default constructor required for JPA
    public User(String name, String country, String number, String email, String password) {

        this.name = name;
        this.country = country;
        this.email = email;
        this.password = password;
        this.number = number;
    }

}
