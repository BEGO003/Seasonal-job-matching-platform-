package grad_project.seasonal_job_matching.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import grad_project.seasonal_job_matching.model.Resume;
import grad_project.seasonal_job_matching.model.User;
import grad_project.seasonal_job_matching.repository.UserRepository;
import jakarta.transaction.Transactional;
import grad_project.seasonal_job_matching.repository.ResumeRepository;
import grad_project.seasonal_job_matching.mapper.ResumeMapper;
import grad_project.seasonal_job_matching.dto.responses.ResumeResponseDTO;
import grad_project.seasonal_job_matching.dto.requests.ResumeCreateDTO;
import grad_project.seasonal_job_matching.dto.requests.ResumeEditDTO;


@Service
public class ResumeService {
    
    
    //public final List<Resume> resumes = new ArrayList<>();
    private final UserRepository userRepository;
    private final ResumeRepository resumeRepository;
    
    @Autowired
    private ResumeMapper resumeMapper;

    public ResumeService(ResumeRepository resumeRepository, UserRepository userRepository){
        this.userRepository = userRepository;
        this.resumeRepository = resumeRepository;
    }

    //could be deleted, i dont think we need to get all resumes at any point
    // public List<ResumeResponseDTO> findAllResumes(){
    //     return resumeRepository.findAll()
    //     .stream()
    //     .map(resumeMapper::maptoreturnResume)
    //     .collect(Collectors.toList());
    // }

    //FUNCTION ON HOLD UNTIL SESSION/COOKIES/SECURITY is applied
    public Optional<ResumeResponseDTO> findResumeByUserId(long userId) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));
        Resume resume = user.getResume(); 
        
        if (resume == null) {
            throw new RuntimeException("User has no linked resume.");
        }
        //in job service, we dont write optional.of because findbyid returns optional and so mapper returns optional jobresponsedto
        //while here, the optional chain is cut of so mapping doesnt return optional so we have to typecast it
        //probably when adding sessions and cookies, this function will change, or maybe the only thing will change will be in the 
        //controller layer and instead of taking pathvariable, id will be taken from session and function stays the same
        return Optional.of(resumeMapper.maptoreturnResume(resume));
    }


    //this function takes id from url OF user which isnt the best practice but until i do session security to get user id from session and then take resume from it
    @Transactional
    public ResumeResponseDTO createResume(ResumeCreateDTO dto, long userId) { //does it need any validation like unique user email?
        //get user from id given in url
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        Resume resume = resumeMapper.maptoAddResume(dto);
        Resume savedResume = resumeRepository.save(resume);
        user.setResume(savedResume);
        userRepository.save(user);//because we updated it
        return resumeMapper.maptoreturnResume(savedResume);

    }

    public ResumeResponseDTO editResume(ResumeEditDTO dto, long userId){ 
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        
        Resume existingResume = user.getResume();

        // This single line handles certificates, education, experience, and languages.
        // If the DTO field is null (omitted in JSON), the existing value remains unchanged.
        resumeMapper.maptoEditResume(dto,existingResume);

        // Initialize skills list if null
        if (existingResume.getSkills() == null) {
            existingResume.setSkills(new ArrayList<>());
        }

        // //if field thats updated is certificates and new certificates field isn't empty
        // if(updatedResume.getCertificates() != null){
        //     existingResume.setCertificates(updatedResume.getCertificates());
        // }

        // //update education
        // if (updatedResume.getEducation() != null) {
        //     existingResume.setEducation(updatedResume.getEducation());
        // }

        // //update experience
        // if (updatedResume.getExperience() != null) {
        //     existingResume.setExperience(updatedResume.getExperience());
        // }

        // //add salary, checks if salary is updated
        // if (updatedResume.getLanguages() != null) {
        //     existingResume.setLanguages(updatedResume.getLanguages());
        // }

        if (dto.getSkillsToAdd() != null) {
            for (String skill : dto.getSkillsToAdd()) {
                if (!existingResume.getSkills().contains(skill)) {
                    existingResume.getSkills().add(skill);
                }
            }
        }

        // Remove skills
        if (dto.getSkillsToRemove() != null) {
            existingResume.getSkills().removeAll(dto.getSkillsToRemove());
        }

        Resume savedResume = resumeRepository.save(existingResume);
        return resumeMapper.maptoreturnResume(savedResume);

    }


    public void deleteResume(Long userId){
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));
        Resume resumeToDelete = user.getResume();
        if (resumeToDelete != null) {
            user.setResume(null);
            userRepository.save(user);
            resumeRepository.deleteById(resumeToDelete.getId());
        }
    }

}
