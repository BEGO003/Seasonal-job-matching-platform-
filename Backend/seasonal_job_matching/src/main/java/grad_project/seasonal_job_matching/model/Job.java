package grad_project.seasonal_job_matching.model;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "Jobs")
public class Job {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private int id;

    @Column
    @NotBlank
    private String title;

    @Column
    private String description;

    @Column
    @NotBlank
    private JobType type;

    @Column
    private String location;

    @Column
    private Date startDate;

    @Column
    private Date endDate;

    @ManyToOne
    @NotBlank
    @JoinColumn(name = "userID", referencedColumnName = "id", foreignKey = @ForeignKey(name="fk_ob_user"))// foreign key from user table
    private User user;

    @Column
    private float salary;

    @Column
    @NotBlank
    private JobStatus status;

    @Column
    private int numofpositions;

    public Job(int id, String title, String description, JobType type, String location, Date startDate, Date endDate, User user, float salary, int numofpositions, JobStatus status){
        this.id = id;
        this.title = title;
        this.description = description;
        this.type = type;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.user = user;
        this.salary = salary;
        this.numofpositions = numofpositions;
        this.status = status;
    }
    //create setters and getters
}
