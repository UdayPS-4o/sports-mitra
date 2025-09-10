import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/athlete.dart';

class WelcomeHeader extends StatelessWidget {
  final Athlete athlete;
  final VoidCallback? onQrTap;

  const WelcomeHeader({
    super.key,
    required this.athlete,
    this.onQrTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F172A), // slate-900 tint
            Color(0xFF111827), // card surface
          ],
        ),
        border: Border.all(color: AppTheme.borderColor.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppTheme.gradientStart.withOpacity(0.25),
                  AppTheme.gradientEnd.withOpacity(0.25),
                ],
              ),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.primary.withOpacity(0.15),
              backgroundImage: athlete.photoUrl != null
                  ? NetworkImage(athlete.photoUrl!)
                  : null,
              child: athlete.photoUrl == null
                  ? Text(
                      athlete.name
                          .split(' ')
                          .map((n) => n[0])
                          .join('')
                          .toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        athlete.name,
                        style: AppTheme.heading.copyWith(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: onQrTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.borderColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.qr_code,
                              size: 14,
                              color: AppTheme.textPrimary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              athlete.displayId,
                              style: AppTheme.caption.copyWith(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Stay on track. You’re close to your weekly goal.',
                  style: AppTheme.body.copyWith(color: AppTheme.textMuted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
