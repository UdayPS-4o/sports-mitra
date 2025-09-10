import 'package:flutter/material.dart';
import '../models/athlete.dart';
import '../models/test_result.dart';
import '../models/badge.dart' as badges;
import '../widgets/home/welcome_header.dart';
import '../widgets/home/recommendation_card.dart';
import '../widgets/home/progress_ring.dart';
import '../widgets/home/recent_results.dart';
import '../widgets/home/badges_preview.dart';
import '../widgets/home/sync_section.dart';
import '../widgets/home/announcements_section.dart';
import '../widgets/home/feature_card.dart';
import '../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 20),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 8),

                  // 1. Welcome Header
                  WelcomeHeader(
                    athlete: Athlete.getMockAthlete(),
                    onQrTap: () {
                      debugPrint('QR code tapped - show Digital ID');
                    },
                  ),
                  const SizedBox(height: 20),

                  // 2. Today's Recommendation
                  RecommendationCard.mock(
                    onStartTest: () {
                      debugPrint('Start recommended test tapped');
                    },
                  ),
                  const SizedBox(height: 20),

                  // 3. Progress Ring
                  ProgressRing.mock(),
                  const SizedBox(height: 24),

                  // 4. Recent Results
                  RecentResults(
                    results: TestResult.getMockResults(),
                    onResultTap: (result) {
                      debugPrint('Result tapped: ${result.testName}');
                    },
                  ),
                  const SizedBox(height: 24),

                  // 5. Badges Preview
                  BadgesPreview(
                    badgesList: badges.Badge.getMockBadges(),
                    onViewAllTap: () {
                      debugPrint('View all badges tapped');
                    },
                  ),
                  const SizedBox(height: 20),

                  // 6. Sync & Offline
                  SyncSection.mock(
                    onUploadNow: () {
                      debugPrint('Upload now tapped');
                    },
                    onViewQueue: () {
                      debugPrint('View sync queue tapped');
                    },
                  ),
                  const SizedBox(height: 20),

                  // 7. Announcements
                  AnnouncementsSection(
                    announcements: Announcement.getMockAnnouncements(),
                    onAnnouncementTap: (announcement) {
                      debugPrint('Announcement tapped: ${announcement.title}');
                    },
                  ),
                  const SizedBox(height: 20),

                  // 8. AI Diet Planner
                  FeatureCard(
                    title: 'AI Diet Planner',
                    description:
                        'Personalized meal plans for peak performance.',
                    buttonText: 'Get Started',
                    icon: Icons.restaurant_menu,
                    backgroundColor: AppTheme.verified,
                    buttonColor: AppTheme.verified.withOpacity(0.8),
                    backgroundImage: 'assets/images/diet_planner.png',
                    onPressed: () {
                      debugPrint('AI Diet Planner tapped');
                    },
                  ),
                  const SizedBox(height: 16),

                  // 9. Find a Coach
                  FeatureCard(
                    title: 'Find a Coach',
                    description:
                        'Connect with experienced coaches in your area.',
                    buttonText: 'Find Coach',
                    icon: Icons.person_pin_circle_outlined,
                    backgroundColor: AppTheme.primaryAccent,
                    buttonColor: AppTheme.primaryAccent.withOpacity(0.8),
                    backgroundImage: 'assets/images/find_coach.png',
                    onPressed: () {
                      debugPrint('Find a Coach tapped');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
