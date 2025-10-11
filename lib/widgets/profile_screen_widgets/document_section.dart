import 'package:flutter/material.dart';
import 'package:job_seeker/widgets/profile_screen_widgets/document_card.dart';

class DocumentSection extends StatelessWidget {
  const DocumentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DocumentCard(
          icon:  Icons.description_outlined,
          title: 'Resume / CV',
        ),
        const SizedBox(height: 10,),
        DocumentCard(
          icon: Icons.article_outlined,
          title: 'Cover Letter',
        ),
      ],
    );
  }
}



