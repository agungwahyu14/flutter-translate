import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';
import '../models/language.dart';

class TranslationProvider with ChangeNotifier {
  final translator = GoogleTranslator();

  TextEditingController textController = TextEditingController();
  TextEditingController translatedTextController = TextEditingController();
  double textSize = 16.0;
  String fontStyle = 'Normal';

  // List of supported languages
  final List<Language> _languages = [
    Language('Afrikaans', 'af'),
    Language('Albanian', 'sq'),
    Language('Amharic', 'am'),
    Language('Arabic', 'ar'),
    Language('Armenian', 'hy'),
    Language('Azerbaijani', 'az'),
    Language('Basque', 'eu'),
    Language('Belarusian', 'be'),
    Language('Bengali', 'bn'),
    Language('Bosnian', 'bs'),
    Language('Bulgarian', 'bg'),
    Language('Catalan', 'ca'),
    Language('Cebuano', 'ceb'),
    Language('Chichewa', 'ny'),
    Language('Chinese (Simplified)', 'zh-CN'),
    Language('Chinese (Traditional)', 'zh-TW'),
    Language('Corsican', 'co'),
    Language('Croatian', 'hr'),
    Language('Czech', 'cs'),
    Language('Danish', 'da'),
    Language('Dutch', 'nl'),
    Language('English', 'en'),
    Language('Esperanto', 'eo'),
    Language('Estonian', 'et'),
    Language('Filipino', 'tl'),
    Language('Finnish', 'fi'),
    Language('French', 'fr'),
    Language('Frisian', 'fy'),
    Language('Galician', 'gl'),
    Language('Georgian', 'ka'),
    Language('German', 'de'),
    Language('Greek', 'el'),
    Language('Gujarati', 'gu'),
    Language('Haitian Creole', 'ht'),
    Language('Hausa', 'ha'),
    Language('Hawaiian', 'haw'),
    Language('Hebrew', 'he'),
    Language('Hindi', 'hi'),
    Language('Hmong', 'hmn'),
    Language('Hungarian', 'hu'),
    Language('Icelandic', 'is'),
    Language('Igbo', 'ig'),
    Language('Indonesian', 'id'),
    Language('Irish', 'ga'),
    Language('Italian', 'it'),
    Language('Japanese', 'ja'),
    Language('Javanese', 'jv'),
    Language('Kannada', 'kn'),
    Language('Kazakh', 'kk'),
    Language('Khmer', 'km'),
    Language('Kinyarwanda', 'rw'),
    Language('Korean', 'ko'),
    Language('Kurdish (Kurmanji)', 'ku'),
    Language('Kyrgyz', 'ky'),
    Language('Lao', 'lo'),
    Language('Latin', 'la'),
    Language('Latvian', 'lv'),
    Language('Lithuanian', 'lt'),
    Language('Luxembourgish', 'lb'),
    Language('Macedonian', 'mk'),
    Language('Malagasy', 'mg'),
    Language('Malay', 'ms'),
    Language('Malayalam', 'ml'),
    Language('Maltese', 'mt'),
    Language('Maori', 'mi'),
    Language('Marathi', 'mr'),
    Language('Mongolian', 'mn'),
    Language('Nepali', 'ne'),
    Language('Norwegian', 'no'),
    Language('Pashto', 'ps'),
    Language('Persian', 'fa'),
    Language('Polish', 'pl'),
    Language('Portuguese', 'pt'),
    Language('Punjabi', 'pa'),
    Language('Romanian', 'ro'),
    Language('Russian', 'ru'),
    Language('Samoan', 'sm'),
    Language('Scots Gaelic', 'gd'),
    Language('Serbian', 'sr'),
    Language('Sesotho', 'st'),
    Language('Shona', 'sn'),
    Language('Sindhi', 'sd'),
    Language('Sinhala', 'si'),
    Language('Slovak', 'sk'),
    Language('Slovenian', 'sl'),
    Language('Somali', 'so'),
    Language('Spanish', 'es'),
    Language('Sundanese', 'su'),
    Language('Swahili', 'sw'),
    Language('Swedish', 'sv'),
    Language('Tajik', 'tg'),
    Language('Tamil', 'ta'),
    Language('Telugu', 'te'),
    Language('Thai', 'th'),
    Language('Turkish', 'tr'),
    Language('Ukrainian', 'uk'),
    Language('Urdu', 'ur'),
    Language('Uzbek', 'uz'),
    Language('Vietnamese', 'vi'),
    Language('Welsh', 'cy'),
    Language('Xhosa', 'xh'),
    Language('Yiddish', 'yi'),
    Language('Yoruba', 'yo'),
    Language('Zulu', 'zu'),
  ];

  // Default source and target languages
  Language _sourceLanguage = Language('English', 'en');
  Language _targetLanguage = Language('English', 'en');

  TranslationProvider() {
    textController.addListener(_translateText);
    _translateText(); // Initial translation
  }

  Language get sourceLanguage => _sourceLanguage;
  Language get targetLanguage => _targetLanguage;
  List<Language> get languages => _languages;

  void setSourceLanguage(Language language) {
    _sourceLanguage = language;
    _translateText(); // Translate again when source language changes
    notifyListeners();
  }

  void setTargetLanguage(Language language) {
    _targetLanguage = language;
    _translateText(); // Translate again when target language changes
    notifyListeners();
  }

  void setTextSize(double newSize) {
    textSize = newSize;
    notifyListeners();
  }

  void setFontStyle(String newFontStyle) {
    fontStyle = newFontStyle;
    notifyListeners();
  }

  Future<void> _translateText() async {
    if (textController.text.isEmpty) {
      translatedTextController.clear();
      return;
    }

    try {
      var translation = await translator.translate(
        textController.text,
        from: _sourceLanguage.code,
        to: _targetLanguage.code,
      );
      translatedTextController.text = translation.text;
    } catch (e) {
      translatedTextController.text = 'Error translating text.';
    }

    notifyListeners();
  }

  void swapLanguages() {
    final temp = _sourceLanguage;
    final tempText = textController.text;
    _sourceLanguage = _targetLanguage;
    _targetLanguage = temp;
    textController.text = translatedTextController.text;
    translatedTextController.text = tempText;
    _translateText(); // Translate again when languages are swapped
    notifyListeners();
  }

  void clearTextFields() {
    textController.clear();
    translatedTextController.clear();
    notifyListeners();
  }

  Future<void> pickImageAndExtractText() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100, // Set image quality to 100
    );

    if (image != null) {
      final inputImage = InputImage.fromFilePath(image.path);
      final textDetector = GoogleMlKit.vision.textDetector();
      final RecognisedText recognisedText =
          await textDetector.processImage(inputImage);

      String extractedText = recognisedText.text;
      textDetector.close();

      textController.text = extractedText;
      notifyListeners();
    }
  }
}
