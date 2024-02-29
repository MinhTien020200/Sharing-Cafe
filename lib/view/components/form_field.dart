import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';

class KFormField extends StatelessWidget {
  final String? hintText;
  const KFormField({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kFormFieldColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.all(16),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
        onChanged: (value) {
          // Update event name
        },
      ),
    );
  }
}
