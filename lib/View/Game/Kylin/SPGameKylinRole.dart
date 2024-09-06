import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:shadow_pvz/Util/Asset/SPAsset.dart';
import 'package:shadow_pvz/Util/Log/SPLogger.dart';

enum KylinState { running, jumping, falling }

typedef RoleCollisionStartCallback = void Function(Set<Vector2> intersectionPoints, PositionComponent other);

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
    SPLogger.d('Kylin Role onCollisionStart');
    if (roleCollisionStart != null) {
      roleCollisionStart!(intersectionPoints, other);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    // SPLogger.d('Kylin onCollision');

  }
}
