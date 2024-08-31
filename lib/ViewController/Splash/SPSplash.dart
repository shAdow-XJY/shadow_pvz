import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:shadow_pvz/Util/Asset/SPAssetLottie.dart';

import '../../Util/Asset/SPAsset.dart';


class SPSplash extends FlameGame with TapDetector {
  late LottieComponent _loadingAnimation;
  late SpriteComponent _startButton;
  late SpriteComponent _musicButton;
  bool _isMusicOn = true;

  //
  bool _isLoadingAll = true;
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
    final loadingAsset = await loadLottie(Lottie.asset(SPAssetLottie.loadingOfCommon));
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
      SPAssetImages.startButtonOfSplash,
      SPAssetImages.musicOnButtonOfSplash,
      SPAssetImages.musicOffButtonOfSplash,
      // ... 其他需要预加载的图片资源
    ]).whenComplete((){
      // TODO: refresh
      _isLoadingImages = false;
    });

    FlameAudio.audioCache.loadAll([
      SPAssetAudio.bgmOfHome,
      // ... 其他需要预加载的音频资源
    ]).whenComplete((){
      _isLoadingAudio = false;
    });



// 开始游戏按钮
    _startButton = SpriteComponent()
      ..sprite = await loadSprite(SPAssetImages.startButtonOfSplash)
      ..size = Vector2(200, 80)
      ..anchor = Anchor.center
      ..position = Vector2(size.x / 2, size.y * 0.8); // Use visible instead of isVisible

// 音乐开关按钮
    _musicButton = SpriteComponent()
      ..sprite = await loadSprite(_isMusicOn ? SPAssetImages.musicOnButtonOfSplash : SPAssetImages.musicOffButtonOfSplash)
      ..size = Vector2(50, 50)
      ..anchor = Anchor.center
      ..position = Vector2(size.x * 0.9, size.y * 0.9); // Use visible instead of isVisible

  }

  @override
  void update(double dt) {
    super.update(dt);

    // TODO: 只調用一次
    if (!_isLoadingAudio && !_isLoadingImages && _isLoadingAll)
      {
        _isLoadingAll = false;
        add(_startButton);
        add(_musicButton);
        // 资源加载完成后
        _loadingAnimation.removeFromParent();      }
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (!_isLoadingAll) {
      if (_startButton.containsPoint(info.eventPosition.global)) {
        // 开始游戏
        print('Start Game!');
      } else if (_musicButton.containsPoint(info.eventPosition.global)) {
        _toggleMusic(); // Call async function to toggle music
      }
    }
  }

  Future<void> _toggleMusic() async { // Separate async function
    _isMusicOn = !_isMusicOn;
    if (_isMusicOn) {
      FlameAudio.bgm.resume();
      _musicButton.sprite = await loadSprite(SPAssetImages.musicOnButtonOfSplash);
    } else {
      FlameAudio.bgm.pause();
      _musicButton.sprite = await loadSprite(SPAssetImages.musicOffButtonOfSplash);
    }
  }
}