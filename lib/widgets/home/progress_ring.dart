import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/theme/app_theme.dart';

class ProgressRing extends StatelessWidget {
  final int verifiedTests;
  final int totalTests;
  final int bestPercentile;

  const ProgressRing({
    super.key,
    required this.verifiedTests,
    required this.totalTests,
    required this.bestPercentile,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalTests > 0 ? verifiedTests / totalTests : 0.0;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Progress Ring
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              children: [
                CustomPaint(
                  size: const Size(80, 80),
                  painter: ProgressRingPainter(
                    progress: progress,
                    strokeWidth: 8,
                    backgroundColor: AppTheme.surfaceColor,
                    progressColor: AppTheme.primary,
                  ),
                ),
                Center(
                  child: Text(
                    '$verifiedTests/$totalTests',
                    style: AppTheme.numeric.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verified tests this week',
                  style: AppTheme.body,
                ),
                const SizedBox(height: 8),
                Text(
                  'Best percentile: P$bestPercentile',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Mock data factory
  static ProgressRing mock() {
    return const ProgressRing(
      verifiedTests: 3,
      totalTests: 5,
      bestPercentile: 82,
    );
  }
}

class ProgressRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  ProgressRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
