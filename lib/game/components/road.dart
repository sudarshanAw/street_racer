import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../racing_game.dart';

/// Draws the scrolling road background: grass + asphalt + dashed lane lines.
class Road extends PositionComponent with HasGameRef<RacingGame> {
  double _lineOffset = 0;

  // Cached geometry values – set in onGameResize.
  double _roadLeft = 0;
  double _roadWidth = 0;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
    _roadWidth = size.x * GameConstants.roadWidthRatio;
    _roadLeft = (size.x - _roadWidth) / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Scroll the lane dashes downward.
    final speed = gameRef.currentScrollSpeed;
    _lineOffset += speed * dt;
    if (_lineOffset > 40) _lineOffset -= 40; // dash + gap height
  }

  @override
  void render(Canvas canvas) {
    final screenH = size.y;
    final screenW = size.x;

    // ── Grass background ──
    canvas.drawRect(
      Rect.fromLTWH(0, 0, screenW, screenH),
      Paint()..color = AppColors.grass,
    );

    // ── Road surface ──
    canvas.drawRect(
      Rect.fromLTWH(_roadLeft, 0, _roadWidth, screenH),
      Paint()..color = AppColors.road,
    );

    // ── Road edges (solid white) ──
    final edgePaint = Paint()
      ..color = AppColors.roadLine
      ..strokeWidth = 3;
    canvas.drawLine(
      Offset(_roadLeft, 0),
      Offset(_roadLeft, screenH),
      edgePaint,
    );
    canvas.drawLine(
      Offset(_roadLeft + _roadWidth, 0),
      Offset(_roadLeft + _roadWidth, screenH),
      edgePaint,
    );

    // ── Lane dashes ──
    final dashPaint = Paint()
      ..color = AppColors.roadLine.withOpacity(0.5)
      ..strokeWidth = 2;

    final laneWidth = _roadWidth / GameConstants.laneCount;
    for (int lane = 1; lane < GameConstants.laneCount; lane++) {
      final x = _roadLeft + laneWidth * lane;
      double y = -40 + _lineOffset;
      while (y < screenH) {
        canvas.drawLine(Offset(x, y), Offset(x, y + 20), dashPaint);
        y += 40; // 20 px dash + 20 px gap
      }
    }
  }

  // ── Public helpers for other components ──

  double get roadLeft => _roadLeft;
  double get roadWidth => _roadWidth;
  double get roadRight => _roadLeft + _roadWidth;
  double laneCenter(int lane) =>
      _roadLeft + (_roadWidth / GameConstants.laneCount) * (lane + 0.5);
}
