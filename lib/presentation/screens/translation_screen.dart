import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _translatedText;
  String? _chakmaScript;

  Future<void> translateText(String inputText) async {
    const String apiUrl =
        "https://changma-bhach-translation-api.onrender.com/translate";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"input_text": inputText}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Update UI based on the response values, avoiding "N/A" or null
        setState(() {
          _translatedText = data['chakma_language'];
          _chakmaScript =
              (data['chakma_script'] == "N/A" || data['chakma_script'] == null)
                  ? null
                  : data['chakma_script'];
        });
      } else {
        // Handle server errors
        setState(() {
          _translatedText = "Error: Could not retrieve translation";
          _chakmaScript = null;
        });
      }
    } catch (error) {
      // Handle network errors
      setState(() {
        _translatedText = "Error: ${error.toString()}";
        _chakmaScript = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chakma Translator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter Sentence/Word in Bangla",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final inputText = _controller.text.trim();
                if (inputText.isNotEmpty) {
                  translateText(inputText);
                }
              },
              child: Text("Translate"),
            ),
            SizedBox(height: 24),
            if (_translatedText != null) ...[
              Text(
                "Translation in Chakma:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                _translatedText!,
                style: TextStyle(fontSize: 20),
              ),
              if (_chakmaScript != null) ...[
                SizedBox(height: 16),
                Text(
                  "Chakma Script:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  _chakmaScript!,
                  style: TextStyle(fontSize: 20),
                ),
              ]
            ],
          ],
        ),
      ),
    );
  }
}
