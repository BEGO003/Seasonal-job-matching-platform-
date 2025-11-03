import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/constants/constants.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/widgets/common/app_card.dart';

class ProfileInfoCard extends ConsumerWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Function(String, WidgetRef)? onSave;
  final TextInputType type;

  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.onSave,
    this.type = TextInputType.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(personalInformationProvider);
    return asyncData.when(
      loading: () => _buildCard(context, isLoading: true, onTap: null),
      error: (error, stackTrace) {
        debugPrint('Profile info error: $error');
        return _buildCard(context, isLoading: false, onTap: null);
      },
      data: (data) => _buildCard(
        context,
        isLoading: false,
        onTap: onSave != null ? () => _showEditDialog(context, ref) : null,
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required VoidCallback? onTap,
    required bool isLoading,
  }) {
    final theme = Theme.of(context);

    return AppCard(
      onTap: onTap,
      interactive: onTap != null,
      padding: const EdgeInsets.all(16),
      borderRadius: 12,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value ?? 'Not set',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              if (onTap != null) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ],
            ],
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController(text: value);
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);

    String? selectedCountry = value;

    String? validateInput(String? value) {
      if (value == null || value.trim().isEmpty) {
        return 'This field cannot be empty';
      }

      switch (label) {
        case 'Name':
          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
            return 'Name can only contain letters';
          }
          break;
        case 'Phone':
          if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(value)) {
            return 'Please enter a valid phone number';
          }
          break;
        case 'Email':
          if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          break;
      }
      return null;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit $label',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Form(
                  key: formKey,
                  child: label == 'Country'
                      ? StatefulBuilder(
                          builder: (context, setState) {
                            return DropdownButtonFormField<String>(
                              value: selectedCountry,
                              decoration: InputDecoration(
                                labelText: label,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: Icon(icon),
                              ),
                              isExpanded: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a country';
                                }
                                return null;
                              },
                              items: countryList.map((String country) {
                                return DropdownMenuItem<String>(
                                  value: country,
                                  child: Text(country),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCountry = newValue;
                                });
                              },
                            );
                          },
                        )
                      : TextFormField(
                          controller: controller,
                          keyboardType: type,
                          autofocus: true,
                          validator: validateInput,
                          decoration: InputDecoration(
                            labelText: label,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(icon),
                          ),
                        ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final valueToSave = label == 'Country'
                                ? selectedCountry!
                                : controller.text;
                            try {
                              Navigator.of(context).pop();
                              await onSave!(valueToSave, ref);
                            } on Exception catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          }
                        },
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}