import 'package:shared_preferences/shared_preferences.dart';

/// Handles all local persistence: high scores, unlocked levels, settings.
class StorageHelper {
  static const String _highScoreKey = 'high_score';
  static const String _unlockedLevelKey = 'unlocked_level';
  static const String _soundEnabledKey = 'sound_enabled';

  static late SharedPreferences _prefs;

  /// Call once at app startup.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ── High score ──

  static int getHighScore() => _prefs.getInt(_highScoreKey) ?? 0;

  static Future<void> setHighScore(int score) async {
    if (score > getHighScore()) {
      await _prefs.setInt(_highScoreKey, score);
    }
  }

  // ── Unlocked levels (stores the highest unlocked level number) ──

  static int getUnlockedLevel() => _prefs.getInt(_unlockedLevelKey) ?? 1;

  static Future<void> unlockNextLevel(int currentLevel) async {
    final next = currentLevel + 1;
    if (next > getUnlockedLevel()) {
      await _prefs.setInt(_unlockedLevelKey, next);
    }
  }

  // ── Sound setting ──

  static bool isSoundEnabled() => _prefs.getBool(_soundEnabledKey) ?? true;

  static Future<void> setSoundEnabled(bool enabled) async {
    await _prefs.setBool(_soundEnabledKey, enabled);
  }
}
