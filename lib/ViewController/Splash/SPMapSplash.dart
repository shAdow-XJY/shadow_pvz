import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:shadow_pvz/Util/Log/SPLogger.dart';

import '../../Util/Asset/SPAsset.dart';
import '../Map/SPMap.dart';

class SPMapSplash extends FlameGame with TapDetector {
  late LottieComponent _loadingAnimation;
  late SpriteComponent _startButton;
  late SpriteComponent _musicButton;
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
      sprite: await loadSprite(SPAssetImages.backgroundOfSplash),
      size: size,
      position: size / 2,
      anchor: Anchor.center,
    ));

    // 加载动画
    final loadingAsset =
        await loadLottie(Lottie.asset(SPAssetLottie.loadingOfCommon));
    _loadingAnimation = LottieComponent(
      loadingAsset,
      size: Vector2.all(200),
      anchor: Anchor.center,
      position: size / 2,
    );
    add(_loadingAnimation);

    // 背景音乐
    FlameAudio.bgm.initialize();
    await FlameAudio.bgm.play(SPAssetAudio.bgmOfSplash);

    // 预加载资源
    images.loadAll([
      SPAssetImages.startButtonOfCommon,
      SPAssetImages.musicOnButtonOfCommon,
      SPAssetImages.musicOffButtonOfCommon,
      // ... 其他需要预加载的图片资源
    ]).whenComplete(() {
      _isLoadingImages = false;
    });

    FlameAudio.audioCache.loadAll([
      SPAssetAudio.bgmOfSplash,
      // ... 其他需要预加载的音频资源
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

    // 异步延迟 1.5 秒
    Future.delayed(const Duration(seconds: 1, milliseconds: 500)).then((_) {
      _isLoadingTime = false;
    });
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!_isLoadDone && !_isLoadingTime && !_isLoadingAudio && !_isLoadingImages) {
      SPLogger.d('// 资源加载完成后，顯示按鈕');
      _isLoadDone = true;
      add(_startButton);
      add(_musicButton);
      // 资源加载完成后
      _loadingAnimation.removeFromParent();
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (_isLoadDone) {
      if (_startButton.containsPoint(info.eventPosition.global)) {
        // 开始游戏
        _startGame();
      } else if (_musicButton.containsPoint(info.eventPosition.global)) {
        _toggleMusic(); // Call async function to toggle music
      }
    }
  }

  void _startGame() {
    FlameAudio.bgm.stop();
    // 移除所有组件
    removeAll(children);
    // 添加地图组件
    add(SPMap());
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
