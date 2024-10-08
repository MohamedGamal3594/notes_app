import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.maxLines = 1,
  });
  final String label;
  final int maxLines;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kPrimaryColor,
      maxLines: maxLines,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: kPrimaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(kPrimaryColor),
      ),
    );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(
        color: color ?? Colors.white,
      ),
    );
  }
}
