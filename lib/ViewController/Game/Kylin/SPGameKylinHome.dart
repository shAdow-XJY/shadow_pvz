import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:flame/game.dart';

import '../../../Util/Asset/SPAsset.dart';
import '../../../Util/EventBus/SPEventBus.dart';

class SPGameKylinHome extends FlameGame with TapDetector {
  late LottieComponent _loadingAnimation;
  late SpriteComponent _startButton;
  late SpriteComponent _musicButton;
  late SpriteComponent _closeButton;

  bool _isMusicOn = true;

  //
  bool _isLoadDone = false;
  bool _isLoadingTime = true;
  bool _isLoadingImages = true;
  bool _isLoadingAudio = true;

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
    await FlameAudio.bgm.play(SPAssetAudio.bgmOfKylinOfGame);

    // 预加载资源
    images.loadAll([
    ]).whenComplete(() {
      _isLoadingImages = false;
    });

    FlameAudio.audioCache.loadAll([
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
    if (_closeButton.containsPoint(info.eventPosition.global)) {
      _closeGame();
    }
    else if (_isLoadDone) {
      if (_startButton.containsPoint(info.eventPosition.global)) {
        // 开始游戏
        _startGame();
      } else if (_musicButton.containsPoint(info.eventPosition.global)) {
        _toggleMusic(); // Call async function to toggle music
      }
    }
  }

  void _startGame() {
    // FlameAudio.bgm.stop();
    // 移除所有组件
    // removeAll(children);
    // add(SPMap());
  }

  void _closeGame() {
    FlameAudio.bgm.stop();
    eventBus.fire(SPBackToMapHomeEvent()); // Fire game close event
  }

  Future<void> _toggleMusic() async {
    // Separate async function
    _isMusicOn = !_isMusicOn;
    if (_isMusicOn) {
      FlameAudio.bgm.resume();
      _musicButton.sprite =
      await loadSprite(SPAssetImages.musicOnButtonOfCommon);
    } else {
      FlameAudio.bgm.pause();
      _musicButton.sprite =
      await loadSprite(SPAssetImages.musicOffButtonOfCommon);
    }
  }
}
