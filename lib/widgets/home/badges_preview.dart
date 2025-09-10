import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/badge.dart' as badges;

class BadgesPreview extends StatelessWidget {
  final List<badges.Badge> badgesList;
  final VoidCallback? onViewAllTap;

  const BadgesPreview({super.key, required this.badgesList, this.onViewAllTap});

  @override
  Widget build(BuildContext context) {
    // Show only badges that are in progress or recently unlocked
    final displayBadges = badgesList
        .where(
          (badge) =>
              badge.status == badges.BadgeStatus.inProgress ||
              badge.status == badges.BadgeStatus.unlocked,
        )
        .take(2)
        .toList();

    if (displayBadges.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Badges', style: AppTheme.subheading),
            if (onViewAllTap != null)
              TextButton(
                onPressed: onViewAllTap,
                child: Text(
                  'View All',
                  style: AppTheme.caption.copyWith(color: AppTheme.primary),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        ...displayBadges.map(
          (badge) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BadgeCard(badge: badge),
          ),
        ),
      ],
    );
  }
}

class BadgeCard extends StatelessWidget {
  final badges.Badge badge;

  const BadgeCard({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: badge.status == badges.BadgeStatus.unlocked
            ? Border.all(color: AppTheme.primary, width: 1)
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getBadgeColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_getBadgeIcon(), color: _getBadgeColor(), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(badge.name, style: AppTheme.bodyMedium),
                const SizedBox(height: 4),
                if (badge.status == badges.BadgeStatus.inProgress &&
                    badge.target != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress ${badge.progressDisplay}',
                        style: AppTheme.caption,
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: badge.progressPercentage,
                        backgroundColor: AppTheme.surfaceColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getBadgeColor(),
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    badge.status == badges.BadgeStatus.unlocked
                        ? 'Unlocked!'
                        : badge.description,
                    style: AppTheme.caption.copyWith(
                      color: badge.status == badges.BadgeStatus.unlocked
                          ? AppTheme.primary
                          : AppTheme.textMuted,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getBadgeColor() {
    switch (badge.status) {
      case badges.BadgeStatus.unlocked:
        return AppTheme.primary;
      case badges.BadgeStatus.inProgress:
        return AppTheme.accent;
      case badges.BadgeStatus.locked:
        return AppTheme.textMuted;
    }
  }

  IconData _getBadgeIcon() {
    // You could have badge-specific icons based on badge.id
    switch (badge.id) {
      case 'clean_form':
        return Icons.military_tech;
      case 'consistency_7':
      case 'consistency_14':
      case 'consistency_30':
        return Icons.local_fire_department;
      case 'form_perfecter':
        return Icons.star;
      case 'district_top10':
        return Icons.emoji_events;
      default:
        return Icons.emoji_events;
    }
  }
}
