import 'dart:math';
import 'package:flame/components.dart';
import '../../models/level_config.dart';
import '../../utils/constants.dart';
import '../components/enemy_car.dart';
import '../components/obstacle.dart';
import '../components/coin.dart';
import '../components/road.dart';
import '../racing_game.dart';

/// Periodically spawns enemies, obstacles, and coins at the top of the road.
class SpawnManager extends Component with HasGameRef<RacingGame> {
  final LevelConfig level;
  final Road road;
  final Random _rng = Random();

  double _enemyTimer = 0;
  double _obstacleTimer = 0;
  double _coinTimer = 0;

  SpawnManager({required this.level, required this.road});

  @override
  void update(double dt) {
    super.update(dt);

    final scrollSpeed = gameRef.currentScrollSpeed;

    // ── Enemy cars ──
    _enemyTimer += dt;
    if (_enemyTimer >= level.enemySpawnInterval) {
      _enemyTimer = 0;
      _spawnEnemy(scrollSpeed);
    }

    // ── Obstacles ──
    _obstacleTimer += dt;
    if (_obstacleTimer >= level.obstacleSpawnInterval) {
      _obstacleTimer = 0;
      _spawnObstacle(scrollSpeed);
    }

    // ── Coins ──
    _coinTimer += dt;
    if (_coinTimer >= level.coinSpawnInterval) {
      _coinTimer = 0;
      _spawnCoin(scrollSpeed);
    }
  }

  void _spawnEnemy(double scrollSpeed) {
    // Count existing enemies.
    final existing = gameRef.children.whereType<EnemyCar>().length;
    if (existing >= level.maxEnemiesOnScreen) return;

    final lane = _rng.nextInt(GameConstants.laneCount);
    final w = gameRef.size.x * GameConstants.enemyWidthRatio;
    final h = gameRef.size.y * GameConstants.enemyHeightRatio;

    final enemy = EnemyCar(speed: scrollSpeed * (0.6 + _rng.nextDouble() * 0.5))
      ..size = Vector2(w, h)
      ..position = Vector2(road.laneCenter(lane) - w / 2, -h);

    gameRef.add(enemy);
  }

  void _spawnObstacle(double scrollSpeed) {
    final lane = _rng.nextInt(GameConstants.laneCount);
    final w = gameRef.size.x * GameConstants.obstacleWidthRatio;
    final h = gameRef.size.y * GameConstants.obstacleHeightRatio;

    final obs = Obstacle(speed: scrollSpeed)
      ..size = Vector2(w, h)
      ..position = Vector2(road.laneCenter(lane) - w / 2, -h);

    gameRef.add(obs);
  }

  void _spawnCoin(double scrollSpeed) {
    final lane = _rng.nextInt(GameConstants.laneCount);
    final s = GameConstants.coinSize;

    final coin = Coin(speed: scrollSpeed)
      ..size = Vector2(s, s)
      ..position = Vector2(road.laneCenter(lane) - s / 2, -s);

    gameRef.add(coin);
  }
}
