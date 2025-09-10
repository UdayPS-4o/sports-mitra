import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/sports_stat.dart';

class StatsSection extends StatelessWidget {
  final List<SportsStat> stats;

  const StatsSection({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('My Stats', style: AppTheme.heading),
        const SizedBox(height: 16),
        Row(
          children: stats.asMap().entries.map((entry) {
            final isLast = entry.key == stats.length - 1;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: isLast ? 0 : 16),
                child: StatCard(stat: entry.value),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final SportsStat stat;

  const StatCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: stat.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: stat.iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(stat.icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            stat.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: stat.textColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.value,
            style: TextStyle(
              color: stat.textColor.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
