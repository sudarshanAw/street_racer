import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../../utils/constants.dart';

/// An enemy car that scrolls downward toward the player.
class EnemyCar extends PositionComponent with CollisionCallbacks, HasGameRef {
  final double speed; // pixels / second (downward)

  EnemyCar({required this.speed});

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;
    // Remove when off screen.
    if (position.y > gameRef.size.y + size.y) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final w = size.x;
    final h = size.y;
    final r = w * 0.15;

    // ── Body ──
    final bodyPaint = Paint()..color = AppColors.enemyCar;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), Radius.circular(r)),
      bodyPaint,
    );

    // ── Windshield ──
    final glassPaint = Paint()..color = const Color(0xFFEF9A9A);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.15, h * 0.65, w * 0.7, h * 0.2),
        Radius.circular(r * 0.5),
      ),
      glassPaint,
    );

    // ── Front window (enemy faces player, so "front" is bottom) ──
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.2, h * 0.1, w * 0.6, h * 0.15),
        Radius.circular(r * 0.4),
      ),
      glassPaint,
    );

    // ── Wheels ──
    final wheelPaint = Paint()..color = const Color(0xFF212121);
    final ww = w * 0.12;
    final wh = h * 0.14;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(-ww * 0.3, h * 0.12, ww, wh),
        Radius.circular(2),
      ),
      wheelPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w - ww * 0.7, h * 0.12, ww, wh),
        Radius.circular(2),
      ),
      wheelPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(-ww * 0.3, h * 0.74, ww, wh),
        Radius.circular(2),
      ),
      wheelPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w - ww * 0.7, h * 0.74, ww, wh),
        Radius.circular(2),
      ),
      wheelPaint,
    );
  }
}
