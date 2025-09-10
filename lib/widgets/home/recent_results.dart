import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/test_result.dart';

class RecentResults extends StatelessWidget {
  final List<TestResult> results;
  final Function(TestResult)? onResultTap;

  const RecentResults({super.key, required this.results, this.onResultTap});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.analytics_outlined,
                size: 48,
                color: AppTheme.textMuted,
              ),
              const SizedBox(height: 12),
              Text('No recent results', style: AppTheme.body),
              const SizedBox(height: 8),
              Text(
                'Complete your first test to see results here',
                style: AppTheme.caption,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Recent Results',
            style: AppTheme.subheading.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 132,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 0 : 12,
                  right: index == results.length - 1 ? 0 : 0,
                ),
                child: ResultCard(
                  result: result,
                  onTap: () => onResultTap?.call(result),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ResultCard extends StatelessWidget {
  final TestResult result;
  final VoidCallback? onTap;

  const ResultCard({super.key, required this.result, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 172,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: result.isFlagged ? AppTheme.flagged : AppTheme.borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    result.testName,
                    style: AppTheme.bodyMedium.copyWith(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildStatusIcon(),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              result.displayScore,
              style: AppTheme.numeric.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(
              result.statusDisplay,
              style: AppTheme.caption.copyWith(
                color: _getStatusColor(),
                fontSize: 11,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Icon(
                  Icons.arrow_outward_rounded,
                  size: 14,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(width: 4),
                Text('View details', style: AppTheme.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    switch (result.status) {
      case TestStatus.officialVerified:
        return Icon(Icons.verified, color: AppTheme.verified, size: 16);
      case TestStatus.uploaded:
        return Icon(
          Icons.cloud_upload_outlined,
          color: AppTheme.pending,
          size: 16,
        );
      case TestStatus.flagged:
        return Icon(
          Icons.warning_amber_outlined,
          color: AppTheme.flagged,
          size: 16,
        );
      case TestStatus.aiVerified:
        return Icon(
          Icons.smart_toy_outlined,
          color: AppTheme.aiVerified,
          size: 16,
        );
      default:
        return Icon(Icons.schedule, color: AppTheme.pending, size: 16);
    }
  }

  Color _getStatusColor() {
    switch (result.status) {
      case TestStatus.officialVerified:
        return AppTheme.verified;
      case TestStatus.flagged:
        return AppTheme.flagged;
      case TestStatus.aiVerified:
        return AppTheme.aiVerified;
      default:
        return AppTheme.pending;
    }
  }
}
