import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/constants/constants.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';

class ProfileInfoCard extends ConsumerStatefulWidget {
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
  ConsumerState<ProfileInfoCard> createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends ConsumerState<ProfileInfoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getIconColor() {
    switch (widget.label) {
      case 'Name':
        return const Color(0xFF3B82F6);
      case 'Email':
        return const Color(0xFFEC4899);
      case 'Phone':
        return const Color(0xFF10B981);
      case 'Country':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF6B7280);
    }
  }

  void _showEditDialog(BuildContext context) {
    final controller = TextEditingController(text: widget.value);
    final formKey = GlobalKey<FormState>();
    String? selectedCountry = widget.value;

    String? validateInput(String? value) {
      if (value == null || value.trim().isEmpty) {
        return 'This field cannot be empty';
      }

      switch (widget.label) {
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

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Edit ${widget.label}',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: FadeTransition(
            opacity: animation,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                constraints: const BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _getIconColor().withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                widget.icon,
                                color: _getIconColor(),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                'Edit ${widget.label}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.grey.shade600),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Form(
                          key: formKey,
                          child: widget.label == 'Country'
                              ? StatefulBuilder(
                                  builder: (context, setState) {
                                    return DropdownButtonFormField<String>(
                                      value: selectedCountry,
                                      decoration: InputDecoration(
                                        labelText: widget.label,
                                        filled: true,
                                        fillColor: Colors.grey.shade50,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide(
                                            color: _getIconColor(),
                                            width: 2,
                                          ),
                                        ),
                                        prefixIcon: Icon(
                                          widget.icon,
                                          color: _getIconColor(),
                                        ),
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
                                  keyboardType: widget.type,
                                  autofocus: true,
                                  validator: validateInput,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    labelText: widget.label,
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                        color: _getIconColor(),
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFEF4444),
                                        width: 2,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFEF4444),
                                        width: 2,
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      widget.icon,
                                      color: _getIconColor(),
                                    ),
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
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  side: BorderSide(color: Colors.grey.shade300),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final valueToSave = widget.label == 'Country'
                                        ? selectedCountry!
                                        : controller.text;
                                    try {
                                      Navigator.of(context).pop();
                                      await widget.onSave!(valueToSave, ref);
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: [
                                                const Icon(
                                                  Icons.check_circle,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(width: 12),
                                                Text(
                                                  '${widget.label} updated successfully!',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: const Color(0xFF10B981),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            margin: const EdgeInsets.all(16),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: [
                                                const Icon(
                                                  Icons.error_outline,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Text(
                                                    'Error: $e',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: const Color(0xFFEF4444),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            margin: const EdgeInsets.all(16),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _getIconColor(),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check, size: 18),
                                    SizedBox(width: 8),
                                    Text(
                                      'Save Changes',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(personalInformationProvider);
    
    return asyncData.when(
      loading: () => _buildCard(context, isLoading: true, onTap: null),
      error: (error, stackTrace) {
        debugPrint('Profile card error: $error');
        return _buildCard(context, isLoading: false, onTap: null);
      },
      data: (data) => _buildCard(
        context,
        isLoading: false,
        onTap: widget.onSave != null ? () => _showEditDialog(context) : null,
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required VoidCallback? onTap,
    required bool isLoading,
  }) {
    final iconColor = _getIconColor();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTapDown: onTap != null ? (_) => _controller.forward() : null,
        onTapUp: onTap != null
            ? (_) {
                _controller.reverse();
                onTap();
              }
            : null,
        onTapCancel: onTap != null ? () => _controller.reverse() : null,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.icon,
                        color: iconColor,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.label,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.value ?? 'Not set',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2937),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (widget.onSave != null)
                      Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                  ],
                ),
              ),
              if (isLoading)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}