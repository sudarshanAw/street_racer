import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../game/racing_game.dart';
import '../models/level_config.dart';
import '../utils/constants.dart';
import '../utils/storage_helper.dart';

/// Wraps the Flame [RacingGame] and provides Flutter overlay screens
/// for pause, game-over, and level-complete dialogs.
class GameScreen extends StatefulWidget {
  final LevelConfig levelConfig;

  const GameScreen({super.key, required this.levelConfig});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late RacingGame _game;

  // Overlay visibility flags.
  bool _showPause = false;
  bool _showGameOver = false;
  bool _showLevelComplete = false;

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  void _initGame() {
    _showPause = false;
    _showGameOver = false;
    _showLevelComplete = false;

    _game = RacingGame(
      levelConfig: widget.levelConfig,
      onGameOver: () => setState(() => _showGameOver = true),
      onLevelComplete: () => setState(() => _showLevelComplete = true),
      onPause: () => setState(() => _showPause = true),
    );
  }

  void _restart() {
    setState(() {
      _initGame();
    });
  }

  void _resume() {
    setState(() => _showPause = false);
    _game.resumeGame();
  }

  void _nextLevel() {
    final nextIndex = widget.levelConfig.levelNumber; // 0-based next
    if (nextIndex < LevelConfig.levels.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              GameScreen(levelConfig: LevelConfig.levels[nextIndex]),
        ),
      );
    } else {
      Navigator.pop(context); // back to menu if no more levels
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Flame game widget ──
          GameWidget(game: _game),

          // ── Pause button (top-right) ──
          Positioned(
            top: 8,
            right: 8,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.pause_circle_filled,
                    color: Colors.white70, size: 36),
                onPressed: () => _game.pauseGame(),
              ),
            ),
          ),

          // ── Overlays ──
          if (_showPause) _buildPauseOverlay(),
          if (_showGameOver) _buildGameOverOverlay(),
          if (_showLevelComplete) _buildLevelCompleteOverlay(),
        ],
      ),
    );
  }

  // ─────────── Pause Overlay ───────────

  Widget _buildPauseOverlay() {
    return _overlayBase(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.pause_circle_outline,
              size: 64, color: AppColors.accent),
          const SizedBox(height: 16),
          const Text('PAUSED',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 24),
          _overlayButton('RESUME', AppColors.success, _resume),
          const SizedBox(height: 12),
          _overlayButton('RESTART', AppColors.accent, _restart),
          const SizedBox(height: 12),
          _overlayButton(
              'QUIT', AppColors.danger, () => Navigator.pop(context)),
        ],
      ),
    );
  }

  // ─────────── Game Over Overlay ───────────

  Widget _buildGameOverOverlay() {
    return _overlayBase(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.car_crash_rounded,
              size: 64, color: AppColors.danger),
          const SizedBox(height: 16),
          const Text('GAME OVER',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.danger)),
          const SizedBox(height: 8),
          Text('Score: ${_game.score}',
              style: const TextStyle(
                  fontSize: 20, color: AppColors.textSecondary)),
          Text('High Score: ${StorageHelper.getHighScore()}',
              style: const TextStyle(
                  fontSize: 16, color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          _overlayButton('TRY AGAIN', AppColors.accent, _restart),
          const SizedBox(height: 12),
          _overlayButton(
              'MAIN MENU', AppColors.textSecondary, () => Navigator.pop(context)),
        ],
      ),
    );
  }

  // ─────────── Level Complete Overlay ───────────

  Widget _buildLevelCompleteOverlay() {
    final hasNext =
        widget.levelConfig.levelNumber < LevelConfig.levels.length;

    return _overlayBase(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.emoji_events_rounded,
              size: 64, color: AppColors.coin),
          const SizedBox(height: 16),
          const Text('LEVEL COMPLETE!',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success)),
          const SizedBox(height: 8),
          Text('Score: ${_game.score}',
              style: const TextStyle(
                  fontSize: 20, color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          if (hasNext)
            _overlayButton('NEXT LEVEL', AppColors.success, _nextLevel),
          if (hasNext) const SizedBox(height: 12),
          _overlayButton('REPLAY', AppColors.accent, _restart),
          const SizedBox(height: 12),
          _overlayButton(
              'MAIN MENU', AppColors.textSecondary, () => Navigator.pop(context)),
        ],
      ),
    );
  }

  // ─────────── Shared overlay helpers ───────────

  Widget _overlayBase({required Widget child}) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.menuCard,
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _overlayButton(String label, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(label,
            style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
