import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:shadow_pvz/Util/Asset/SPAsset.dart';

import 'SPCommonBackgroundImgView.dart';
import 'SPCommonTapView.dart';

class SPCommonGameOverView extends Component with HasGameRef, TapCallbacks {
  late SPCommonBackgroundImgView _backgroundImgView;
  late LottieComponent _animationComponent;
  late SPCommonTapView _restartButton;
  late SPCommonTapView _exitButton;
  final Function? _onRestart;
  final Function? _onExit;

  SPCommonGameOverView({Function? onRestart, Function? onExit})
      : _onRestart = onRestart,
        _onExit = onExit;

  @override
  Future<void> onLoad() async {
    _backgroundImgView = SPCommonBackgroundImgView(imgPath: SPAssetImages.backgroundOfMap, size: Vector2(gameRef.size.x / 2.5, gameRef.size.y - 80));
    add(_backgroundImgView);

    final composition = await loadLottie(Lottie.asset(SPAssetLottie.gameOverOfCommon));

    _animationComponent = LottieComponent(composition,
        anchor: Anchor.topCenter,
        position: Vector2(gameRef.size.x / 2, 100), // Adjust position as needed
        size: Vector2(200, 100),
      repeating: true
    ); // Adjust size as needed

    _restartButton = SPCommonTapView(
      size: Vector2(150, 50),
      position: Vector2(gameRef.size.x / 2 - 75, 300),
        btnText: 'restart game',
      onTap: _onRestart
    );

    _exitButton = SPCommonTapView(
      size: Vector2(150, 50),
      position: Vector2(gameRef.size.x / 2 - 75, 400),
      btnText: 'exit game',
      onTap: _onExit
    );

    add(_animationComponent);
    add(_restartButton);
    add(_exitButton);
  }
}