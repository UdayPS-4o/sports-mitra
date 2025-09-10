enum SyncStatus {
  waiting,
  uploading,
  completed,
  failed,
  paused,
}

class SyncQueueItem {
  final String id;
  final String testId;
  final String testName;
  final SyncStatus status;
  final double sizeInMB;
  final DateTime createdAt;
  final double? progress; // 0.0 to 1.0

  const SyncQueueItem({
    required this.id,
    required this.testId,
    required this.testName,
    required this.status,
    required this.sizeInMB,
    required this.createdAt,
    this.progress,
  });

  String get statusDisplay {
    switch (status) {
      case SyncStatus.waiting:
        return 'Waiting';
      case SyncStatus.uploading:
        return 'Uploading';
      case SyncStatus.completed:
        return 'Completed';
      case SyncStatus.failed:
        return 'Failed';
      case SyncStatus.paused:
        return 'Paused';
    }
  }

  String get sizeDisplay => '${sizeInMB.toStringAsFixed(1)} MB';

  // Mock data for development
  static List<SyncQueueItem> getMockQueueItems() {
    final now = DateTime.now();
    return [
      SyncQueueItem(
        id: 'UPD-9C3F1A',
        testId: 'SR001',
        testName: 'Shuttle Run',
        status: SyncStatus.waiting,
        sizeInMB: 142.0,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      SyncQueueItem(
        id: 'UPD-8B2E9D',
        testId: 'VJ003',
        testName: 'Vertical Jump',
        status: SyncStatus.uploading,
        sizeInMB: 89.5,
        createdAt: now.subtract(const Duration(hours: 1)),
        progress: 0.65,
      ),
    ];
  }
}
