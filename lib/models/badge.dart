enum BadgeStatus {
  locked,
  inProgress,
  unlocked,
}

class Badge {
  final String id;
  final String name;
  final String description;
  final BadgeStatus status;
  final int? progress;
  final int? target;
  final String? iconPath;

  const Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    this.progress,
    this.target,
    this.iconPath,
  });

  double get progressPercentage {
    if (progress == null || target == null || target == 0) return 0.0;
    return (progress! / target!).clamp(0.0, 1.0);
  }

  String get progressDisplay {
    if (progress == null || target == null) return '';
    return '$progress/$target';
  }

  // Mock data for development
  static List<Badge> getMockBadges() {
    return const [
      Badge(
        id: 'clean_form',
        name: 'Clean Form',
        description: '95%+ form in any test (3 times)',
        status: BadgeStatus.unlocked,
        progress: 3,
        target: 3,
      ),
      Badge(
        id: 'consistency_7',
        name: 'Consistency Streak',
        description: 'Complete tests for 7 consecutive days',
        status: BadgeStatus.inProgress,
        progress: 5,
        target: 7,
      ),
      Badge(
        id: 'form_perfecter',
        name: 'Form Perfecter',
        description: '3/5 tests with 95% form score',
        status: BadgeStatus.inProgress,
        progress: 3,
        target: 5,
      ),
      Badge(
        id: 'district_top10',
        name: 'Rising Star',
        description: 'Top 10 in district leaderboard',
        status: BadgeStatus.locked,
      ),
    ];
  }
}
