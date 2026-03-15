import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

/// Heads-up display: score, lives, level progress bar.
class Hud extends PositionComponent with HasGameRef {
  int score = 0;
  int lives = GameConstants.maxLives;
  double progress = 0; // 0..1
  int levelNumber = 1;

  @override
  void render(Canvas canvas) {
    final screenW = gameRef.size.x;

    // ── Semi-transparent top bar ──
    canvas.drawRect(
      Rect.fromLTWH(0, 0, screenW, 56),
      Paint()..color = AppColors.hudBackground,
    );

    // ── Score text ──
    _drawText(canvas, 'Score: $score', 12, 12, 16);

    // ── Lives (hearts) ──
    final heartStr = '❤️ ' * lives;
    _drawText(canvas, heartStr.trim(), screenW - 110, 12, 16);

    // ── Level label ──
    _drawText(canvas, 'Lv $levelNumber', screenW / 2 - 20, 6, 12,
        color: AppColors.textSecondary);

    // ── Progress bar ──
    final barX = screenW * 0.15;
    final barW = screenW * 0.7;
    const barY = 32.0;
    const barH = 10.0;
    // background
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(barX, barY, barW, barH), Radius.circular(5)),
      Paint()..color = const Color(0x44FFFFFF),
    );
    // filled
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(barX, barY, barW * progress.clamp(0, 1), barH),
        Radius.circular(5),
      ),
      Paint()..color = AppColors.success,
    );
  }

  void _drawText(Canvas canvas, String text, double x, double y, double size,
      {Color color = AppColors.textPrimary}) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(x, y));
  }
}
