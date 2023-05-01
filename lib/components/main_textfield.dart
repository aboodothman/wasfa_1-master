import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    super.key,
    required this.hintText,
    required this.keyboard,
    required this.obscure,
    required this.style,
    required this.controller,
  });

  final String hintText;
  final TextInputType keyboard;
  final TextEditingController controller;
  final bool obscure;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      obscureText: obscure,
      keyboardType: keyboard,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color(0xFF657075),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black87,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        hintText: hintText,
      ),
      style: style,
    );
  }
}


class MainTextFormField extends StatelessWidget {
  const MainTextFormField({
    super.key,
    required this.hintText,
    required this.keyboard,
    required this.obscure,
    required this.style,
    required this.controller,
    required this.validator
  });

  final String hintText;
  final TextInputType keyboard;
  final TextEditingController controller;
  final bool obscure;
  final TextStyle style;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      textAlign: TextAlign.left,
      obscureText: obscure,
      keyboardType: keyboard,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color(0xFF657075),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black87,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        hintText: hintText,
      ),
      style: style,
    );
  }
}
