import 'package:flutter/material.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_crad_section.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/jobs_search_header.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search and Filter Header
        const JobsSearchHeader(),

        // Job Cards Section
        const Expanded(child: JobCardSection()),
      ],
    );
  }
}
