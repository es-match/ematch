import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({Animation<double> animation})
      : dOrangePaint = Paint()
          ..color = Colors.deepOrange[600]
          ..style = PaintingStyle.fill,
        greyPaint = Paint()
          ..color = Colors.grey[850]
          ..style = PaintingStyle.fill,
        orangePaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill,
        liquidAnim = CurvedAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
          parent: animation,
        ),
        orangeAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.7,
            curve: Interval(0, 0.8, curve: SpringCurve()),
          ),
          reverseCurve: Curves.linear,
        ),
        greyAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.8,
            curve: Interval(0, 0.9, curve: SpringCurve()),
          ),
          reverseCurve: Curves.easeInCirc,
        ),
        dOrangeAnim = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        super(repaint: animation);

  final Animation<double> liquidAnim;
  final Animation<double> dOrangeAnim;
  final Animation<double> orangeAnim;
  final Animation<double> greyAnim;

  final Paint dOrangePaint;
  final Paint greyPaint;
  final Paint orangePaint;

  @override
  void paint(Canvas canvas, Size size) {
    print('painting');
    paintDOrange(canvas, size);
    paintGrey(canvas, size);
    paintOrange(canvas, size);
  }

// https://www.youtube.com/watch?v=bpvpbQF-2Js
  void paintDOrange(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(0, size.height, dOrangeAnim.value),
    );
    _addPointsToPath(path, [
      Point(
        lerpDouble(0, size.width / 3, dOrangeAnim.value),
        lerpDouble(0, size.height, dOrangeAnim.value),
      ),
      Point(
        lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnim.value),
        lerpDouble(size.height / 2, size.height / 4 * 3, liquidAnim.value),
      ),
      Point(
        size.width,
        lerpDouble(size.height / 2, size.height / 4 * 3, liquidAnim.value),
      ),
    ]);

    canvas.drawPath(path, dOrangePaint);
  }

  void paintGrey(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(
        size.height / 4,
        size.height / 2,
        greyAnim.value,
      ),
    );
    _addPointsToPath(path, [
      Point(
        size.width / 4,
        lerpDouble(
          size.height / 2,
          size.height * 3 / 4,
          liquidAnim.value,
        ),
      ),
      Point(
        size.width * 3 / 5,
        lerpDouble(
          size.height / 4,
          size.height / 2,
          liquidAnim.value,
        ),
      ),
      Point(
        size.width * 4 / 5,
        lerpDouble(
          size.height / 4,
          size.height / 2,
          liquidAnim.value,
        ),
      ),
      Point(
        size.width * 4,
        lerpDouble(size.height / 2, size.height / 4 * 3, liquidAnim.value),
      ),
    ]);

    canvas.drawPath(path, greyPaint);
  }

  void paintOrange(Canvas canvas, Size size) {
    if (orangeAnim.value > 0) {
      final path = Path();
      path.moveTo(size.width, 300);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
      path.lineTo(
        0,
        lerpDouble(
          size.height / 4,
          size.height / 2,
          orangeAnim.value,
        ),
      );
      _addPointsToPath(path, [
        Point(
          size.width / 4,
          lerpDouble(
            size.height / 2,
            size.height * 3 / 4,
            liquidAnim.value,
          ),
        ),
        Point(
          size.width * 3 / 5,
          lerpDouble(
            size.height / 4,
            size.height / 2,
            liquidAnim.value,
          ),
        ),
        Point(
          size.width * 4 / 5,
          lerpDouble(
            size.height / 4,
            size.height / 2,
            liquidAnim.value,
          ),
        ),
        Point(
          size.width * 4,
          lerpDouble(size.height / 2, size.height / 4 * 3, liquidAnim.value),
        ),
      ]);

      canvas.drawPath(path, orangePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need 3 or more points to create a path');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}
