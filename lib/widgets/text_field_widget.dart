import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator validator;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    required this.keyboardType,
    required this.obscureText,
    required this.controller, required this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.obscureText && !isPasswordVisible,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    if (widget.obscureText) {
                      setState(() => isPasswordVisible = !isPasswordVisible);
                    }
                  },
                  icon: Icon(isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                )
              : null,
          prefixIcon: Icon(widget.prefixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
