import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../Util/Asset/SPAssetColor.dart';
import 'SPCommonCollisionType.dart';


typedef OnCollisionStartCallback = void Function(Set<Vector2> intersectionPoints, PositionComponent other);

class SPPositionComponent extends PositionComponent with CollisionCallbacks {
  final ComponentType? componentType;
  final String? componentId;
  final Paint _paint;

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
    double? radius,
    Paint? paint,
  }): _paint = paint ?? Paint()..color = SPAssetColor.getRandomColor();

  @override
  Future<void>? onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), _paint);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (collisionStartCallback != null) {
      collisionStartCallback!(intersectionPoints, other);
    }
  }

}