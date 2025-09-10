import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String selectedTimeWindow = '30d';
  final timeWindows = ['7d', '30d', '90d', 'All'];

  List<String> selectedTests = ['All'];
  final availableTests = [
    'All',
    'Vertical Jump',
    'Push-ups',
    'Shuttle Run',
    'Sit-ups',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilters(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildWeeklyTrend(),
                  const SizedBox(height: 24),
                  _buildPersonalBests(),
                  const SizedBox(height: 24),
                  _buildCohortBenchmarks(),
                  const SizedBox(height: 24),
                  _buildHistoryTable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Progress',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Track your performance over time',
            style: TextStyle(fontSize: 14, color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Window Filter
          Row(
            children: [
              const Text(
                'Time Window:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: timeWindows.length,
                    itemBuilder: (context, index) {
                      final window = timeWindows[index];
                      final isSelected = selectedTimeWindow == window;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTimeWindow = window;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primaryAccent
                                  : AppTheme.cardBackground,
                              borderRadius: BorderRadius.circular(20),
                              border: isSelected
                                  ? null
                                  : Border.all(
                                      color: AppTheme.borderColor,
                                      width: 1,
                                    ),
                            ),
                            child: Text(
                              window,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : AppTheme.textMuted,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyTrend() {
    final trends = [
      {
        'test': 'Vertical Jump',
        'trend': '33 → 41 → 40 → 42 cm',
        'change': '+27%',
      },
      {'test': 'Push-ups', 'trend': '18 → 22 → 26 → 28', 'change': '+56%'},
      {'test': 'Shuttle Run', 'trend': '12.1 → 11.8 → 11.6s', 'change': '-4%'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Trend',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...trends
              .map(
                (trend) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          trend['test'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          trend['trend'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textMuted,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: (trend['change'] as String).startsWith('+')
                              ? AppTheme.verified.withOpacity(0.1)
                              : AppTheme.warning.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          trend['change'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: (trend['change'] as String).startsWith('+')
                                ? AppTheme.verified
                                : AppTheme.warning,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildPersonalBests() {
    final personalBests = [
      {
        'test': 'Shuttle 20m',
        'value': '11.63 s',
        'date': '09 Sep',
        'isNew': true,
      },
      {
        'test': 'Vertical Jump',
        'value': '41.2 cm',
        'date': '09 Sep',
        'isNew': true,
      },
      {
        'test': 'Push-ups (60s)',
        'value': '28 reps',
        'date': '06 Sep',
        'isNew': false,
      },
      {
        'test': 'Sit-ups (60s)',
        'value': '32 reps',
        'date': '03 Sep',
        'isNew': false,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Bests',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...personalBests
              .map(
                (best) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          best['test'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ),
                      Text(
                        best['value'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: best['isNew'] as bool
                              ? AppTheme.verified.withOpacity(0.1)
                              : AppTheme.surfaceColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          best['date'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: best['isNew'] as bool
                                ? AppTheme.verified
                                : AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildCohortBenchmarks() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cohort Benchmarks',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Female • 16 years • Your District',
            style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildBenchmarkCard(
                  'Overall Rank',
                  'Top 25%',
                  AppTheme.verified,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildBenchmarkCard(
                  'Speed Tests',
                  'Top 30%',
                  AppTheme.primaryAccent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildBenchmarkCard(
                  'Strength',
                  'Top 20%',
                  AppTheme.secondaryAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenchmarkCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTable() {
    final history = [
      {
        'date': '09 Sep',
        'test': 'Vertical Jump',
        'score': '41.2 cm',
        'status': 'Verified',
      },
      {
        'date': '07 Sep',
        'test': 'Shuttle Run 20m',
        'score': '11.63 s',
        'status': 'Submitted',
      },
      {
        'date': '06 Sep',
        'test': 'Push-ups (60s)',
        'score': '28 reps',
        'status': 'Verified',
      },
      {
        'date': '03 Sep',
        'test': 'Sit-ups (60s)',
        'score': '32 reps',
        'status': 'Verified',
      },
      {
        'date': '01 Sep',
        'test': 'Height & Weight',
        'score': '162.4 cm, 52.8 kg',
        'status': 'Verified',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'History',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...history
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          entry['date']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textMuted,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          entry['test']!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          entry['score']!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: entry['status'] == 'Verified'
                              ? AppTheme.verified.withOpacity(0.1)
                              : AppTheme.warning.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          entry['status']!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: entry['status'] == 'Verified'
                                ? AppTheme.verified
                                : AppTheme.warning,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
