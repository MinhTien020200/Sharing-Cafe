import 'package:flutter/material.dart';
import 'package:sharing_cafe/constants.dart';

class KSelectForm extends StatefulWidget {
  final String hintText;
  final List<String> options;
  const KSelectForm({
    super.key,
    required this.hintText,
    required this.options,
  });

  @override
  State<KSelectForm> createState() => _KSelectFormState();
}

class _KSelectFormState extends State<KSelectForm> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: kFormFieldColor),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        icon: const Icon(Icons.arrow_drop_down),
        hint: Text(widget.hintText),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          isDense: true,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
