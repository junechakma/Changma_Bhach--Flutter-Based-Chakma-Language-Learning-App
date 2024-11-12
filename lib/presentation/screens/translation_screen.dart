import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:changma_bhach/presentation/styles/app_colors.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _primaryTranslation;
  List<String> _alternativeTranslations = [];
  bool _isBanglaToChakma = true;
  bool _isLoading = false;

  Future<void> translateText(String inputText) async {
    const String apiUrl =
        "https://changma-bhach-translation-api.onrender.com/translate";

    // Encode the input text to handle special characters and spaces
    final encodedText = Uri.encodeComponent(inputText);

    setState(() {
      _isLoading = true; // Set loading to true when starting the request
    });

    try {
      final response = await http.get(
        Uri.parse('$apiUrl?text=$encodedText&to_bangla=${!_isBanglaToChakma}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _primaryTranslation =
              data['primary_translation'] ?? "Translation unavailable";
          var altTranslations = data['alternative_translations'];
          if (altTranslations is String) {
            _alternativeTranslations = [altTranslations];
          } else if (altTranslations is List) {
            _alternativeTranslations = List<String>.from(altTranslations);
          } else {
            _alternativeTranslations = [];
          }
        });
      } else {
        showSnackbar("Error: Could not retrieve translation. Try again later.");
      }
    } catch (error) {
      showSnackbar("Error: ${error.toString()}. Try again later.");
    } finally {
      setState(() {
        _isLoading = false; // Stop loading when the response is received
      });
    }
  }

  void _clearInput() {
    setState(() {
      _controller.clear();
      _primaryTranslation = null;
      _alternativeTranslations = [];
    });
  }

  void _copyOutput() {
    if (_primaryTranslation != null) {
      Clipboard.setData(ClipboardData(text: _primaryTranslation.toString()))
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Copied to clipboard")),
        );
      });
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Chakma-Bangla Translator'),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside of text field
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Language Selection Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      value: _isBanglaToChakma ? "Bangla" : "Chakma",
                      items: ["Bangla", "Chakma"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _isBanglaToChakma = (value == "Bangla");
                          _controller.clear();
                          _primaryTranslation = null;
                          _alternativeTranslations = [];
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.swap_horiz),
                      onPressed: () {
                        setState(() {
                          _isBanglaToChakma = !_isBanglaToChakma;
                          _controller.clear();
                          _primaryTranslation = null;
                          _alternativeTranslations = [];
                        });
                      },
                    ),
                    DropdownButton<String>(
                      value: _isBanglaToChakma ? "Chakma" : "Bangla",
                      items: ["Bangla", "Chakma"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _isBanglaToChakma = (value == "Chakma");
                          _controller.clear();
                          _primaryTranslation = null;
                          _alternativeTranslations = [];
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Input Text Area with Clear Button
                Container(
                  padding: const EdgeInsets.all(16),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _isBanglaToChakma ? "Bangla" : "Chakma",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: _clearInput,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter text here",
                              ),
                              maxLines: null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Translate Button
                ElevatedButton(
                  onPressed: _isLoading
                      ? null // Disable button if loading
                      : () {
                          // Dismiss keyboard when translate button is pressed
                          FocusScope.of(context).unfocus();
                          final inputText = _controller.text.trim();
                          if (inputText.isNotEmpty) {
                            translateText(inputText);
                          }
                        },
                  style: ButtonStyle(
                    foregroundColor:
                        WidgetStateProperty.all(AppColors.backgroundColor),
                    backgroundColor: WidgetStateProperty.all(AppColors.primary),
                  ),
                  child: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isLoading) ...[
                          const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 4,
                          ),
                        ] else ...[
                          const Text("Translate"),
                          const SizedBox(width: 8),
                          const FaIcon(FontAwesomeIcons.language),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Output Text Area with Primary and Alternative Translations
                if (_primaryTranslation != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isBanglaToChakma ? "Chakma" : "Bangla",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: SelectableText(
                                _primaryTranslation!,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy, color: Colors.grey),
                              onPressed: _copyOutput,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Display Alternative Translations if available
                        if (_alternativeTranslations.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Alternative Translations:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              for (String altTranslation
                                  in _alternativeTranslations)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "- $altTranslation",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
