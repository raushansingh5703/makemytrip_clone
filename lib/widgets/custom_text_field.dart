import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final InputBorder? border;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onToggleVisibility;

  const CustomTextField({
    this.border,
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.onToggleVisibility,this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        border: border,
        labelText: labelText,
        hintText: hintText,
        suffixIcon: onToggleVisibility != null
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: onToggleVisibility,
        )
            : null,
      ),
    );
  }
}