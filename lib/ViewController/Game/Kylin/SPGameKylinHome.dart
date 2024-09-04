import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:flame/game.dart';
import 'package:shadow_pvz/Util/Log/SPLogger.dart';

import '../../../Util/Asset/SPAsset.dart';
import '../../../Util/EventBus/SPEventBus.dart';
import 'SPGameKylinGaming.dart';

class SPGameKylinHome extends FlameGame with TapDetector, HasKeyboardHandlerComponents, HasCollisionDetection {
  late LottieComponent _loadingAnimation;
  late SpriteComponent _startButton;
  late SpriteComponent _musicButton;
  late SpriteComponent _closeButton;

  bool _isMusicOn = false;
  bool _isMusicPaused = false;

  //
  bool _isLoadDone = false;
  bool _isLoadingTime = true;
  bool _isLoadingImages = true;
  bool _isLoadingAudio = true;

  SPGameKylinHome(bool isDebug) {
    debugMode = isDebug;
  }

  @override
  Future<void> onLoad() async {
    // 背景图片
    add(SpriteComponent(
      sprite: await loadSprite(SPAssetImages.backgroundOfKylinOfGame),
      size: size,
      position: size / 2,
      anchor: Anchor.center,
    ));

    // 加载动画
    final loadingAsset =
    await loadLottie(Lottie.asset(SPAssetLottie.gameLoadingOfCommon));
    _loadingAnimation = LottieComponent(
      loadingAsset,
      size: Vector2.all(200),
      anchor: Anchor.center,
      position: size / 2,
    );
    add(_loadingAnimation);

    // 背景音乐
    FlameAudio.bgm.initialize();

    // 预加载资源
    images.loadAll([
    ]).whenComplete(() {
      _isLoadingImages = false;
    });

    FlameAudio.audioCache.loadAll([
      SPAssetAudio.bgmOfKylinOfGame
    ]).whenComplete(() {
      _isLoadingAudio = false;
    });

    // 开始游戏按钮
    _startButton = SpriteComponent()
      ..sprite = await loadSprite(SPAssetImages.startButtonOfCommon)
      ..size = Vector2(80, 80)
      ..anchor = Anchor.center
      ..position =
      Vector2(size.x / 2, size.y * 0.8); // Use visible instead of isVisible

    // 音乐开关按钮
    _musicButton = SpriteComponent()
      ..sprite = await loadSprite(_isMusicOn
          ? SPAssetImages.musicOnButtonOfCommon
          : SPAssetImages.musicOffButtonOfCommon)
      ..size = Vector2(50, 50)
      ..anchor = Anchor.center
      ..position = Vector2(
          size.x * 0.9, size.y * 0.9); // Use visible instead of isVisible

    // Close button
    _closeButton = SpriteComponent()
      ..sprite = await loadSprite(SPAssetImages.closeButtonOfCommon) // Replace with your close button image
      ..size = Vector2(50, 50)
      ..anchor = Anchor.topLeft
      ..position = Vector2(10, 10); // Adjust position as needed
    add(_closeButton);

    // 异步延迟 1.5 秒
    Future.delayed(const Duration(seconds: 1, milliseconds: 500)).then((_) {
      _isLoadingTime = false;
    });
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!_isLoadDone && !_isLoadingTime && !_isLoadingAudio && !_isLoadingImages) {
      _isLoadDone = true;
      add(_startButton);
      add(_musicButton);
      // 资源加载完成后
      _loadingAnimation.removeFromParent();
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (children.contains(_closeButton) && _closeButton.containsPoint(info.eventPosition.global)) {
      _closeGame();
    }
    else if (_isLoadDone) {
      if (children.contains(_startButton) && _startButton.containsPoint(info.eventPosition.global)) {
        // 开始游戏
        _startGame();
      } else if (children.contains(_musicButton) && _musicButton.containsPoint(info.eventPosition.global)) {
        _toggleMusic(); // Call async function to toggle music
      }
    }
  }

  void _startGame() {
    FlameAudio.bgm.stop();
    // 移除所有组件
    removeAll(children);
    SPLogger.d('start SPGameKylinGaming');
    final game = SPGameKylinGaming();
    add(game);
  }

  void _closeGame() {
    FlameAudio.bgm.stop();
    eventBus.fire(SPBackToMapHomeEvent()); // Fire game close event
  }

  Future<void> _toggleMusic() async {
    // Separate async function
    _isMusicOn = !_isMusicOn;
    if (_isMusicOn) {
      if (!_isMusicPaused) {
        await FlameAudio.bgm.play(SPAssetAudio.bgmOfKylinOfGame);
      } else {
        FlameAudio.bgm.resume();
      }
      _musicButton.sprite =
      await loadSprite(SPAssetImages.musicOnButtonOfCommon);
    } else {
      FlameAudio.bgm.pause();
      _isMusicPaused = true;
      _musicButton.sprite =
      await loadSprite(SPAssetImages.musicOffButtonOfCommon);
    }
  }
}
