import 'package:flame/components.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:shadow_pvz/Util/Asset/SPAsset.dart';

enum KylinState { running, jumping, falling }

class SPGameKylinRole extends Component with HasGameRef {
  late LottieComponent _runAnimationComponent;
  late LottieComponent _jumpAnimationComponent;
  late LottieComponent _fallAnimationComponent;

  KylinState _currentState = KylinState.running;
  Vector2 _position;

  // In SPGameKylinRole
  bool _isInitialized = false;

  SPGameKylinRole(this._position); // Constructor with position parameter

  @override
  Future<void>? onLoad() async {
    // Load Lottie compositions
    final runComposition = await loadLottie(Lottie.asset(SPAssetLottie.runningOfKylin));
    final jumpComposition = await loadLottie(Lottie.asset(SPAssetLottie.jumpingOfKylin));
    final fallComposition = await loadLottie(Lottie.asset(SPAssetLottie.jumpingOfKylin));

    // Create animation components
    _runAnimationComponent = LottieComponent(
      runComposition,
      size: Vector2(100, 100),
      position: _position,
      repeating: true
    );
    _jumpAnimationComponent = LottieComponent(
      jumpComposition,
      size: Vector2(100, 100),
      position: _position,
        repeating: true
    );
    _fallAnimationComponent = LottieComponent(
      fallComposition,
      size: Vector2(100, 100),
      position: _position,
        repeating: true
    );

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
    }
  }

  void _changeAnimation() {
    // Remove the current animation component
    removeAll(children);
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
}