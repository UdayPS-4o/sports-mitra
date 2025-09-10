import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isHighContrast = false;
  bool isLargerText = false;
  double hapticLevel = 0.5;
  String selectedLanguage = 'English';
  String selectedUnits = 'Metric (cm, kg)';

  final List<String> sports = ['Athletics', 'Basketball'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildProfileSection(),
                  const SizedBox(height: 24),
                  _buildLanguageUnitsSection(),
                  const SizedBox(height: 24),
                  _buildDownloadsSection(),
                  const SizedBox(height: 24),
                  _buildDataPrivacySection(),
                  const SizedBox(height: 24),
                  _buildAccessibilitySection(),
                  const SizedBox(height: 24),
                  _buildAboutSection(),
                  const SizedBox(height: 20),
                  _buildFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppTheme.primaryAccent,
            child: const Text(
              'AS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return _buildSection(
      title: 'Profile',
      children: [
        _buildProfileItem('Name', 'Aditi Sharma'),
        _buildProfileItem('Date of Birth', '15 March 2008'),
        _buildProfileItem('Gender', 'Female'),
        _buildProfileItem('City/District', 'Indore, Madhya Pradesh'),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 100,
              child: Text(
                'Sports',
                style: TextStyle(fontSize: 14, color: AppTheme.textMuted),
              ),
            ),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: sports
                    .map(
                      (sport) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppTheme.primaryAccent.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          sport,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.primaryAccent,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageUnitsSection() {
    return _buildSection(
      title: 'Language & Units',
      children: [
        _buildDropdownItem(
          'Language',
          selectedLanguage,
          ['English', 'Hindi'],
          (value) => setState(() => selectedLanguage = value!),
        ),
        _buildDropdownItem('Units', selectedUnits, [
          'Metric (cm, kg)',
          'Imperial (ft, lb)',
        ], (value) => setState(() => selectedUnits = value!)),
      ],
    );
  }

  Widget _buildDownloadsSection() {
    return _buildSection(
      title: 'Downloads',
      children: [
        _buildDownloadItem('AI Model Packs', '85 MB', 'Downloaded'),
        _buildDownloadItem('Hindi Language Pack', '12 MB', 'Available'),
        _buildDownloadItem('Offline Maps', '45 MB', 'Available'),
      ],
    );
  }

  Widget _buildDataPrivacySection() {
    return _buildSection(
      title: 'Data & Privacy',
      children: [
        _buildActionItem(
          'Export My Data',
          'Download all your assessment data',
          Icons.download_outlined,
          () => _showExportDialog(),
        ),
        _buildActionItem(
          'Delete Account',
          'Permanently delete your account and data',
          Icons.delete_outline,
          () => _showDeleteDialog(),
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildAccessibilitySection() {
    return _buildSection(
      title: 'Accessibility',
      children: [
        _buildSwitchItem(
          'Larger Text',
          'Increase text size for better readability',
          isLargerText,
          (value) => setState(() => isLargerText = value),
        ),
        _buildSwitchItem(
          'High Contrast',
          'Improve visibility with higher contrast',
          isHighContrast,
          (value) => setState(() => isHighContrast = value),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 100,
              child: Text(
                'Haptic Level',
                style: TextStyle(fontSize: 14, color: AppTheme.textMuted),
              ),
            ),
            Expanded(
              child: Slider(
                value: hapticLevel,
                onChanged: (value) => setState(() => hapticLevel = value),
                activeColor: AppTheme.primaryAccent,
                inactiveColor: AppTheme.borderColor,
                thumbColor: AppTheme.primaryAccent,
              ),
            ),
            Text(
              '${(hapticLevel * 100).round()}%',
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return _buildSection(
      title: 'About',
      children: [
        _buildAboutItem('Version', '1.0.0 (Build 100)'),
        _buildActionItem(
          'Contact Support',
          'Get help with the app',
          Icons.support_agent_outlined,
          () => debugPrint('Contact support tapped'),
        ),
        _buildActionItem(
          'Privacy Policy',
          'Read our privacy policy',
          Icons.privacy_tip_outlined,
          () => debugPrint('Privacy policy tapped'),
        ),
        _buildActionItem(
          'Terms of Service',
          'Read our terms of service',
          Icons.article_outlined,
          () => debugPrint('Terms of service tapped'),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primaryAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Athlete',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppTheme.primaryAccent,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Digital ID: SM-IN-7A2C94',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textMuted,
              fontFamily: 'monospace',
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => debugPrint('Show QR code tapped'),
            icon: const Icon(
              Icons.qr_code,
              color: AppTheme.textMuted,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: AppTheme.textMuted),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: AppTheme.textMuted),
            ),
          ),
          Expanded(
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              dropdownColor: AppTheme.surfaceColor,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
              ),
              underline: Container(),
              icon: const Icon(
                Icons.expand_more,
                color: AppTheme.textMuted,
                size: 20,
              ),
              items: options
                  .map(
                    (option) =>
                        DropdownMenuItem(value: option, child: Text(option)),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadItem(String name, String size, String status) {
    final isDownloaded = status == 'Downloaded';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            isDownloaded ? Icons.check_circle : Icons.download_outlined,
            color: isDownloaded ? AppTheme.verified : AppTheme.textMuted,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  '$size • $status',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          if (!isDownloaded)
            TextButton(
              onPressed: () => debugPrint('Download $name'),
              child: const Text(
                'Download',
                style: TextStyle(fontSize: 12, color: AppTheme.primaryAccent),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDestructive ? AppTheme.danger : AppTheme.textMuted,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDestructive
                            ? AppTheme.danger
                            : AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppTheme.textMuted, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchItem(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primaryAccent,
            activeTrackColor: AppTheme.primaryAccent.withOpacity(0.3),
            inactiveThumbColor: AppTheme.textMuted,
            inactiveTrackColor: AppTheme.borderColor,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: AppTheme.textMuted),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text(
          'Export Data',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: const Text(
          'Your assessment data will be exported as a PDF file. This may take a few moments.',
          style: TextStyle(color: AppTheme.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              debugPrint('Export data initiated');
            },
            style: AppTheme.primaryButtonStyle,
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text(
          'Delete Account',
          style: TextStyle(color: AppTheme.danger),
        ),
        content: const Text(
          'This action cannot be undone. All your data will be permanently deleted.',
          style: TextStyle(color: AppTheme.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              debugPrint('Account deletion initiated');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.danger,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
