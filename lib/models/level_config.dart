/// Describes difficulty parameters for a single level.
class LevelConfig {
  final int levelNumber;
  final String name;
  final double scrollSpeed; // road pixels-per-second
  final double enemySpawnInterval; // seconds between enemy cars
  final double obstacleSpawnInterval; // seconds between obstacles
  final double coinSpawnInterval; // seconds between coins
  final double duration; // seconds to survive
  final int maxEnemiesOnScreen;

  const LevelConfig({
    required this.levelNumber,
    required this.name,
    required this.scrollSpeed,
    required this.enemySpawnInterval,
    required this.obstacleSpawnInterval,
    required this.coinSpawnInterval,
    required this.duration,
    required this.maxEnemiesOnScreen,
  });

  /// Pre-defined levels 1-5 with increasing difficulty.
  static const List<LevelConfig> levels = [
    LevelConfig(
      levelNumber: 1,
      name: 'Sunday Drive',
      scrollSpeed: 200,
      enemySpawnInterval: 2.2,
      obstacleSpawnInterval: 4.0,
      coinSpawnInterval: 2.5,
      duration: 30,
      maxEnemiesOnScreen: 2,
    ),
    LevelConfig(
      levelNumber: 2,
      name: 'City Rush',
      scrollSpeed: 260,
      enemySpawnInterval: 1.8,
      obstacleSpawnInterval: 3.2,
      coinSpawnInterval: 2.2,
      duration: 35,
      maxEnemiesOnScreen: 3,
    ),
    LevelConfig(
      levelNumber: 3,
      name: 'Highway Heat',
      scrollSpeed: 330,
      enemySpawnInterval: 1.4,
      obstacleSpawnInterval: 2.5,
      coinSpawnInterval: 2.0,
      duration: 40,
      maxEnemiesOnScreen: 4,
    ),
    LevelConfig(
      levelNumber: 4,
      name: 'Night Sprint',
      scrollSpeed: 400,
      enemySpawnInterval: 1.1,
      obstacleSpawnInterval: 2.0,
      coinSpawnInterval: 1.8,
      duration: 45,
      maxEnemiesOnScreen: 5,
    ),
    LevelConfig(
      levelNumber: 5,
      name: 'Thunder Road',
      scrollSpeed: 480,
      enemySpawnInterval: 0.85,
      obstacleSpawnInterval: 1.5,
      coinSpawnInterval: 1.5,
      duration: 50,
      maxEnemiesOnScreen: 6,
    ),
  ];
}
