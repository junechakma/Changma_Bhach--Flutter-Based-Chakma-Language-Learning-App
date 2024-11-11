import 'package:changma_bhach/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class CongratulationsDialog extends StatefulWidget {
  final String title;
  final String message;
  final String? imagePath;
  final List<CongratulationsAction> actions;
  final Color primaryColor;
  final Duration displayDuration;

  const CongratulationsDialog({
    super.key,
    required this.title,
    required this.message,
    this.imagePath,
    required this.actions,
    this.primaryColor = const Color(0xFF2196F3), // Default blue color
    this.displayDuration = const Duration(milliseconds: 300),
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String message,
    String? imagePath,
    required List<CongratulationsAction> actions,
    Color? primaryColor,
    Duration? displayDuration,
  }) {
    return showGeneralDialog<T>(
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
      transitionBuilder: (context, anim1, anim2, child) {
        return CongratulationsDialog(
          title: title,
          message: message,
          imagePath: imagePath,
          actions: actions,
          primaryColor: primaryColor ?? Theme.of(context).primaryColor,
          displayDuration: displayDuration ?? const Duration(milliseconds: 300),
        );
      },
      transitionDuration: displayDuration ?? const Duration(milliseconds: 300),
    );
  }

  @override
  State<CongratulationsDialog> createState() => _CongratulationsDialogState();
}

class _CongratulationsDialogState extends State<CongratulationsDialog> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2))..play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Confetti Animation
            SizedBox(
              height: 20,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: -pi / 2,
                maxBlastForce: 5,
                minBlastForce: 1,
                emissionFrequency: 0.05,
                numberOfParticles: 10,
                gravity: 0.1,
              ),
            ),
            // Congratulations Image (if provided)
            if (widget.imagePath != null)
              Image.asset(
                widget.imagePath!,
                width: 200,
                height: 200,
              ),
            const SizedBox(height: 10),
            // Title
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: widget.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            // Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.actions.map((action) {
                return _buildButton(
                  onPressed: () {
                    action.onPressed();
                  },
                  label: action.label,
                  color: action.isPrimary
                      ? widget.primaryColor
                      : Colors.grey[300]!,
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required String label,
    required Color color,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color == Colors.grey[300] ? AppColors.dark : Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class CongratulationsAction {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  CongratulationsAction({
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
  });
}
