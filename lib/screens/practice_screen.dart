import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class Drill {
  final String id;
  final String name;
  final String description;
  final String duration;
  final String difficulty;
  final bool completed;

  const Drill({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.difficulty,
    this.completed = false,
  });

  static List<Drill> getMockDrills() {
    return const [
      Drill(
        id: 'box_jumps',
        name: 'Box Jumps',
        description: 'Explosive vertical jump training',
        duration: '3x8 reps',
        difficulty: 'Intermediate',
        completed: true,
      ),
      Drill(
        id: 'core_plank',
        name: 'Core Plank',
        description: 'Build core strength and stability',
        duration: '3x45s',
        difficulty: 'Beginner',
        completed: false,
      ),
      Drill(
        id: 'shuttle_runs',
        name: 'Shuttle Runs',
        description: 'Improve agility and speed',
        duration: '5x20m',
        difficulty: 'Intermediate',
        completed: false,
      ),
      Drill(
        id: 'plyometric_pushups',
        name: 'Plyometric Push-ups',
        description: 'Explosive upper body power',
        duration: '3x5 reps',
        difficulty: 'Advanced',
        completed: false,
      ),
    ];
  }
}

class HowToVideo {
  final String id;
  final String testName;
  final String title;
  final String duration;
  final String thumbnail;

  const HowToVideo({
    required this.id,
    required this.testName,
    required this.title,
    required this.duration,
    required this.thumbnail,
  });

  static List<HowToVideo> getMockVideos() {
    return const [
      HowToVideo(
        id: 'vj_howto',
        testName: 'Vertical Jump',
        title: 'Proper Vertical Jump Technique',
        duration: '0:18',
        thumbnail: 'assets/thumbnails/vj_thumb.jpg',
      ),
      HowToVideo(
        id: 'situps_howto',
        testName: 'Sit-ups',
        title: 'Perfect Sit-up Form',
        duration: '0:15',
        thumbnail: 'assets/thumbnails/situps_thumb.jpg',
      ),
      HowToVideo(
        id: 'pushups_howto',
        testName: 'Push-ups',
        title: 'Push-up Standards & Form',
        duration: '0:20',
        thumbnail: 'assets/thumbnails/pushups_thumb.jpg',
      ),
      HowToVideo(
        id: 'shuttle_howto',
        testName: 'Shuttle Run',
        title: 'Shuttle Run Setup & Technique',
        duration: '0:25',
        thumbnail: 'assets/thumbnails/shuttle_thumb.jpg',
      ),
    ];
  }
}

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Practice', style: AppTheme.heading),
                const SizedBox(height: 8),
                Text(
                  'No-stakes training to improve your form',
                  style: AppTheme.body,
                ),
              ],
            ),
          ),
          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              indicatorPadding: const EdgeInsets.all(4),
              labelColor: Colors.white,
              unselectedLabelColor: AppTheme.textSecondary,
              labelStyle: AppTheme.bodyMedium.copyWith(fontSize: 13),
              unselectedLabelStyle: AppTheme.body.copyWith(fontSize: 13),
              tabs: const [
                Tab(text: 'How-to'),
                Tab(text: 'Drills'),
                Tab(text: 'Form Lab'),
              ],
            ),
          ),
          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildHowToTab(),
                _buildDrillsTab(),
                _buildFormLabTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowToTab() {
    final videos = HowToVideo.getMockVideos();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: VideoCard(
            video: video,
            onTap: () {
              debugPrint('Play video: ${video.title}');
            },
          ),
        );
      },
    );
  }

  Widget _buildDrillsTab() {
    final drills = Drill.getMockDrills();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: drills.length,
      itemBuilder: (context, index) {
        final drill = drills[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DrillCard(
            drill: drill,
            onTap: () {
              debugPrint('Start drill: ${drill.name}');
            },
            onToggleComplete: () {
              debugPrint('Toggle complete: ${drill.name}');
            },
          ),
        );
      },
    );
  }

  Widget _buildFormLabTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.videocam_outlined,
                  size: 48,
                  color: AppTheme.primary,
                ),
                const SizedBox(height: 16),
                Text('Form Lab', style: AppTheme.subheading),
                const SizedBox(height: 8),
                Text(
                  'Record short clips to get immediate feedback on your form. These recordings are not stored for assessment.',
                  style: AppTheme.body,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint('Start Form Lab recording');
                    },
                    style: AppTheme.primaryButtonStyle,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.play_circle_outline, size: 18),
                        const SizedBox(width: 8),
                        Text('Start Form Check'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppTheme.accent, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Practice recordings are not saved and do not count toward your assessment scores.',
                    style: AppTheme.caption.copyWith(color: AppTheme.accent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final HowToVideo video;
  final VoidCallback? onTap;

  const VideoCard({super.key, required this.video, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    color: AppTheme.primary,
                    size: 32,
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video.duration,
                        style: AppTheme.caption.copyWith(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.testName,
                    style: AppTheme.caption.copyWith(color: AppTheme.primary),
                  ),
                  const SizedBox(height: 4),
                  Text(video.title, style: AppTheme.bodyMedium),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppTheme.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}

class DrillCard extends StatelessWidget {
  final Drill drill;
  final VoidCallback? onTap;
  final VoidCallback? onToggleComplete;

  const DrillCard({
    super.key,
    required this.drill,
    this.onTap,
    this.onToggleComplete,
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
          border: drill.completed
              ? Border.all(color: AppTheme.success.withOpacity(0.3))
              : null,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: onToggleComplete,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: drill.completed
                      ? AppTheme.success
                      : Colors.transparent,
                  border: Border.all(
                    color: drill.completed
                        ? AppTheme.success
                        : AppTheme.textMuted,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: drill.completed
                    ? Icon(Icons.check, color: Colors.white, size: 16)
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
                          drill.name,
                          style: AppTheme.bodyMedium.copyWith(
                            decoration: drill.completed
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                      _buildDifficultyChip(drill.difficulty),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${drill.duration} • ${drill.description}',
                    style: AppTheme.caption,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppTheme.textMuted, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyChip(String difficulty) {
    Color color;
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        color = AppTheme.success;
        break;
      case 'intermediate':
        color = AppTheme.accent;
        break;
      case 'advanced':
        color = AppTheme.error;
        break;
      default:
        color = AppTheme.textMuted;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        difficulty,
        style: AppTheme.caption.copyWith(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
