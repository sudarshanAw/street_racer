import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/storage_helper.dart';
import 'level_select_screen.dart';
import 'settings_screen.dart';

/// The first screen the player sees – title, high score, and menu buttons.
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final highScore = StorageHelper.getHighScore();

    return Scaffold(
      backgroundColor: AppColors.menuBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Title ──
                const Text(
                  '🏎️',
                  style: TextStyle(fontSize: 64),
                ),
                const SizedBox(height: 8),
                const Text(
                  'STREET RACER',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: AppColors.accent,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'High Score: $highScore',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 48),

                // ── Start Game button ──
                _MenuButton(
                  label: 'START GAME',
                  color: AppColors.success,
                  icon: Icons.play_arrow_rounded,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LevelSelectScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // ── Settings button ──
                _MenuButton(
                  label: 'SETTINGS',
                  color: AppColors.textSecondary,
                  icon: Icons.settings_rounded,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable wide button for the main menu.
class _MenuButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _MenuButton({
    required this.label,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 28),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
