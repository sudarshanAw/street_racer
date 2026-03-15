import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../../utils/constants.dart';

/// A stationary obstacle (e.g. barrel / cone) that scrolls down with the road.
class Obstacle extends PositionComponent with CollisionCallbacks, HasGameRef {
  final double speed;

  Obstacle({required this.speed});

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;
    if (position.y > gameRef.size.y + size.y) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final w = size.x;
    final h = size.y;

    // ── Barrel body (brown rectangle) ──
    final barrelPaint = Paint()..color = AppColors.obstacle;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, w, h),
        Radius.circular(w * 0.2),
      ),
      barrelPaint,
    );

    // ── Warning stripes ──
    final stripePaint = Paint()
      ..color = AppColors.coin
      ..strokeWidth = 2;
    canvas.drawLine(Offset(0, h * 0.3), Offset(w, h * 0.3), stripePaint);
    canvas.drawLine(Offset(0, h * 0.7), Offset(w, h * 0.7), stripePaint);
  }
}
