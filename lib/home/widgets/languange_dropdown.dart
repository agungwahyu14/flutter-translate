import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/language.dart';
import '../providers/translation_provider.dart';

class LanguageDropdown extends StatelessWidget {
  final bool isSource;

  const LanguageDropdown({required this.isSource, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TranslationProvider>(context);
    final selectedLanguage =
        isSource ? provider.sourceLanguage : provider.targetLanguage;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color
        border: Border.all(
            color: Colors.grey[300]!, width: 1.0), // Border color and width
        borderRadius: BorderRadius.circular(12.0), // Border radius
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 8.0), // Horizontal padding
        child: DropdownButton<Language>(
          isExpanded: true,
          value: selectedLanguage,
          onChanged: (Language? newValue) {
            if (newValue != null) {
              if (isSource) {
                provider.setSourceLanguage(newValue);
              } else {
                provider.setTargetLanguage(newValue);
              }
            }
          },
          items: provider.languages.map((Language language) {
            return DropdownMenuItem<Language>(
              value: language,
              child: Text(
                language.name,
                style: const TextStyle(color: Colors.black), // Text color
              ),
            );
          }).toList(),
          underline: SizedBox(), // Remove default underline
        ),
      ),
    );
  }
}
