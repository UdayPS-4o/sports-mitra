import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/sync_queue_item.dart';

class SyncSection extends StatelessWidget {
  final List<SyncQueueItem> queueItems;
  final DateTime? lastSync;
  final VoidCallback? onUploadNow;
  final VoidCallback? onViewQueue;

  const SyncSection({
    super.key,
    required this.queueItems,
    this.lastSync,
    this.onUploadNow,
    this.onViewQueue,
  });

  @override
  Widget build(BuildContext context) {
    final hasItems = queueItems.isNotEmpty;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: hasItems 
            ? Border.all(color: AppTheme.accent.withOpacity(0.3))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (hasItems ? AppTheme.accent : AppTheme.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  hasItems ? Icons.cloud_sync : Icons.cloud_done,
                  color: hasItems ? AppTheme.accent : AppTheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Sync & Offline',
                  style: AppTheme.bodyMedium,
                ),
              ),
              if (hasItems && onViewQueue != null)
                TextButton(
                  onPressed: onViewQueue,
                  child: Text(
                    'View Queue',
                    style: AppTheme.caption.copyWith(
                      color: AppTheme.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          
          if (hasItems) ...[
            Text(
              'Queue: ${queueItems.length} items',
              style: AppTheme.body,
            ),
            const SizedBox(height: 8),
            // Show first few items in queue
            ...queueItems.take(2).map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Icon(
                    _getStatusIcon(item.status),
                    size: 14,
                    color: _getStatusColor(item.status),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${item.testName} (${item.sizeDisplay})',
                      style: AppTheme.caption,
                    ),
                  ),
                  Text(
                    item.statusDisplay,
                    style: AppTheme.caption.copyWith(
                      color: _getStatusColor(item.status),
                    ),
                  ),
                ],
              ),
            )),
            if (queueItems.length > 2)
              Text(
                '+${queueItems.length - 2} more items',
                style: AppTheme.caption.copyWith(
                  color: AppTheme.textMuted,
                ),
              ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onUploadNow,
                style: AppTheme.accentButtonStyle.copyWith(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
                child: Text('Upload Now'),
              ),
            ),
          ] else ...[
            Text(
              'All synced',
              style: AppTheme.body.copyWith(color: AppTheme.primary),
            ),
          ],
          
          if (lastSync != null) ...[
            const SizedBox(height: 8),
            Text(
              'Last Sync: ${_formatLastSync(lastSync!)}',
              style: AppTheme.caption,
            ),
          ],
        ],
      ),
    );
  }

  IconData _getStatusIcon(SyncStatus status) {
    switch (status) {
      case SyncStatus.waiting:
        return Icons.schedule;
      case SyncStatus.uploading:
        return Icons.cloud_upload;
      case SyncStatus.completed:
        return Icons.cloud_done;
      case SyncStatus.failed:
        return Icons.error_outline;
      case SyncStatus.paused:
        return Icons.pause_circle_outline;
    }
  }

  Color _getStatusColor(SyncStatus status) {
    switch (status) {
      case SyncStatus.waiting:
        return AppTheme.textMuted;
      case SyncStatus.uploading:
        return AppTheme.accent;
      case SyncStatus.completed:
        return AppTheme.success;
      case SyncStatus.failed:
        return AppTheme.error;
      case SyncStatus.paused:
        return AppTheme.textMuted;
    }
  }

  String _formatLastSync(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  // Mock data factory
  static SyncSection mock({
    VoidCallback? onUploadNow,
    VoidCallback? onViewQueue,
  }) {
    return SyncSection(
      queueItems: SyncQueueItem.getMockQueueItems(),
      lastSync: DateTime.now().subtract(const Duration(hours: 2, minutes: 18)),
      onUploadNow: onUploadNow,
      onViewQueue: onViewQueue,
    );
  }
}
