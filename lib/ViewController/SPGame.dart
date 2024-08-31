import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:shadow_pvz/Util/Asset/SPAsset.dart';

class SPSpriteComponent extends SpriteComponent with HasGameRef {
  SPSpriteComponent() : super(size: Vector2.all(100.0));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(SPAssetImages.background);
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += 100 * dt;
    if (position.x > gameRef.size.x) {
      position.x = 0;
    }
  }
}

class SPGame extends FlameGame with TapDetector {
  @override
  Future<void> onLoad() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.play(SPAssetAudio.bgm);
    add(SPSpriteComponent());
  }

  @override
  void onTap() {
    final spriteComponent = firstChild<SPSpriteComponent>()!;
    spriteComponent.flipHorizontallyAroundCenter();
  }
}