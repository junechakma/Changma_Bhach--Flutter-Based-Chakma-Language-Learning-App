import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class CharacterRecognition {
  final List<String> classNames = [
    '𑄃',
    '𑄇',
    '𑄈',
    '𑄉',
    '𑄊',
    '𑄋',
    '𑄌',
    '𑄍',
    '𑄎',
    '𑄏',
    '𑄐',
    '𑄑',
    '𑄒',
    '𑄓',
    '𑄔',
    '𑄕',
    '𑄖',
    '𑄗',
    '𑄘',
    '𑄙',
    '𑄚',
    '𑄛',
    '𑄜',
    '𑄝',
    '𑄞',
    '𑄟',
    '𑄠',
    '𑄡',
    '𑄢',
    '𑄣',
    '𑄤',
    '𑄥',
    '𑄦'
  ];
  String predictedCharacter = "";

  Future<void> processImageBytes(Uint8List imageBytes) async {
    try {
      // Decode image using the `image` package
      img.Image? image = img.decodeImage(imageBytes);

      if (image == null) {
        // print("Error decoding image");
        return;
      }

      // Resize image to 64x64
      img.Image resizedImage = img.copyResize(image, width: 64, height: 64);

      // Convert to grayscale
      img.Image grayscaleImage = img.grayscale(resizedImage);

      // Convert to 2D array and normalize
      List<List<double>> pixelsArray = List.generate(
        64,
        (y) => List.generate(64, (x) {
          num pixel = grayscaleImage.getPixel(x, y).r;
          return pixel / 255.0;
        }),
      );

      // Convert to model input format [1, 64, 64, 1]
      List<List<List<List<double>>>> inputArray = [
        pixelsArray.map((row) => row.map((value) => [value]).toList()).toList()
      ];

      await _runTFLiteModel(inputArray);
    } catch (e) {
      print("Error preparing image for model: $e");
    }
  }

  Future<void> _runTFLiteModel(
      List<List<List<List<double>>>> inputArray) async {
    try {
      // Load the TFLite model
      final interpreter = await Interpreter.fromAsset(
          'assets/models/chakma_character_recognition_model.tflite');

      // print("Model Loaded");

      // Prepare the input and output tensors
      var output = List.filled(1 * classNames.length, 0.0)
          .reshape([1, classNames.length]); // Output shape for classification

      // Print input array dimensions for debugging
      // print(
      //     'Input Array Dimensions: ${inputArray.length}x${inputArray[0].length}x${inputArray[0][0].length}');

      // Run the model
      interpreter.run(inputArray, output);

      // Print model output for debugging
      // print("Model Output: $output");

      // Get the index of the highest probability in the output
      int predictedClassIndex = output[0].indexWhere((element) =>
          element ==
          (output[0] as List<double>).reduce((a, b) => a > b ? a : b));

      // print("Predicted Class Index: $predictedClassIndex");

      // Get the corresponding Chakma character
      String predictedChar = classNames[predictedClassIndex];

// Store the predicted character
      predictedCharacter = predictedChar;

      // print("Predicted Character: $predictedCharacter");

      // Close interpreter after use
      interpreter.close();
    } catch (e) {
      // print("Error running the model: $e");
    }
  }
}
