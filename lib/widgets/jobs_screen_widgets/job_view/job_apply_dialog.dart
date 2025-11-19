import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_apply_provider.dart';

Future<void> showJobApplyDialog(
  BuildContext context,
  WidgetRef ref,
  int jobId,
) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => _JobApplyDialog(jobId: jobId),
  );
}

class _JobApplyDialog extends ConsumerStatefulWidget {
  final int jobId;

  const _JobApplyDialog({required this.jobId});

  @override
  ConsumerState<_JobApplyDialog> createState() => _JobApplyDialogState();
}

class _JobApplyDialogState extends ConsumerState<_JobApplyDialog> {
  late final TextEditingController _controller;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    try {
      await ref.read(applyControllerProvider.notifier).apply(
            jobId: widget.jobId.toString(),
            description: _controller.text.trim(),
          );

      if (mounted && context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Application submitted successfully.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final applyState = ref.watch(applyControllerProvider);
    final isLoading = applyState.isLoading;

    return PopScope(
      canPop: !isLoading,
      child: AlertDialog(
        title: const Text('Apply for this job'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            maxLines: 5,
            enabled: !isLoading,
            decoration: InputDecoration(
              labelText: 'Describe yourself',
              hintText: 'Tell the employer why you are a great fit...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              alignLabelWithHint: true,
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'Description cannot be empty';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: isLoading ? null : () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: isLoading ? null : _handleSubmit,
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}