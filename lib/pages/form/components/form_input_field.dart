import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';

class FormInputField extends ConsumerWidget {
  final String description;
  final bool isRequired;
  final void Function(String?)? onChanged;
  const FormInputField({
    super.key,
    required this.description,
    this.isRequired = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultContentPadding),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            label: RichText(
              text: TextSpan(
                text: description,
                children: [
                  if (isRequired)
                    const TextSpan(
                        text: " *",
                        style: TextStyle(color: Colors.red, fontSize: 15))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
