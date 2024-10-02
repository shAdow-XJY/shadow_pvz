import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:shadow_pvz/Util/Log/SPLogger.dart';

import '../../Util/Asset/SPAsset.dart';
import '../../View/Common/SPCommonBackgroundImgView.dart';
import '../../View/Common/SPCommonTapView.dart';

class SPMapSplash extends Component with HasGameRef, TapCallbacks {
  late SPCommonBackgroundImgView _backgroundImgView;

  late LottieComponent _loadingAnimation;
  late SPCommonTapView _startButton;

  bool _isLoadDone = false;
  bool _isLoadingTime = true;
  bool _isLoadingImages = true;
  bool _isLoadingAudio = true;

  final void Function()? startGame; // 添加 startGame 回调函数

  SPMapSplash({this.startGame}); // 在构造函数中接收 startGame 参数

  void containsLocalPoints(Vector2 point) => true;

  @override
  Future<void>? onLoad() async {
    // 背景图片
    _backgroundImgView = SPCommonBackgroundImgView(imgPath: SPAssetImages.backgroundOfSplash, size: gameRef.size);
    add(_backgroundImgView);

    // 加载动画
    final loadingAsset = await loadLottie(Lottie.asset(SPAssetLottie.loadingOfCommon));
    _loadingAnimation = LottieComponent(
      loadingAsset,
      size: Vector2.all(200),
      anchor: Anchor.center,
      position: gameRef.size / 2,
    );
    add(_loadingAnimation);

    // 背景音乐
    FlameAudio.bgm.initialize();

    // 预加载资源
    gameRef.images.loadAll([
      SPAssetImages.startButtonOfCommon,
      SPAssetImages.musicOnButtonOfCommon,
      SPAssetImages.musicOffButtonOfCommon,
      // ... 其他需要预加载的图片资源
    ]).then((_) {
      _isLoadingImages = false;
    });

    FlameAudio.audioCache.loadAll([
      SPAssetAudio.bgmOfSplash,
      // ... 其他需要预加载的音频资源
    ]).then((_) {
      _isLoadingAudio = false;
    });

    // 开始游戏按钮
    _startButton = SPCommonTapView(
      size: Vector2(150, 50),
      position: Vector2(gameRef.size.x / 2 - 75, 300),
      btnText: 'start game',
      onTap: _startGame
    );

    // 异步延迟 1.5 秒
    Future.delayed(const Duration(seconds: 1, milliseconds: 500)).then((_) {
      _isLoadingTime = false;
    });
  }

  @override
  void onMount() {
    super.onMount();
    _startButton.position = Vector2(gameRef.size.x / 2, gameRef.size.y * 0.8);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_isLoadDone && !_isLoadingTime && !_isLoadingAudio && !_isLoadingImages) {
      SPLogger.d('splash资源加载完成后，显示按钮');
      _isLoadDone = true;
      add(_startButton);
      _loadingAnimation.removeFromParent();
    }
  }

  void _startGame() {
    removeFromParent();

    if (startGame != null) { // 检查 startGame 是否为空
      startGame!(); // 调用 startGame 回调函数
    }
  }
}