import 'package:flame/components.dart';
import 'package:flame_lottie/flame_lottie.dart';

class SPCommonBackgroundLottieView extends Component with HasGameRef {
  final String lottiePath;
  late LottieComponent _animationComponent;

  SPCommonBackgroundLottieView({required this.lottiePath});

  @override
  Future<void> onLoad() async {
    // Load Lottie compositions
    final runComposition =
    await loadLottie(Lottie.asset(lottiePath));

    // Create animation components
    _animationComponent = LottieComponent(
      runComposition,
      anchor: Anchor.center,
      scale: Vector2(1.5, 1.5),
      repeating: true,
    );

    add(_animationComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _animationComponent.size = gameRef.size; // Set size in update
    _animationComponent.position = gameRef.size / 2; // Set position in update
  }
  
}