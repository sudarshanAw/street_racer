import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/level_config.dart';
import '../utils/constants.dart';
import '../utils/storage_helper.dart';
import 'components/road.dart';
import 'components/player_car.dart';
import 'components/enemy_car.dart';
import 'components/obstacle.dart';
import 'components/coin.dart';
import 'components/hud.dart';
import 'managers/spawn_manager.dart';

/// Possible states the game can be in.
enum GameState { playing, paused, gameOver, levelComplete }

/// Main Flame game class – manages the game loop, input, and state.
class RacingGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapCallbacks {
  // ── Current level being played ──
  final LevelConfig levelConfig;

  // ── Callbacks to Flutter UI overlay layer ──
  final VoidCallback onGameOver;
  final VoidCallback onLevelComplete;
  final VoidCallback onPause;

  RacingGame({
    required this.levelConfig,
    required this.onGameOver,
    required this.onLevelComplete,
    required this.onPause,
  });

  // ── Components ──
  late Road road;
  late PlayerCar player;
  late Hud hud;
  late SpawnManager spawner;

  // ── State ──
  GameState state = GameState.playing;
  int score = 0;
  int lives = GameConstants.maxLives;
  double elapsed = 0; // seconds into the level
  double currentScrollSpeed = 0;

  // ── Invincibility after getting hit ──
  double _invincibleTimer = 0;
  bool get _isInvincible => _invincibleTimer > 0;

  @override
  Color backgroundColor() => AppColors.grass;

  @override
  Future<void> onLoad() async {
    currentScrollSpeed = levelConfig.scrollSpeed;

    road = Road();
    add(road);

    player = PlayerCar();
    add(player);

    hud = Hud()
      ..score = score
      ..lives = lives
      ..levelNumber = levelConfig.levelNumber;
    add(hud);

    spawner = SpawnManager(level: levelConfig, road: road);
    add(spawner);
  }

  // ─────────── UPDATE LOOP ───────────

  @override
  void update(double dt) {
    if (state != GameState.playing) return;
    super.update(dt);

    // Update road bounds for player.
    player.setRoadBounds(road.roadLeft, road.roadRight);

    // Track time / progress.
    elapsed += dt;
    final progress = elapsed / levelConfig.duration;
    hud.progress = progress;

    // Distance-based score.
    score += (GameConstants.distanceScorePerSecond * dt).round();
    hud.score = score;

    // Check collisions (handled via Flame collision detection system below).
    _checkCollisions();

    // Invincibility countdown.
    if (_isInvincible) {
      _invincibleTimer -= dt;
    }

    // Level complete?
    if (elapsed >= levelConfig.duration) {
      _handleLevelComplete();
    }
  }

  // ─────────── COLLISION LOGIC ───────────

  void _checkCollisions() {
    if (_isInvincible) return;

    final playerRect = player.toRect();

    // Enemy cars.
    for (final enemy in children.whereType<EnemyCar>().toList()) {
      if (playerRect.overlaps(enemy.toRect())) {
        enemy.removeFromParent();
        _takeDamage();
        return; // one hit per frame
      }
    }

    // Obstacles.
    for (final obs in children.whereType<Obstacle>().toList()) {
      if (playerRect.overlaps(obs.toRect())) {
        obs.removeFromParent();
        _takeDamage();
        return;
      }
    }

    // Coins – collectible, not damaging.
    for (final coin in children.whereType<Coin>().toList()) {
      if (playerRect.overlaps(coin.toRect())) {
        coin.removeFromParent();
        score += GameConstants.coinScoreValue;
        hud.score = score;
      }
    }
  }

  void _takeDamage() {
    lives--;
    hud.lives = lives;
    _invincibleTimer = 1.5; // brief invincibility

    if (lives <= 0) {
      state = GameState.gameOver;
      StorageHelper.setHighScore(score);
      onGameOver();
    }
  }

  void _handleLevelComplete() {
    state = GameState.levelComplete;
    StorageHelper.setHighScore(score);
    // Unlock next level.
    if (levelConfig.levelNumber < LevelConfig.levels.length) {
      StorageHelper.unlockNextLevel(levelConfig.levelNumber);
    }
    onLevelComplete();
  }

  // ─────────── PAUSE / RESUME ───────────

  void pauseGame() {
    if (state == GameState.playing) {
      state = GameState.paused;
      pauseEngine();
      onPause();
    }
  }

  void resumeGame() {
    if (state == GameState.paused) {
      state = GameState.playing;
      resumeEngine();
    }
  }

  // ─────────── TOUCH INPUT ───────────
  //
  // Left half → move left,  Right half → move right.

  @override
  void onTapDown(TapDownEvent event) {
    if (state != GameState.playing) return;
    final tapX = event.canvasPosition.x;
    if (tapX < size.x / 2) {
      player.moveDirection = -1;
    } else {
      player.moveDirection = 1;
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    player.moveDirection = 0;
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    player.moveDirection = 0;
  }

  // ─────────── KEYBOARD INPUT (desktop / web) ───────────

  final Set<LogicalKeyboardKey> _pressedKeys = {};

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    _pressedKeys.clear();
    _pressedKeys.addAll(keysPressed);

    if (_pressedKeys.contains(LogicalKeyboardKey.arrowLeft) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyA)) {
      player.moveDirection = -1;
    } else if (_pressedKeys.contains(LogicalKeyboardKey.arrowRight) ||
        _pressedKeys.contains(LogicalKeyboardKey.keyD)) {
      player.moveDirection = 1;
    } else {
      player.moveDirection = 0;
    }

    // Pause on Escape or P.
    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.escape ||
            event.logicalKey == LogicalKeyboardKey.keyP)) {
      pauseGame();
    }

    return KeyEventResult.handled;
  }
}
