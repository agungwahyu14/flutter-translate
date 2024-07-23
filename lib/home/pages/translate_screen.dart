import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/home/widgets/languange_dropdown.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../../static/colors.dart';
import '../providers/translation_provider.dart';
import '../widgets/custom_text_field.dart';

class TranslateScreen extends StatelessWidget {
  const TranslateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transProvider = context.watch<TranslationProvider>();
    final FlutterTts flutterTts = FlutterTts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Translator App'),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              const Icon(Icons.translate_rounded, size: 50),
              const SizedBox(height: 20),
              CustomTextField(
                controller: transProvider.textController,
                labelText: 'Enter text',
                textSize: transProvider.textSize,
                fontStyle: transProvider.fontStyle,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Expanded(child: LanguageDropdown(isSource: true)),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz),
                    onPressed: () {
                      transProvider.swapLanguages();
                    },
                    color: AppColors.textColor,
                  ),
                  const Expanded(child: LanguageDropdown(isSource: false)),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: transProvider.translatedTextController,
                readOnly: true,
                textSize: transProvider.textSize,
                fontStyle: transProvider.fontStyle,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text('Font Size:'),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Background color
                      border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.0), // Border color and width
                      borderRadius:
                          BorderRadius.circular(12.0), // Border radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: DropdownButton<double>(
                        value: transProvider.textSize,
                        items: <double>[
                          10.0,
                          12.0,
                          14.0,
                          16.0,
                          18.0,
                          20.0,
                          22.0,
                          24.0,
                          26.0,
                          28.0,
                          30.0
                        ].map((double size) {
                          return DropdownMenuItem<double>(
                            value: size,
                            child: Text('$size'),
                          );
                        }).toList(),
                        onChanged: (double? newSize) {
                          if (newSize != null) {
                            transProvider.setTextSize(newSize);
                          }
                        },
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('Font Style:'),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Background color
                      border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.0), // Border color and width
                      borderRadius:
                          BorderRadius.circular(12.0), // Border radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: DropdownButton<String>(
                        value: transProvider.fontStyle,
                        items: <String>['Normal', 'Italic', 'Bold']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            transProvider.setFontStyle(newValue);
                          }
                        },
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        final translatedText =
                            transProvider.translatedTextController.text;
                        Clipboard.setData(ClipboardData(text: translatedText));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied to clipboard')),
                        );
                      },
                      color: AppColors.textColor,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        final translatedText =
                            transProvider.translatedTextController.text;
                        Share.share(translatedText);
                      },
                      color: AppColors.textColor,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.volume_up),
                      onPressed: () async {
                        final translatedText =
                            transProvider.translatedTextController.text;
                        await flutterTts.speak(translatedText);
                      },
                      color: AppColors.textColor,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () async {
                        final translatedText =
                            transProvider.translatedTextController.text;
                        await flutterTts.speak(translatedText);
                      },
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          transProvider.clearTextFields();
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
