import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/widgets/common/async_value_view.dart';
import 'package:job_seeker/widgets/profile_screen_widgets/profile_info_card.dart';

class ProfileInfoSection extends ConsumerWidget {
  const ProfileInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalInfo = ref.watch(personalInformationProvider);
    return AsyncValueView(
      value: personalInfo,
      data: (data) => Column(
        children: [
          ProfileInfoCard(
            icon: Icons.person,
            label: 'Name',
            value: data.name,
            onSave: (String? newValue, WidgetRef ref) => ref
                .read(personalInformationProvider.notifier)
                .updateName(newValue!),
          ),
          ProfileInfoCard(
            icon: Icons.email,
            label: 'Email',
            value: data.email,
            type: TextInputType.emailAddress,
            onSave: (String? newValue, WidgetRef ref) => ref
                .read(personalInformationProvider.notifier)
                .updateEmail(newValue!),
          ),
          ProfileInfoCard(
            icon: Icons.phone,
            label: 'Phone',
            value: data.number,
            type: TextInputType.phone,
            onSave: (String? newValue, WidgetRef ref) => ref
                .read(personalInformationProvider.notifier)
                .updatePhone(newValue!),
          ),
          ProfileInfoCard(
            icon: Icons.location_on,
            label: 'Country',
            value: data.country,
            onSave: (String? newValue, WidgetRef ref) => ref
                .read(personalInformationProvider.notifier)
                .updateCountry(newValue!),
          ),
        ],
      ),
    );
  }
}
