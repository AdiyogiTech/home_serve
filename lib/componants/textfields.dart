import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final Color cursorColor;
  final Color focusBorderColor;
  final TextEditingController? controller;
  final bool obscureText;
  final int? maxLength;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    required this.cursorColor,
    required this.focusBorderColor,
    this.controller,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: cursorColor,
      obscureText: obscureText,
      maxLength: maxLength,
      onChanged: onChanged,
      onTap: onTap,

      // 🔥 APPLY HERE
      inputFormatters: inputFormatters,

      decoration: InputDecoration(
        counterText: "",
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),

        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey.shade500)
            : null,

        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: focusBorderColor),
        ),
      ),
    );
  }
}