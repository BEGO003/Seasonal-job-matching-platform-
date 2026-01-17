package grad_project.seasonal_job_matching.model;

import java.util.List;

import jakarta.persistence.ElementCollection;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // getters,setters, required args constructor
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "\"Resume\"")
public class Resume {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(columnDefinition = "text[]", nullable = false)
    private List<String> education = new ArrayList<>();

    @Column(columnDefinition = "text[]", nullable = false)
    private List<String> experience = new ArrayList<>();

    @Column(columnDefinition = "text[]", nullable = false)
    private List<String> certificates = new ArrayList<>();

    @Column(columnDefinition = "text[]", nullable = false)
    private List<String> skills = new ArrayList<>();

    @Column(columnDefinition = "text[]", nullable = false)
    private List<String> languages = new ArrayList<>();

    // @Column
    // @OneToOne(mappedBy="resume")//to avoid doing another table and keeping things
    // bidirectional, if you have a resume, you can go back to the user
    // private User user;// could be unnecessary and this could be removed though
    // and its removed in the db schema,this will cause me to keep only the column
    // in user, i removed it but ask Omar's opinion.
    // because employer has applications, if they want user info, they can get
    // userid from application, they dont need to go to resume to get userid.
}