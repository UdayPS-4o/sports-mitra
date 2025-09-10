import 'package:flutter/material.dart';

class SportsStat {
  final String title;
  final String value;
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final IconData icon;
  final Color textColor;

  const SportsStat({
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.iconBackgroundColor,
    required this.icon,
    required this.textColor,
  });

  // Mock data for development
  static List<SportsStat> getMockStats() {
    return const [
      SportsStat(
        title: 'Shuttle Run',
        value: '10.2s',
        backgroundColor: Color(0xFF1e2a3a),
        iconBackgroundColor: Color(0xFF22c55e),
        icon: Icons.run_circle_outlined,
        textColor: Colors.white,
      ),
      SportsStat(
        title: 'Sit-ups',
        value: '45 reps',
        backgroundColor: Color(0xFFFEF3C7),
        iconBackgroundColor: Color(0xFFF59E0B),
        icon: Icons.fitness_center,
        textColor: Colors.black,
      ),
    ];
  }
}
