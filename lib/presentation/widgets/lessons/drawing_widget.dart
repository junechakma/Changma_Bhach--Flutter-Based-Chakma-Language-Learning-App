import 'package:flutter/material.dart';

class DrawingWidget extends StatefulWidget {
  const DrawingWidget({super.key});

  @override
  State<DrawingWidget> createState() => DrawingWidgetState();
}

class DrawingWidgetState extends State<DrawingWidget> {
  final List<Offset?> _points = [];

  void clear() {
    setState(() {
      _points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => {
        setState(() {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          Offset localPosition =
              renderBox.globalToLocal(details.globalPosition);
          _points.add(localPosition);
        })
      },
      onPanEnd: (details) {
        _points.add(null);
      },
      child: CustomPaint(
        painter: _DrawingPainter(_points),
        size: Size.infinite,
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

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DrawingPainter oldDelegate) => true;
}
