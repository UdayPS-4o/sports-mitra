import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class RecommendationCard extends StatelessWidget {
  final String testName;
  final String target;
  final String ageGroup;
  final VoidCallback? onStartTest;

  const RecommendationCard({
    super.key,
    required this.testName,
    required this.target,
    required this.ageGroup,
    this.onStartTest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/hero_runner.png'),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(0.25),
              Colors.black.withOpacity(0.55),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.recommend, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  "Today's Recommendation",
                  style: AppTheme.caption.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Do $testName now',
              style: AppTheme.heading.copyWith(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Target: $target ($ageGroup)',
              style: AppTheme.body.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStartTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primaryAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Start',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.primaryAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mock data factory
  static RecommendationCard mock({VoidCallback? onStartTest}) {
    return RecommendationCard(
      testName: 'Vertical Jump',
      target: '≥ 42 cm',
      ageGroup: 'Girls 16–17',
      onStartTest: onStartTest,
    );
  }
}
