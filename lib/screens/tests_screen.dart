import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

enum TestReadiness {
  ready,
  needsGear,
  modelDownloading,
  modelRequired,
  optional,
}

class StandardizedTest {
  final String id;
  final String name;
  final String description;
  final String captureMode;
  final TestReadiness readiness;
  final String? requirement;
  final String? model;

  const StandardizedTest({
    required this.id,
    required this.name,
    required this.description,
    required this.captureMode,
    required this.readiness,
    this.requirement,
    this.model,
  });

  static List<StandardizedTest> getAllTests() {
    return const [
      StandardizedTest(
        id: 'height_weight',
        name: 'Height & Weight',
        description: 'Manual + vision assist',
        captureMode: 'Manual entry',
        readiness: TestReadiness.ready,
      ),
      StandardizedTest(
        id: 'vertical_jump',
        name: 'Vertical Jump',
        description: 'Measure standing vertical jump using pose estimation',
        captureMode: 'Camera portrait',
        readiness: TestReadiness.ready,
        requirement: 'Mat marker required',
        model: 'JumpNet v1.2',
      ),
      StandardizedTest(
        id: 'situps_60',
        name: 'Sit-ups (60s)',
        description: 'Count valid sit-ups in 60 seconds',
        captureMode: 'Camera landscape',
        readiness: TestReadiness.ready,
      ),
      StandardizedTest(
        id: 'pushups_60',
        name: 'Push-ups (60s)',
        description: 'Count valid push-ups in 60 seconds',
        captureMode: 'Camera landscape',
        readiness: TestReadiness.ready,
      ),
      StandardizedTest(
        id: 'shuttle_run_20m',
        name: 'Shuttle Run 20m',
        description: 'Sprint between 20m markers',
        captureMode: 'Camera landscape',
        readiness: TestReadiness.needsGear,
        requirement: 'Needs cones',
      ),
      StandardizedTest(
        id: 'endurance_run_1600m',
        name: 'Endurance Run (1.6 km)',
        description: 'Long distance running assessment',
        captureMode: 'GPS + camera pop-ins',
        readiness: TestReadiness.ready,
        model: 'Model lite',
      ),
      StandardizedTest(
        id: 'flexibility',
        name: 'Flexibility (Sit & Reach)',
        description: 'Measure forward flexibility',
        captureMode: 'Camera portrait',
        readiness: TestReadiness.optional,
      ),
    ];
  }
}

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  bool _showVerifiedOnly = true;
  bool _showOnDeviceOnly = false;

  @override
  Widget build(BuildContext context) {
    final tests = StandardizedTest.getAllTests();
    
    return SafeArea(
      child: Column(
        children: [
          // Header with filters
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Standardized Tests',
                  style: AppTheme.heading,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    FilterChip(
                      label: Text('Verified'),
                      selected: _showVerifiedOnly,
                      onSelected: (selected) {
                        setState(() => _showVerifiedOnly = selected);
                      },
                      backgroundColor: AppTheme.cardBackground,
                      selectedColor: AppTheme.primary.withOpacity(0.2),
                      checkmarkColor: AppTheme.primary,
                      labelStyle: AppTheme.caption.copyWith(
                        color: _showVerifiedOnly ? AppTheme.primary : AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: Text('On-device only'),
                      selected: _showOnDeviceOnly,
                      onSelected: (selected) {
                        setState(() => _showOnDeviceOnly = selected);
                      },
                      backgroundColor: AppTheme.cardBackground,
                      selectedColor: AppTheme.primary.withOpacity(0.2),
                      checkmarkColor: AppTheme.primary,
                      labelStyle: AppTheme.caption.copyWith(
                        color: _showOnDeviceOnly ? AppTheme.primary : AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Tests list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: tests.length,
              itemBuilder: (context, index) {
                final test = tests[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TestCard(
                    test: test,
                    onTap: () => _showTestDetails(test),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showTestDetails(StandardizedTest test) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => TestDetailsSheet(test: test),
    );
  }
}

class TestCard extends StatelessWidget {
  final StandardizedTest test;
  final VoidCallback? onTap;

  const TestCard({super.key, required this.test, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: test.readiness == TestReadiness.needsGear
              ? Border.all(color: AppTheme.accent.withOpacity(0.3))
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getReadinessColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getTestIcon(),
                color: _getReadinessColor(),
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
                          style: AppTheme.bodyMedium,
                        ),
                      ),
                      _buildReadinessChip(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${test.captureMode}${test.requirement != null ? ' • ${test.requirement}' : ''}',
                    style: AppTheme.caption,
                  ),
                  if (test.model != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Model: ${test.model}',
                      style: AppTheme.caption.copyWith(
                        color: AppTheme.primary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppTheme.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadinessChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getReadinessColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getReadinessText(),
        style: AppTheme.caption.copyWith(
          color: _getReadinessColor(),
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getReadinessColor() {
    switch (test.readiness) {
      case TestReadiness.ready:
        return AppTheme.success;
      case TestReadiness.needsGear:
        return AppTheme.accent;
      case TestReadiness.modelDownloading:
        return AppTheme.accent;
      case TestReadiness.modelRequired:
        return AppTheme.error;
      case TestReadiness.optional:
        return AppTheme.textMuted;
    }
  }

  String _getReadinessText() {
    switch (test.readiness) {
      case TestReadiness.ready:
        return 'Ready';
      case TestReadiness.needsGear:
        return 'Needs Gear';
      case TestReadiness.modelDownloading:
        return 'Downloading';
      case TestReadiness.modelRequired:
        return 'Model Required';
      case TestReadiness.optional:
        return 'Optional';
    }
  }

  IconData _getTestIcon() {
    switch (test.id) {
      case 'height_weight':
        return Icons.straighten;
      case 'vertical_jump':
        return Icons.keyboard_double_arrow_up;
      case 'situps_60':
        return Icons.fitness_center;
      case 'pushups_60':
        return Icons.fitness_center;
      case 'shuttle_run_20m':
        return Icons.directions_run;
      case 'endurance_run_1600m':
        return Icons.directions_walk;
      case 'flexibility':
        return Icons.self_improvement;
      default:
        return Icons.assignment;
    }
  }
}

class TestDetailsSheet extends StatelessWidget {
  final StandardizedTest test;

  const TestDetailsSheet({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  test.name,
                  style: AppTheme.subheading,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, color: AppTheme.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'About',
            style: AppTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            test.description,
            style: AppTheme.body,
          ),
          const SizedBox(height: 16),
          Text(
            'Capture Mode',
            style: AppTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            test.captureMode,
            style: AppTheme.body,
          ),
          if (test.requirement != null) ...[
            const SizedBox(height: 16),
            Text(
              'Requirements',
              style: AppTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              test.requirement!,
              style: AppTheme.body,
            ),
          ],
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    debugPrint('Practice ${test.name}');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: BorderSide(color: AppTheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Practice'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: test.readiness == TestReadiness.ready
                      ? () {
                          Navigator.pop(context);
                          debugPrint('Start verified attempt: ${test.name}');
                        }
                      : null,
                  style: AppTheme.primaryButtonStyle,
                  child: Text('Start Verified Attempt'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
