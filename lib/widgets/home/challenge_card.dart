import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ChallengeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String buttonText;
  final VoidCallback? onPressed;

  const ChallengeCard({
    super.key,
    this.title = 'Your Next Challenge',
    this.subtitle = 'Assessment',
    this.description =
        'Complete the assessment to unlock your personalized training plan.',
    this.buttonText = 'START →',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.gradientStart, AppTheme.gradientEnd],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -10,
            child: Icon(
              Icons.directions_run,
              size: 140,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(description, style: AppTheme.body),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onPressed,
                  style: AppTheme.primaryButtonStyle,
                  child: Text(buttonText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
