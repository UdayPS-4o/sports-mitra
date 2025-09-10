import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Modern Dark UI Colors (per structure.md)
  static const Color primaryAccent = Color(0xFF3B82F6); // Blue
  static const Color secondaryAccent = Color(0xFF14B8A6); // Teal
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color danger = Color(0xFFEF4444); // Red
  static const Color success = Color(0xFF10B981); // Success green

  // Legacy color aliases for backward compatibility
  static const Color primary = primaryAccent;
  static const Color secondary = secondaryAccent;
  static const Color accent = warning;
  static const Color error = danger;

  // Background colors (Modern Dark)
  static const Color primaryBackground = Color(0xFF0C1320); // Deep navy
  static const Color cardBackground = Color(0xFF111827); // Surface/Card
  static const Color surfaceColor = Color(0xFF1F2937); // Elevated surface

  // Status colors
  static const Color verified = Color(0xFF10B981); // Green for verified
  static const Color pending = Color(0xFF6B7280); // Gray for pending
  static const Color flagged = Color(0xFFF59E0B); // Amber for flagged
  static const Color aiVerified = Color(0xFFF59E0B); // Amber for AI-verified

  // Text colors (Modern specs)
  static const Color textPrimary = Color(0xFFE5E7EB); // Primary text
  static const Color textMuted = Color(0xFF9CA3AF); // Muted text
  static const Color textSecondary = Color(0xFF6B7280); // Secondary text

  // Border colors
  static const Color borderColor = Color(0xFF374151);

  // Gradient colors for effects
  static const Color gradientStart = Color(0xFF3B82F6);
  static const Color gradientEnd = Color(0xFF14B8A6);

  // Text Styles (Using Inter font as per spec)
  static TextStyle get heading => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700, // Inter 700
    color: textPrimary,
  );

  static TextStyle get subheading => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400, // Inter 400
    color: textSecondary,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500, // Inter 500
    color: textPrimary,
  );

  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textMuted,
  );

  // Numeric styles (SF Mono/Roboto Mono as per spec)
  static TextStyle get numeric => GoogleFonts.robotoMono(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle get numericLarge => GoogleFonts.robotoMono(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );

  // Theme Data
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: primaryBackground,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: accent,
      surface: cardBackground,
      background: primaryBackground,
    ),
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: textPrimary,
      displayColor: textPrimary,
    ),
  );

  // Button Styles
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
  );

  static ButtonStyle get accentButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: accent,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
  );

  static ButtonStyle get secondaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: cardBackground,
    foregroundColor: textPrimary,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14),
  );
}
