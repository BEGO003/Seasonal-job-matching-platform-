import 'package:flutter/material.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_crad_section.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Modern Header
        // Container(
        //   padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //       colors: [
        //         const Color(0xFF3B82F6),
        //         const Color(0xFF2563EB),
        //       ],
        //     ),
        //   ),
        //   child: SafeArea(
        //     bottom: false,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   'Find Your',
        //                   style: TextStyle(
        //                     fontSize: 16,
        //                     color: Colors.white.withOpacity(0.9),
        //                     fontWeight: FontWeight.w500,
        //                   ),
        //                 ),
        //                 const SizedBox(height: 4),
        //                 const Text(
        //                   'Dream Job',
        //                   style: TextStyle(
        //                     fontSize: 32,
        //                     color: Colors.white,
        //                     fontWeight: FontWeight.w700,
        //                     letterSpacing: -0.5,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             Container(
        //               padding: const EdgeInsets.all(12),
        //               decoration: BoxDecoration(
        //                 color: Colors.white.withOpacity(0.2),
        //                 borderRadius: BorderRadius.circular(12),
        //               ),
        //               child: const Icon(
        //                 Icons.work_outline,
        //                 color: Colors.white,
        //                 size: 28,
        //               ),
        //             ),
        //           ],
        //         ),
        //         const SizedBox(height: 16),
        //         Text(
        //           'Explore opportunities that match your skills',
        //           style: TextStyle(
        //             fontSize: 15,
        //             color: Colors.white.withOpacity(0.85),
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        
        // Job Cards Section
        const Expanded(
          child: JobCardSection(),
        ),
      ],
    );
  }
}