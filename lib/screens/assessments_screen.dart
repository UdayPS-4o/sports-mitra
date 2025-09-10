import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class AssessmentsScreen extends StatefulWidget {
  const AssessmentsScreen({super.key});

  @override
  State<AssessmentsScreen> createState() => _AssessmentsScreenState();
}

class _AssessmentsScreenState extends State<AssessmentsScreen> {
  String selectedFilter = 'All';
  final filters = ['All', 'Strength', 'Speed', 'Endurance'];

  final List<TestCard> tests = [
    TestCard(
      name: 'Height & Weight',
      category: 'Basic',
      icon: Icons.straighten,
      description: 'Basic anthropometric measurements',
      isCompleted: false,
    ),
    TestCard(
      name: 'Vertical Jump',
      category: 'Strength',
      icon: Icons.vertical_align_top,
      description: 'Standing vertical jump using wall marker',
      isCompleted: true,
    ),
    TestCard(
      name: 'Sit-ups (60s)',
      category: 'Strength',
      icon: Icons.fitness_center,
      description: 'Maximum sit-ups in 60 seconds',
      isCompleted: false,
    ),
    TestCard(
      name: 'Push-ups (60s)',
      category: 'Strength',
      icon: Icons.accessibility_new,
      description: 'Maximum push-ups in 60 seconds',
      isCompleted: true,
    ),
    TestCard(
      name: 'Shuttle Run 20m',
      category: 'Speed',
      icon: Icons.directions_run,
      description: '20-meter shuttle run test',
      isCompleted: false,
    ),
    TestCard(
      name: 'Endurance Run 1.6km',
      category: 'Endurance',
      icon: Icons.timer,
      description: '1.6 kilometer endurance run',
      isCompleted: false,
    ),
    TestCard(
      name: 'Sit & Reach',
      category: 'Flexibility',
      icon: Icons.accessibility,
      description: 'Flexibility assessment test',
      isCompleted: false,
    ),
  ];

  List<TestCard> get filteredTests {
    if (selectedFilter == 'All') return tests;
    return tests.where((test) => test.category == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilters(),
            Expanded(child: _buildTestsList()),
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
            'Assessments',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Female • 16 years',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryAccent
                      : AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(25),
                  border: isSelected
                      ? null
                      : Border.all(color: AppTheme.borderColor, width: 1),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : AppTheme.textMuted,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTestsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: filteredTests.length,
      itemBuilder: (context, index) {
        final test = filteredTests[index];
        return _buildTestCard(test);
      },
    );
  }

  Widget _buildTestCard(TestCard test) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20), // 20dp cards per spec
        border: Border.all(color: AppTheme.borderColor, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Navigate to Assessment Sheet
            debugPrint('Navigate to ${test.name} assessment');
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: test.isCompleted
                        ? AppTheme.verified.withOpacity(0.1)
                        : AppTheme.primaryAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    test.icon,
                    color: test.isCompleted
                        ? AppTheme.verified
                        : AppTheme.primaryAccent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              test.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                          if (test.isCompleted)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.verified.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.verified,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        test.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textMuted,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          test.category,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textMuted,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TestCard {
  final String name;
  final String category;
  final IconData icon;
  final String description;
  final bool isCompleted;

  TestCard({
    required this.name,
    required this.category,
    required this.icon,
    required this.description,
    required this.isCompleted,
  });
}
