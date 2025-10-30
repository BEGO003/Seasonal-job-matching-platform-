import 'package:flutter/material.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _educationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _certificatesController = TextEditingController();
  final _skillsController = TextEditingController();
  final _languagesController = TextEditingController();

  @override
  void dispose() {
    _educationController.dispose();
    _experienceController.dispose();
    _certificatesController.dispose();
    _skillsController.dispose();
    _languagesController.dispose();
    super.dispose();
  }

  void _saveResume() {
    if (_formKey.currentState!.validate()) {
      // Add your save logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resume saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                  hint: 'Enter your education details',
                  maxLines: 4,
                ),
                const SizedBox(height: 24),
                
                _buildSectionTitle('Experience'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _experienceController,
                  label: 'Experience',
                  hint: 'Enter your work experience',
                  maxLines: 5,
                ),
                const SizedBox(height: 24),
                
                _buildSectionTitle('Certificates'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _certificatesController,
                  label: 'Certificates',
                  hint: 'Enter your certificates',
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                
                _buildSectionTitle('Skills'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _skillsController,
                  label: 'Skills',
                  hint: 'Enter your skills',
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                
                _buildSectionTitle('Languages'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _languagesController,
                  label: 'Languages',
                  hint: 'Enter languages you speak',
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
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        alignLabelWithHint: true,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}