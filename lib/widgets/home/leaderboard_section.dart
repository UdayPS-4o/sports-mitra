import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/leaderboard_user.dart';

class LeaderboardSection extends StatelessWidget {
  final List<LeaderboardUser> users;
  final VoidCallback? onViewAll;

  const LeaderboardSection({super.key, required this.users, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('District Leaderboard', style: AppTheme.heading),
        const SizedBox(height: 16),
        ...users.map(
          (user) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: LeaderboardTile(user: user),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: onViewAll,
            child: Text('View All', style: AppTheme.caption),
          ),
        ),
      ],
    );
  }
}

class LeaderboardTile extends StatelessWidget {
  final LeaderboardUser user;

  const LeaderboardTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white.withOpacity(0.1),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[800],
            backgroundImage: user.avatarUrl != null
                ? NetworkImage(user.avatarUrl!)
                : null,
            child: user.avatarUrl == null
                ? Text(
                    user.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${user.rank}. ${user.name}', style: AppTheme.subheading),
              const SizedBox(height: 4),
              Text(user.pointsDisplay, style: AppTheme.caption),
            ],
          ),
        ),
      ],
    );
  }
}
