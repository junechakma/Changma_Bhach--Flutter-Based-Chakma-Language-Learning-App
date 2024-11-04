import 'dart:typed_data';

import 'package:changma_bhach/logic/character_recognition.dart';
import 'package:changma_bhach/presentation/screens/lessons/lesson_screen.dart';
import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:changma_bhach/presentation/styles/app_images.dart';
import 'package:changma_bhach/presentation/styles/text_styles.dart';
import 'package:changma_bhach/presentation/widgets/score_counter.dart';
import 'package:changma_bhach/providers/lesson_provider.dart';
import 'package:changma_bhach/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});
  @override
  DrawingScreenState createState() => DrawingScreenState();
}

class DrawingScreenState extends State<DrawingScreen> {
  final GlobalKey<DrawingCanvasState> _canvasKey =
      GlobalKey<DrawingCanvasState>();
  final CharacterRecognition _characterRecognizer = CharacterRecognition();
  String _predictedCharacter = "";

  // Convert the drawn image to bytes
  Future<Uint8List?> _convertImageToBytes(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  // Clear the drawing canvas
  void _clearCanvas() {
    _canvasKey.currentState!.clearCanvas();
    setState(() {
      _predictedCharacter = "";
    });
  }

  // Process the drawn image for character recognition
  Future<void> _processDrawing() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(360, 360);

    _DrawingPainter(_canvasKey.currentState!.points).paint(canvas, size);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());

    // Convert the image to bytes
    final bytes = await _convertImageToBytes(img);
    if (bytes == null) return;

    // Process the image bytes for character recognition
    await _characterRecognizer.processImageBytes(bytes);

    setState(() {
      _predictedCharacter = _characterRecognizer.predictedCharacter;
    });
    if (!mounted) return;

    // Validate the predicted character with LessonProvider
    final lessonProvider = Provider.of<LessonProvider>(context, listen: false);
    lessonProvider.drawingValidation(context, _predictedCharacter);

    // Check if the prediction is correct
    if (lessonProvider.isCorrectLetter) {
      _showCongratulationsDialog();
    } else {
      _showErrorDialog(context);
      _clearCanvas();
    }
  }

  void _showErrorDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(41, 255, 0, 25),
        content: Column(
          children: [
            Image.asset(
              AppImages.snackbarImage,
              width: 200,
              height: 200,
            ),
            Text(
              AppLocalizations.of(context)!.error_drawing_message,
              style: TextStyles.headingText.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  void _showCongratulationsDialog() {
    final lessonProvider = Provider.of<LessonProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.congratulation_message),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.congratulations,
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              Text(AppLocalizations.of(context)!.congratulation_alert_message),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _clearCanvas(); // Optionally clear the canvas
              },
              child: Text(AppLocalizations.of(context)!
                  .congratulation_alert_restart_button),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog

                if (lessonProvider.lastLetter) {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.resultScreen);
                } else {
                  lessonProvider.nextLetter();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonScreen(
                        selectedLessonType: lessonProvider.currentLessonType,
                      ),
                    ),
                  );
                }
                // Navigate to next lesson
              },
              child: Text(lessonProvider.lastLetter
                  ? AppLocalizations.of(context)!
                      .congratulation_alert_result_button
                  : AppLocalizations.of(context)!
                      .congratulation_alert_next_button),
            ),
          ],
        );
      },
    );
  }

  void _handlePrediction() {
    _processDrawing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        title: Text(
          AppLocalizations.of(context)!.draw_bellow,
          style: TextStyles.lessonText.copyWith(fontSize: 22),
        ),
        centerTitle: true,
        actions: const [
          ScoreCounter(),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 400,
                height: 400,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DrawingCanvas(key: _canvasKey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 80,
              child: Text(
                _predictedCharacter,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _clearCanvas,
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context)!.clear_button),
                      const Icon(Icons.clear_rounded)
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _handlePrediction,
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context)!.prediction_button),
                      const Icon(Icons.auto_awesome)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({super.key});

  @override
  DrawingCanvasState createState() => DrawingCanvasState();
}

class DrawingCanvasState extends State<DrawingCanvas> {
  final List<Offset?> _points = [];

  // Clear the points on the canvas
  void clearCanvas() {
    setState(() {
      _points.clear();
    });
  }

  // Getter for points
  List<Offset?> get points => _points;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          Offset localPosition =
              renderBox.globalToLocal(details.globalPosition);
          _points.add(localPosition);
        });
      },
      onPanEnd: (details) {
        _points.add(null); // To signify the end of a drawing line
      },
      child: CustomPaint(
        painter: _DrawingPainter(_points),
        size: Size.infinite, // Use available space
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  _DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()..color = Colors.white;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7.0;

    // Draw the lines based on points
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DrawingPainter oldDelegate) => true;
}
