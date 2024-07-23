import 'package:flutter/material.dart';
import 'package:flutter_translate/static/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool readOnly;
  final double textSize; // Added for text size adjustment
  final String fontStyle; // Added for font style adjustment

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.readOnly = false,
    this.textSize = 20.0, // Default text size
    this.fontStyle = 'Normal', // Default font style
  });

  @override
  Widget build(BuildContext context) {
    TextStyle _getTextStyle() {
      switch (fontStyle) {
        case 'Italic':
          return TextStyle(
            fontSize: textSize,
            fontStyle: FontStyle.italic,
          );
        case 'Bold':
          return TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.bold,
          );
        default:
          return TextStyle(
            fontSize: textSize,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
          );
      }
    }

    return TextField(
      controller: controller,
      readOnly: readOnly,
      maxLines: 5,
      cursorColor: Colors.black, // Set cursor color to black
      style: _getTextStyle(), // Apply the dynamic text style here
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            color: AppColors.textColor,
            fontSize: textSize), // Label size adjustment
        fillColor: Colors.white, // Background color
        filled: true, // Enable background color
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor, width: 1.0),
          borderRadius: BorderRadius.circular(12.0), // Border radius here
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor, width: 2.0),
          borderRadius: BorderRadius.circular(12.0), // Border radius here
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor),
          borderRadius: BorderRadius.circular(12.0), // Border radius here
        ),
      ),
    );
  }
}
