import 'package:flutter/material.dart';
import 'package:job_seeker/widgets/common/gradient_background.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_crad_section.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Column(
        children: const [
          Flexible(child: JobCardSection()),
        ],
      ),
    );
  }
}
