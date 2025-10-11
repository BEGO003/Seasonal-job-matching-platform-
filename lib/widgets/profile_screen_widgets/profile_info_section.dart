import 'package:flutter/material.dart';
import 'package:job_seeker/widgets/profile_screen_widgets/profile_info_card.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileInfoCard(
          icon: Icons.person,
          label: 'Name',
          value: "Jon Doe",
          onSave: (String? newValue) {},
        ),
        ProfileInfoCard(
          icon: Icons.email,
          label: 'Email',
          value: "john.c.calhoun@examplepetstore.com",
          type: TextInputType.emailAddress,
          onSave: (String? newValue) {},
        ),
        ProfileInfoCard(
          icon: Icons.phone,
          label: 'Phone',
          value: "123-456-7890",
          type: TextInputType.phone,
          onSave: (String? newValue) {},
        ),
        ProfileInfoCard(
          icon: Icons.location_on,
          label: 'Location',
          value: "New York, USA",
          onSave: (String? newValue) {},
        ),
      ],
    );
  }
}
