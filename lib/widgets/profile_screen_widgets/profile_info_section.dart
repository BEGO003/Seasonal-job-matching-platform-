import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/personal_information_notifier.dart';
import 'package:job_seeker/widgets/profile_screen_widgets/profile_info_card.dart';

class ProfileInfoSection extends ConsumerWidget {
  const ProfileInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ProfileInfoCard(
          icon: Icons.person,
          label: 'Name',
          value: ref.watch(personalInformationProvider).value?.name,
          onSave: (String? newValue, WidgetRef ref) => ref
              .read(personalInformationProvider.notifier)
              .updateName(newValue!),
          // refAbove: ref,
        ),
        ProfileInfoCard(
          icon: Icons.email,
          label: 'Email',
          value: ref.watch(personalInformationProvider).value?.email,
          type: TextInputType.emailAddress,
          onSave: (String? newValue, WidgetRef ref) => ref
              .read(personalInformationProvider.notifier)
              .updateEmail(newValue!),
          // refAbove: ref,
        ),
        ProfileInfoCard(
          icon: Icons.phone,
          label: 'Phone',
          value: ref.watch(personalInformationProvider).value?.number,
          type: TextInputType.phone,
          onSave: (String? newValue, WidgetRef ref) => ref
              .read(personalInformationProvider.notifier)
              .updatePhone(newValue!),
          // refAbove: ref,
        ),
        ProfileInfoCard(
          icon: Icons.location_on,
          label: 'Country',
          value: ref.watch(personalInformationProvider).value?.country,
          onSave: (String? newValue, WidgetRef ref) => ref
              .read(personalInformationProvider.notifier)
              .updateCountry(newValue!),
          // refAbove: ref,
        ),
      ],
    );
  }
}
