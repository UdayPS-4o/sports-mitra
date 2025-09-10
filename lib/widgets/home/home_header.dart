import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final VoidCallback? onSettingsTap;

  const HomeHeader({super.key, this.userName = 'Alex', this.onSettingsTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hi, $userName',
          style: GoogleFonts.lexend(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: onSettingsTap ?? () {},
          icon: const Icon(
            Icons.settings_outlined,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }
}
