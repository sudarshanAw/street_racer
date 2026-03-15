import 'package:flutter/material.dart';
import '../models/level_config.dart';
import '../utils/constants.dart';
import '../utils/storage_helper.dart';
import 'game_screen.dart';

/// Grid of level cards. Locked levels are greyed out.
class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final unlockedLevel = StorageHelper.getUnlockedLevel();

    return Scaffold(
      backgroundColor: AppColors.menuBg,
      appBar: AppBar(
        title: const Text('SELECT LEVEL'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: LevelConfig.levels.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final level = LevelConfig.levels[index];
            final isUnlocked = level.levelNumber <= unlockedLevel;

            return _LevelCard(
              level: level,
              isUnlocked: isUnlocked,
              onTap: isUnlocked
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              GameScreen(levelConfig: level),
                        ),
                      );
                    }
                  : null,
            );
          },
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final LevelConfig level;
  final bool isUnlocked;
  final VoidCallback? onTap;

  const _LevelCard({
    required this.level,
    required this.isUnlocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isUnlocked ? AppColors.menuCard : AppColors.locked,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUnlocked ? AppColors.accent : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isUnlocked ? Icons.directions_car_rounded : Icons.lock_rounded,
                size: 36,
                color: isUnlocked ? AppColors.accent : AppColors.textSecondary,
              ),
              const SizedBox(height: 8),
              Text(
                'Level ${level.levelNumber}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      isUnlocked ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                level.name,
                style: TextStyle(
                  fontSize: 12,
                  color: isUnlocked
                      ? AppColors.textSecondary
                      : AppColors.textSecondary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
