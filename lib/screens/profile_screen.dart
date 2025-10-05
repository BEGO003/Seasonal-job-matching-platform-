import 'package:country_app/logic/cubit/edit_info_cubit/cubit.dart';
import 'package:country_app/logic/cubit/edit_info_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_card.dart';
import '../widgets/documents_section.dart';
import '../widgets/account_settings_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditInfoCubit(),
      child: const ProfileScreenContent(),
    );
  }
}

class ProfileScreenContent extends StatelessWidget {
  const ProfileScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditInfoCubit, EditInfoStates>(
      builder: (context, state) {
        final cubit = context.read<EditInfoCubit>();
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ProfileHeader(name: cubit.personalInformationModel.name),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Information',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    ProfileInfoCard(
                      icon: Icons.person_outline,
                      label: 'Name',
                      value: cubit.personalInformationModel.name,
                    ),
                    const SizedBox(height: 12),
                    ProfileInfoCard(
                      icon: Icons.phone_outlined,
                      label: 'Phone',
                      value: cubit.personalInformationModel.phone,
                      // context: context,
                      type: TextInputType.phone,
                      //editFunction: () {},
                    ),
                    const SizedBox(height: 12),
                    ProfileInfoCard(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: cubit.personalInformationModel.email,
                      //editFunction: () {},
                      // context: context,
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    ProfileInfoCard(
                      icon: Icons.location_on_outlined,
                      label: 'Country',
                      value: cubit.personalInformationModel.country,
                      // context: context,
        
                      //editFunction: () {},
                    ),
                    const SizedBox(height: 32),
                    const DocumentsSection(),
                    const SizedBox(height: 32),
                    const AccountSettingsSection(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
