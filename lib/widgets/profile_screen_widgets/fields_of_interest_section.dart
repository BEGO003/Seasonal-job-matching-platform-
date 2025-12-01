import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/profile_screen_services/personal_information_service.dart';
import 'package:job_seeker/widgets/common/app_card.dart';

class FieldsOfInterestSection extends ConsumerStatefulWidget {
  const FieldsOfInterestSection({super.key});

  @override
  ConsumerState<FieldsOfInterestSection> createState() =>
      _FieldsOfInterestSectionState();
}

class _FieldsOfInterestSectionState
    extends ConsumerState<FieldsOfInterestSection> {
  final TextEditingController _interestController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<String> _addedInterests = [];
  final List<String> _removedInterests = [];
  bool _isLoading = false;
  bool _isFocused = false;

  static const List<String> _popularInterests = [
    'Software Development',
    'Data Science',
    'Project Management',
    'Digital Marketing',
    'UX/UI Design',
    'Business Analysis',
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _interestController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addInterest() {
    final interest = _interestController.text.trim();
    if (interest.isEmpty) {
      _showSnackbar('Please enter an interest', isError: true);
      return;
    }

    if (interest.length > 50) {
      _showSnackbar('Interest must be 50 characters or less', isError: true);
      return;
    }

    final currentUser = ref.read(personalInformationProvider).value;
    if (currentUser == null) return;

    // Check if already exists
    if ((currentUser.fieldsOfInterest ?? []).contains(interest) ||
        _addedInterests.contains(interest)) {
      _showSnackbar('This interest already exists', isError: true);
      return;
    }

    setState(() {
      _addedInterests.add(interest);
      _removedInterests.remove(interest);
    });

    _interestController.clear();
    _focusNode.unfocus();
  }

  void _removeInterest(String interest, bool isNew) {
    setState(() {
      if (isNew) {
        _addedInterests.remove(interest);
      } else {
        _removedInterests.add(interest);
      }
    });
  }

  void _restoreInterest(String interest) {
    setState(() {
      _removedInterests.remove(interest);
    });
  }

  Future<void> _saveChanges() async {
    if (_addedInterests.isEmpty && _removedInterests.isEmpty) {
      _showSnackbar('No changes to save', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref
          .read(personalInformationServiceProvider)
          .updateFieldsOfInterest(
            fieldsOfInterestToAdd: _addedInterests,
            fieldsOfInterestToRemove: _removedInterests,
          );

      // Refresh only the fieldsOfInterest for better performance
      await ref
          .read(personalInformationProvider.notifier)
          .refreshOnlyFieldsOfInterest();

      setState(() {
        _addedInterests.clear();
        _removedInterests.clear();
      });

      _showSnackbar('Interests updated successfully');
    } catch (e) {
      _showSnackbar('Failed to update interests: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSnackbar(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor:
            isError ? const Color(0xFFDC2626) : const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildInterestChip(String interest, bool isNew, bool isRemoved) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isRemoved
            ? Colors.grey.shade100
            : isNew
                ? const Color(0xFF10B981).withOpacity(0.1)
                : const Color(0xFF3B82F6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isRemoved
              ? Colors.grey.shade400
              : isNew
                  ? const Color(0xFF10B981)
                  : const Color(0xFF3B82F6),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              interest,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isRemoved
                    ? Colors.grey.shade500
                    : isNew
                        ? const Color(0xFF10B981)
                        : const Color(0xFF3B82F6),
                decoration: isRemoved ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => isRemoved
                ? _restoreInterest(interest)
                : _removeInterest(interest, isNew),
            child: Icon(
              isRemoved ? Icons.undo : Icons.close,
              size: 14,
              color: isRemoved
                  ? Colors.grey.shade500
                  : isNew
                      ? const Color(0xFF10B981)
                      : const Color(0xFF3B82F6),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final personalInfo = ref.watch(personalInformationProvider);

    return personalInfo.when(
      data: (user) {
        final currentInterests = user.fieldsOfInterest ?? [];
        final displayInterests = [
          ...currentInterests
              .where((i) => !_removedInterests.contains(i))
              .toList(),
          ..._addedInterests,
        ];

        return AppCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input field with button
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _isFocused
                              ? const Color(0xFF3B82F6)
                              : Colors.grey.shade300,
                          width: _isFocused ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade50,
                      ),
                      child: TextField(
                        controller: _interestController,
                        focusNode: _focusNode,
                        maxLength: 50,
                        decoration: InputDecoration(
                          hintText: 'Add an interest',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          counterText: '',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                        onSubmitted: (_) => _addInterest(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _addInterest,
                        borderRadius: BorderRadius.circular(12),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Current interests
              if (displayInterests.isNotEmpty) ...[
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: displayInterests.map((interest) {
                    final isNew = _addedInterests.contains(interest);
                    final isRemoved = _removedInterests.contains(interest);
                    return _buildInterestChip(interest, isNew, isRemoved);
                  }).toList(),
                ),
              ] else
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  alignment: Alignment.center,
                  child: Text(
                    'No interests added yet',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

              // Popular interests (show when few interests)
              if (displayInterests.length < 3 && !_isFocused) ...[
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _popularInterests
                      .where((interest) => !displayInterests.contains(interest))
                      .take(4)
                      .map((interest) => OutlinedButton.icon(
                            onPressed: () {
                              _interestController.text = interest;
                              _addInterest();
                            },
                            icon: const Icon(Icons.add, size: 16),
                            label: Text(interest),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              foregroundColor: Colors.grey.shade700,
                            ),
                          ))
                      .toList(),
                ),
              ],

              // Save button
              if (_addedInterests.isNotEmpty || _removedInterests.isNotEmpty) ...[
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
      loading: () => AppCard(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor:
                const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
          ),
        ),
      ),
      error: (error, _) => AppCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red.shade400,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              'Failed to load interests',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}