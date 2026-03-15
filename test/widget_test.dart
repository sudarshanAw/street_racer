import 'package:flutter_test/flutter_test.dart';
import 'package:street_racer/models/level_config.dart';
import 'package:street_racer/utils/constants.dart';

void main() {
  group('LevelConfig', () {
    test('should have exactly 5 levels', () {
      expect(LevelConfig.levels.length, 5);
    });

    test('levels should increase in scroll speed', () {
      for (int i = 1; i < LevelConfig.levels.length; i++) {
        expect(
          LevelConfig.levels[i].scrollSpeed,
          greaterThan(LevelConfig.levels[i - 1].scrollSpeed),
        );
      }
    });

    test('levels should decrease in enemy spawn interval (harder)', () {
      for (int i = 1; i < LevelConfig.levels.length; i++) {
        expect(
          LevelConfig.levels[i].enemySpawnInterval,
          lessThan(LevelConfig.levels[i - 1].enemySpawnInterval),
        );
      }
    });
  });

  group('GameConstants', () {
    test('road width ratio should be between 0 and 1', () {
      expect(GameConstants.roadWidthRatio, greaterThan(0));
      expect(GameConstants.roadWidthRatio, lessThan(1));
    });

    test('lane count should be at least 2', () {
      expect(GameConstants.laneCount, greaterThanOrEqualTo(2));
    });
  });
}
