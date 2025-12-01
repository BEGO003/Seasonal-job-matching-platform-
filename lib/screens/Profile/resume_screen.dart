import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/profile_screen_providers/resume_provider.dart';
import 'package:job_seeker/models/profile_screen_models/resume_model.dart';

class ResumeScreen extends ConsumerStatefulWidget {
  const ResumeScreen({super.key});

  @override
  ConsumerState<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends ConsumerState<ResumeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _educationController;
  late TextEditingController _experienceController;
  late TextEditingController _certificatesController;
  late TextEditingController _skillsController;
  late TextEditingController _languagesController;
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    _educationController = TextEditingController();
    _experienceController = TextEditingController();
    _certificatesController = TextEditingController();
    _skillsController = TextEditingController();
    _languagesController = TextEditingController();
  }

  @override
  void dispose() {
    _educationController.dispose();
    _experienceController.dispose();
    _certificatesController.dispose();
    _skillsController.dispose();
    _languagesController.dispose();
    super.dispose();
  }

  void _populateFields(ResumeModel resume) {
    _educationController.text = resume.education.join('\n');
    _experienceController.text = resume.experience.join('\n');
    _certificatesController.text = resume.certificates.join('\n');
    _skillsController.text = resume.skills.join('\n');
    _languagesController.text = resume.languages.join('\n');
  }

  Future<void> _saveResume() async {
    if (_formKey.currentState!.validate()) {
      final education = _educationController.text
          .split('\n')
          .where((s) => s.trim().isNotEmpty)
          .map((s) => s.trim())
          .toList();
      final experience = _experienceController.text
          .split('\n')
          .where((s) => s.trim().isNotEmpty)
          .map((s) => s.trim())
          .toList();
      final certificates = _certificatesController.text
          .split('\n')
          .where((s) => s.trim().isNotEmpty)
          .map((s) => s.trim())
          .toList();
      final skills = _skillsController.text
          .split('\n')
          .where((s) => s.trim().isNotEmpty)
          .map((s) => s.trim())
          .toList();
      final languages = _languagesController.text
          .split('\n')
          .where((s) => s.trim().isNotEmpty)
          .map((s) => s.trim())
          .toList();

      final currentResume = ref.read(resumeProvider).value;
      if (currentResume == null) return;

      final educationToRemove = currentResume.education
          .where((e) => !education.contains(e))
          .toList();
      final educationToAdd = education
          .where((e) => !currentResume.education.contains(e))
          .toList();

      final experienceToRemove = currentResume.experience
          .where((e) => !experience.contains(e))
          .toList();
      final experienceToAdd = experience
          .where((e) => !currentResume.experience.contains(e))
          .toList();

      final certificatesToRemove = currentResume.certificates
          .where((e) => !certificates.contains(e))
          .toList();
      final certificatesToAdd = certificates
          .where((e) => !currentResume.certificates.contains(e))
          .toList();

      final skillsToRemove = currentResume.skills
          .where((e) => !skills.contains(e))
          .toList();
      final skillsToAdd = skills
          .where((e) => !currentResume.skills.contains(e))
          .toList();

      final languagesToRemove = currentResume.languages
          .where((e) => !languages.contains(e))
          .toList();
      final languagesToAdd = languages
          .where((e) => !currentResume.languages.contains(e))
          .toList();

      try {
        await ref
            .read(resumeProvider.notifier)
            .updateResume(
              educationToAdd: educationToAdd,
              educationToRemove: educationToRemove,
              experienceToAdd: experienceToAdd,
              experienceToRemove: experienceToRemove,
              certificatesToAdd: certificatesToAdd,
              certificatesToRemove: certificatesToRemove,
              skillsToAdd: skillsToAdd,
              skillsToRemove: skillsToRemove,
              languagesToAdd: languagesToAdd,
              languagesToRemove: languagesToRemove,
            );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Resume saved successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error saving resume: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final resumeState = ref.watch(resumeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveResume,
            tooltip: 'Save',
          ),
        ],
      ),
      body: resumeState.when(
        data: (resume) {
          if (resume == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No resume found.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(resumeProvider.notifier).createResume();
                    },
                    child: const Text('Create Resume'),
                  ),
                ],
              ),
            );
          }

          if (!_dataLoaded) {
            _populateFields(resume);
            _dataLoaded = true;
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Education'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _educationController,
                      label: 'Education',
                      hint: 'Enter your education details (one per line)',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Experience'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _experienceController,
                      label: 'Experience',
                      hint: 'Enter your work experience (one per line)',
                      maxLines: 5,
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Certificates'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _certificatesController,
                      label: 'Certificates',
                      hint: 'Enter your certificates (one per line)',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Skills'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _skillsController,
                      label: 'Skills',
                      hint: 'Enter your skills (one per line)',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Languages'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _languagesController,
                      label: 'Languages',
                      hint: 'Enter languages you speak (one per line)',
                      maxLines: 2,
                    ),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveResume,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Save Resume',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required int maxLines,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: 'Separate each item with a new line',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        alignLabelWithHint: true,
      ),
      // Validator is optional now as fields can be empty
    );
  }
}
