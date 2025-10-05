import 'package:country_app/logic/cubit/edit_info_cubit/cubit.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/app_colors.dart';

class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final TextInputType type;
  Country? countryChosen;

   ProfileInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.type = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => _showEditDialog(context),
              color: AppColors.primary,
              iconSize: 20,
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }

  void showCounrty(context) => showCountryPicker(
    context: context,
    countryListTheme: CountryListThemeData(
      flagSize: 25,
      backgroundColor: Colors.white,
      textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
      bottomSheetHeight: 500, // Optional. Country list modal height
      //Optional. Sets the border radius for the bottomsheet.
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      //Optional. Styles the search field.
      inputDecoration: InputDecoration(
        labelText: 'Search',
        hintText: 'Start typing to search',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFF8C98A8).withValues(alpha: .2),
          ),
        ),
      ),
    ),
    onSelect: (Country country) {
      print('Select country: ${country.displayName}');
      countryChosen = country;
    },
  );

  void _showEditDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: value);
    final formKey = GlobalKey<FormState>();

    
    final countries = [
      'United States',
      'UK',
      'Canada',
      'Australia',
      'Germany',
      'France',
    ]; // Add more countries as needed

    String? validateInput(String? value) {
      if (value == null || value.isEmpty) {
        return 'This field cannot be empty';
      }
      switch (label) {
        case 'Name':
          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
            return 'Name can only contain letters';
          }
          break;
        case 'Phone':
          if (!RegExp(r'^\d+$').hasMatch(value)) {
            return 'Phone can only contain numbers';
          }
          break;
        case 'Email':
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          break;
      }
      return null;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Edit $label',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                if (label != 'Country')
                  TextFormField(
                    controller: controller,
                    keyboardType: type,
                    validator: validateInput,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter new $label',
                      errorStyle: const TextStyle(color: Colors.red),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: () => showCounrty(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: controller,
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Select Country',
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Please select a country' : null,
                      ),
                    ),
                  ),
                  // DropdownButtonFormField<String>(
                  //   // initialValue: 'USA',
                  //   initialValue: value,
                  //   validator: (value) => value == null ? 'Please select a country' : null,
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.grey[100],
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //   ),
                  //   items: countries.map((String country) {
                  //     return DropdownMenuItem<String>(
                  //       value: country,
                  //       child: Text(country),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? newValue) {
                  //     if (newValue != null) {
                  //       controller.text = newValue;
                  //     }
                  //   },
                  // ),
                  const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<EditInfoCubit>().changeFiledValue(
                            label,
                            controller.text,
                          );
                          Navigator.pop(dialogContext);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
