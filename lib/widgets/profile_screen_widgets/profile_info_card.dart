import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/constants/constants.dart';
import 'package:job_seeker/providers/personal_information_notifier.dart';

class ProfileInfoCard extends ConsumerWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Function(String, WidgetRef)? onSave;
  final TextInputType type;
  // final WidgetRef ref;

  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.onSave,
    this.type = TextInputType.text,
  });

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController(text: value);
    final formKey = GlobalKey<FormState>();

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
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text('Edit $label'),
          content: Form(
            key: formKey,
            child: label == 'Country'
                ? StatefulBuilder(
                    builder: (context, setState) {
                      return DropdownButtonFormField<String>(
                        initialValue: selectedCountry,
                        decoration: InputDecoration(
                          labelText: label,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
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
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: Icon(icon),
                    ),
                  ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FilledButton(
              child: const Text('Save'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final valueToSave = label == 'Country'
                      ? selectedCountry!
                      : controller.text;
                  try {
                    // make it required
                    Navigator.of(context).pop();
                    await onSave!(valueToSave, ref);
                    // if (context.mounted) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: const Text('Updated successfully!'),
                    //       backgroundColor: Colors.green,
                    //     ),
                    //   );
                    // }
                  } on Exception catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error : $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(personalInformationProvider);
    return asyncData.when(
      loading: () => buildCard(context, isLoading: true, onTap: null),
      error: (error, stackTrace) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("Error : $error"),
        //     backgroundColor: Colors.red,
        //   ),
        // );
        debugPrint(
          'This is the error ---------------------------------------------------------- $error',
        );
        return const Center(child: CircularProgressIndicator());
      },

      data: (data) => buildCard(
        context,
        isLoading: false,
        onTap: () => _showEditDialog(context, ref),
      ),
    );
  }

  Widget buildCard(
    BuildContext context, {
    required VoidCallback? onTap,
    required bool isLoading,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: .1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),

                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: colorScheme.primary.withValues(
                        alpha: .1,
                      ),
                      foregroundColor: colorScheme.primary,
                      child: Icon(icon, size: 22),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (value != null && value!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                value!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (onSave != null)
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .3),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
