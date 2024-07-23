import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../static/colors.dart';
import '../providers/history_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = context.watch<HistoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation History'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20), // Add spacing here
          Expanded(
            child: ListView.builder(
              itemCount: historyProvider.history.length,
              itemBuilder: (context, index) {
                final item = historyProvider.history[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item.sourceText,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    subtitle: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item.translatedText,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          historyProvider.clearHistory();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('History cleared')),
          );
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.delete_forever),
      ),
    );
  }
}
