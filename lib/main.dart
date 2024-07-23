import 'package:flutter/material.dart';
import 'package:flutter_translate/home/pages/history_screen.dart';
import 'package:flutter_translate/home/pages/translate_screen.dart';
import 'package:flutter_translate/home/providers/history_provider.dart';
import 'package:flutter_translate/home/providers/translation_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TranslationProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Translator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TranslateScreen(),
      routes: {
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
