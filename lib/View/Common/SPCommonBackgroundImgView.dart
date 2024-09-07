import 'package:flame/components.dart';

class SPCommonBackgroundImgView extends SpriteComponent with HasGameRef {
  final String imgPath;

  SPCommonBackgroundImgView({
    required this.imgPath,
    super.size
  });

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(imgPath);
    position = Vector2((gameRef.size.x - size.x) / 2, (gameRef.size.y - size.y) / 2);
  }
}