import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum ComponentType {
  floor
}

typedef OnCollisionStartCallback = void Function(Set<Vector2> intersectionPoints, PositionComponent other);

class SPPositionComponent extends PositionComponent with CollisionCallbacks {
  final ComponentType? componentType;
  final String? componentId;

  OnCollisionStartCallback? collisionStartCallback;

  SPPositionComponent({
    this.componentType,
    this.componentId,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void>? onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (collisionStartCallback != null) {
      collisionStartCallback!(intersectionPoints, other);
    }
  }

}