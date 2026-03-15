import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../../utils/constants.dart';

/// The player-controlled car.  Rendered as a coloured rounded rectangle
/// with simple detail lines to look like a car.
class PlayerCar extends PositionComponent with CollisionCallbacks, HasGameRef {
  /// Horizontal movement: -1 = left, 0 = still, 1 = right.
  int moveDirection = 0;

  /// Movement speed (pixels / second).
  static const double _horizontalSpeed = 300;

  // Road boundaries – updated every frame from [Road].
  double _roadLeft = 0;
  double _roadRight = 0;

  void setRoadBounds(double left, double right) {
    _roadLeft = left;
    _roadRight = right;
  }

  @override
  Future<void> onLoad() async {
    // Hitbox for collision detection.
    add(RectangleHitbox());
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    final w = gameSize.x * GameConstants.playerWidthRatio;
    final h = gameSize.y * GameConstants.playerHeightRatio;
    size = Vector2(w, h);
    position = Vector2(
      gameSize.x / 2 - w / 2,
      gameSize.y * GameConstants.playerStartYRatio,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (moveDirection != 0) {
      position.x += moveDirection * _horizontalSpeed * dt;
      // Clamp inside road.
      final halfW = size.x / 2;
      if (position.x < _roadLeft) position.x = _roadLeft;
      if (position.x + size.x > _roadRight) {
        position.x = _roadRight - size.x;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    final w = size.x;
    final h = size.y;
    final r = w * 0.15;

    // ── Car body ──
    final bodyPaint = Paint()..color = AppColors.playerCar;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), Radius.circular(r)),
      bodyPaint,
    );

    // ── Windshield ──
    final glassPaint = Paint()..color = const Color(0xFF90CAF9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.15, h * 0.15, w * 0.7, h * 0.2),
        Radius.circular(r * 0.5),
      ),
      glassPaint,
    );

    // ── Rear window ──
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.2, h * 0.7, w * 0.6, h * 0.15),
        Radius.circular(r * 0.4),
      ),
      glassPaint,
    );

    // ── Wheels (4 small dark rects) ──
    final wheelPaint = Paint()..color = const Color(0xFF212121);
    final ww = w * 0.12;
    final wh = h * 0.14;
    // front-left
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(-ww * 0.3, h * 0.12, ww, wh),
        Radius.circular(2),
      ),
      wheelPaint,
    );
    // front-right
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w - ww * 0.7, h * 0.12, ww, wh),
        Radius.circular(2),
      ),
      wheelPaint,
    );
    // rear-left
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(-ww * 0.3, h * 0.74, ww, wh),
        Radius.circular(2),
      ),
      wheelPaint,
    );
    // rear-right
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w - ww * 0.7, h * 0.74, ww, wh),
        Radius.circular(2),
      ),
      wheelPaint,
    );
  }
}
