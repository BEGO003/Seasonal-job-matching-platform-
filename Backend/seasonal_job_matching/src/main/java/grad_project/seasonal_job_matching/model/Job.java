package grad_project.seasonal_job_matching.model;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import grad_project.seasonal_job_matching.model.enums.JobStatus;
import grad_project.seasonal_job_matching.model.enums.JobType;
import grad_project.seasonal_job_matching.model.enums.WorkArrangement;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Jobs")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Job {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private long id;

    @Column(nullable = false)
    private String title;

    @Column
    private String description;

    @Column
    private JobType type;

    @Column(nullable = false)
    private String location;

    @Column
    private Date startDate;

    @Column
    private Date endDate;

    @ManyToOne
    @JoinColumn(name = "jobposterID", nullable = false, referencedColumnName = "id")// foreign key from user table
    //@Column
    @JsonIgnoreProperties({"ownedJobs", "password","ownedApplications"}) //to prevent infinite loop of getting user and all his info and then getting all of users jobs which is this one and so on
    private User jobPoster;

    @Column
    private float salary;

    @Column(nullable = false)
    private JobStatus status;

    @Column
    private int numofpositions;

    @Column
    private WorkArrangement workarrangement;

    // Add to job table
    @OneToMany(mappedBy="job", cascade = CascadeType.ALL) //job has many applications
    @JsonIgnoreProperties("job")
    private List<Application> listofJobApplications;
    
    @Column
    private List<String> requirements;

    @Column
    private List<String> categories;

    @Column
    private List<String> benefits;

    public Job(int id, String title, String description, JobType type, String location, Date startDate, Date endDate, User jobposter, float salary, int numofpositions, JobStatus status, WorkArrangement workarrangement){
        this.id = id;
        this.title = title;
        this.description = description;
        this.type = type;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.jobPoster = jobposter;
        this.salary = salary;
        this.numofpositions = numofpositions;
        this.status = status;
        this.workarrangement = workarrangement;
    }
    
}
