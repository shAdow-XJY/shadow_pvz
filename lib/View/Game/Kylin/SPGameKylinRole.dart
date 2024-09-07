import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:shadow_pvz/Util/Asset/SPAsset.dart';

import '../../Common/SPCommonCollisionType.dart';

enum KylinState { running, jumping, falling }


typedef RoleCollisionStartCallback = void Function(Set<Vector2> intersectionPoints, PositionComponent other, CollisionDirection direction);

class SPGameKylinRole extends PositionComponent
    with HasGameRef, CollisionCallbacks {
  late LottieComponent _runAnimationComponent;
  late LottieComponent _jumpAnimationComponent;
  late LottieComponent _fallAnimationComponent;
  late RectangleHitbox _rectangleHitbox;

  RoleCollisionStartCallback? roleCollisionStart;

  KylinState _currentState = KylinState.running;
  Vector2 _position;

  // In SPGameKylinRole
  bool _isInitialized = false;

  SPGameKylinRole(this._position); // Constructor with position parameter

  @override
  Future<void>? onLoad() async {
    // Load Lottie compositions
    final runComposition =
        await loadLottie(Lottie.asset(SPAssetLottie.jumpingOfKylin));
    final jumpComposition =
        await loadLottie(Lottie.asset(SPAssetLottie.jumpingOfKylin));
    final fallComposition =
        await loadLottie(Lottie.asset(SPAssetLottie.jumpingOfKylin));

    // Create animation components
    _runAnimationComponent = LottieComponent(
      runComposition,
      size: Vector2(80, 40),
      position: _position,
      anchor: Anchor.bottomLeft,
      repeating: true,
    );
    _jumpAnimationComponent = LottieComponent(jumpComposition,
        position: _position,
        size: Vector2(80, 40),
        anchor: Anchor.bottomLeft,
        repeating: true);
    _fallAnimationComponent = LottieComponent(fallComposition,
        position: _position,
        size: Vector2(80, 40),
        anchor: Anchor.bottomLeft,
        repeating: true);

    _rectangleHitbox = RectangleHitbox(
      position: _position,
      size: Vector2(80, 40),
      anchor: Anchor.bottomLeft,
    );
    add(_rectangleHitbox);

    // Initially add the run animation component
    add(_runAnimationComponent);
    _isInitialized = true;
  }

  void updateState(KylinState newState) {
    if (_currentState != newState) {
      _currentState = newState;
      _changeAnimation();
    }
  }

  void updatePosition(Vector2 newPosition) {
    _position = newPosition;
    if (_isInitialized) {
      _runAnimationComponent.position = _position;
      _jumpAnimationComponent.position = _position;
      _fallAnimationComponent.position = _position;
      _rectangleHitbox.position = _position;
    }
  }

  void _changeAnimation() {
    // Remove the current animation component
    removeAll(children);
    add(_rectangleHitbox);
    // Add the new animation component based on the current state
    switch (_currentState) {
      case KylinState.running:
        add(_runAnimationComponent);
        break;
      case KylinState.jumping:
        add(_jumpAnimationComponent);
        break;
      case KylinState.falling:
        add(_fallAnimationComponent);
        break;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (roleCollisionStart != null) {
      // Calculate collision direction
      CollisionDirection direction = _getCollisionDirection(intersectionPoints, other);
      roleCollisionStart!(intersectionPoints, other, direction);
    }
  }

  CollisionDirection _getCollisionDirection(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // Get the center point of this component
    final center = position + size / 2;

    // Get the center point of the other component
    final otherCenter = other.position + other.size / 2;

    // Calculate the difference between the centers
    final diff = otherCenter - center;

    // Determine the collision direction based on the difference
    if (diff.y.abs() > diff.x.abs()) {
      return diff.y > 0 ? CollisionDirection.down : CollisionDirection.up;
    } else {
      return diff.x > 0 ? CollisionDirection.right : CollisionDirection.left;
    }
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    // SPLogger.d('Kylin onCollision');

  }
}
