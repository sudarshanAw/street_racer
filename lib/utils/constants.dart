import 'dart:ui';

/// ── Game-wide constants ──
/// Centralizes all tunable values so you can tweak the game from one place.

class GameConstants {
  // ── Canvas / road ──
  static const double roadWidthRatio = 0.6; // fraction of screen width
  static const int laneCount = 3;

  // ── Player ──
  static const double playerWidthRatio = 0.12; // relative to screen width
  static const double playerHeightRatio = 0.08; // relative to screen height
  static const double playerStartYRatio = 0.80; // how far down the screen

  // ── Enemies / obstacles ──
  static const double enemyWidthRatio = 0.11;
  static const double enemyHeightRatio = 0.07;
  static const double obstacleWidthRatio = 0.08;
  static const double obstacleHeightRatio = 0.05;

  // ── Coins ──
  static const double coinSize = 24;
  static const int coinScoreValue = 50;

  // ── Scoring ──
  static const int distanceScorePerSecond = 10;

  // ── Lives ──
  static const int maxLives = 3;

  // ── Spawn intervals (seconds) – overridden per level ──
  static const double baseEnemySpawnInterval = 1.8;
  static const double baseObstacleSpawnInterval = 3.0;
  static const double baseCoinSpawnInterval = 2.5;

  // ── Level completion ──
  static const double baseLevelDuration = 30; // seconds to survive per level
}

/// Colour palette used across the game.
class AppColors {
  static const Color road = Color(0xFF333333);
  static const Color roadLine = Color(0xFFFFFFFF);
  static const Color grass = Color(0xFF2E7D32);
  static const Color playerCar = Color(0xFF1565C0);
  static const Color enemyCar = Color(0xFFC62828);
  static const Color obstacle = Color(0xFF795548);
  static const Color coin = Color(0xFFFFD600);
  static const Color hudBackground = Color(0xCC000000);
  static const Color accent = Color(0xFFFF6D00);
  static const Color menuBg = Color(0xFF0D1B2A);
  static const Color menuCard = Color(0xFF1B2838);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color success = Color(0xFF4CAF50);
  static const Color danger = Color(0xFFEF5350);
  static const Color locked = Color(0xFF616161);
}
