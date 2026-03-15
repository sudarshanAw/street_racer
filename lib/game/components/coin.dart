import 'dart:math' as math;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

/// A spinning coin the player can collect for bonus score.
class Coin extends PositionComponent with CollisionCallbacks, HasGameRef {
  final double speed;
  double _angle = 0;

  Coin({required this.speed});

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;
    _angle += dt * 4; // spinning animation
    if (position.y > gameRef.size.y + size.y) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final r = size.x / 2;

    // Simulate a "spin" by squashing the X dimension.
    final scaleX = (math.cos(_angle)).abs().clamp(0.3, 1.0);

    canvas.save();
    canvas.translate(r, r);
    canvas.scale(scaleX, 1.0);

    // ── Outer ring ──
    final outerPaint = Paint()..color = AppColors.coin;
    canvas.drawCircle(Offset.zero, r, outerPaint);

    // ── Inner circle ──
    final innerPaint = Paint()..color = const Color(0xFFFFF176);
    canvas.drawCircle(Offset.zero, r * 0.65, innerPaint);

    // ── "$" symbol ──
    final textPainter = TextPainter(
      text: TextSpan(
        text: '\$',
        style: TextStyle(
          color: AppColors.coin,
          fontSize: r * 0.9,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );

    canvas.restore();
  }
}
