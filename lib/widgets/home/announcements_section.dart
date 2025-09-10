import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class Announcement {
  final String id;
  final String title;
  final String? subtitle;
  final DateTime date;
  final bool isImportant;

  const Announcement({
    required this.id,
    required this.title,
    this.subtitle,
    required this.date,
    this.isImportant = false,
  });

  static List<Announcement> getMockAnnouncements() {
    return [
      Announcement(
        id: '1',
        title: 'District Trials open 15 Oct',
        subtitle: 'See details',
        date: DateTime.now().subtract(const Duration(days: 1)),
        isImportant: true,
      ),
      Announcement(
        id: '2',
        title: 'New AI model update available',
        subtitle: 'Improved accuracy for vertical jump detection',
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }
}

class AnnouncementsSection extends StatelessWidget {
  final List<Announcement> announcements;
  final Function(Announcement)? onAnnouncementTap;

  const AnnouncementsSection({
    super.key,
    required this.announcements,
    this.onAnnouncementTap,
  });

  @override
  Widget build(BuildContext context) {
    if (announcements.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Announcements',
          style: AppTheme.subheading,
        ),
        const SizedBox(height: 12),
        ...announcements.take(3).map((announcement) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: AnnouncementCard(
            announcement: announcement,
            onTap: () => onAnnouncementTap?.call(announcement),
          ),
        )),
      ],
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback? onTap;

  const AnnouncementCard({
    super.key,
    required this.announcement,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: announcement.isImportant
              ? Border.all(color: AppTheme.accent.withOpacity(0.3))
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (announcement.isImportant ? AppTheme.accent : AppTheme.primary)
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                announcement.isImportant
                    ? Icons.campaign
                    : Icons.notifications_outlined,
                color: announcement.isImportant ? AppTheme.accent : AppTheme.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement.title,
                    style: AppTheme.bodyMedium.copyWith(
                      color: announcement.isImportant
                          ? AppTheme.accent
                          : AppTheme.textPrimary,
                    ),
                  ),
                  if (announcement.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      announcement.subtitle!,
                      style: AppTheme.caption,
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppTheme.textMuted,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
