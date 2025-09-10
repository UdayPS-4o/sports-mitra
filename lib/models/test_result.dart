enum TestStatus {
  draft,
  uploaded,
  aiVerified,
  officialVerified,
  flagged,
  needsReview,
  rejected,
}

enum TestType {
  verticalJump,
  situps60,
  pushups60,
  shuttleRun20m,
  enduranceRun1600m,
  heightWeight,
  flexibility,
}

class TestResult {
  final String id;
  final TestType testType;
  final DateTime date;
  final TestStatus status;
  final dynamic score; // Can be different types based on test
  final String? unit;
  final int? percentile;
  final double? formScore;
  final List<String> flags;
  final String? notes;
  final String? verifiedBy;

  const TestResult({
    required this.id,
    required this.testType,
    required this.date,
    required this.status,
    required this.score,
    this.unit,
    this.percentile,
    this.formScore,
    this.flags = const [],
    this.notes,
    this.verifiedBy,
  });

  String get testName {
    switch (testType) {
      case TestType.verticalJump:
        return 'Vertical Jump';
      case TestType.situps60:
        return 'Sit-ups (60s)';
      case TestType.pushups60:
        return 'Push-ups (60s)';
      case TestType.shuttleRun20m:
        return 'Shuttle Run 20m';
      case TestType.enduranceRun1600m:
        return 'Endurance Run 1.6km';
      case TestType.heightWeight:
        return 'Height & Weight';
      case TestType.flexibility:
        return 'Flexibility';
    }
  }

  String get displayScore {
    if (score == null) return '--';
    return '$score${unit ?? ''}';
  }

  String get statusDisplay {
    switch (status) {
      case TestStatus.draft:
        return 'Draft';
      case TestStatus.uploaded:
        return 'Uploaded';
      case TestStatus.aiVerified:
        return 'AI-Verified';
      case TestStatus.officialVerified:
        return 'Verified';
      case TestStatus.flagged:
        return 'Flagged';
      case TestStatus.needsReview:
        return 'Needs Review';
      case TestStatus.rejected:
        return 'Rejected';
    }
  }

  bool get isVerified => status == TestStatus.officialVerified;
  bool get isPending => status == TestStatus.uploaded || status == TestStatus.draft;
  bool get isFlagged => status == TestStatus.flagged || flags.isNotEmpty;

  // Mock data for development
  static List<TestResult> getMockResults() {
    final now = DateTime.now();
    return [
      TestResult(
        id: 'VJ001',
        testType: TestType.verticalJump,
        date: now.subtract(const Duration(days: 2)),
        status: TestStatus.officialVerified,
        score: 41.2,
        unit: ' cm',
        percentile: 82,
        formScore: 92.0,
        flags: [],
        verifiedBy: 'Indore District Official',
      ),
      TestResult(
        id: 'SR001',
        testType: TestType.shuttleRun20m,
        date: now.subtract(const Duration(days: 4)),
        status: TestStatus.uploaded,
        score: 11.63,
        unit: ' s',
        formScore: 88.0,
        flags: [],
      ),
      TestResult(
        id: 'PU001',
        testType: TestType.pushups60,
        date: now.subtract(const Duration(days: 5)),
        status: TestStatus.officialVerified,
        score: 28,
        unit: ' reps',
        percentile: 74,
        formScore: 95.0,
        flags: [],
        verifiedBy: 'Indore District Official',
      ),
      TestResult(
        id: 'VJ002',
        testType: TestType.verticalJump,
        date: now.subtract(const Duration(days: 7)),
        status: TestStatus.flagged,
        score: 39.0,
        unit: ' cm',
        formScore: 85.0,
        flags: ['angle_drift'],
      ),
    ];
  }
}
