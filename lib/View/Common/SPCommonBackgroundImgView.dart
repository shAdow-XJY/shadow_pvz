import 'package:flame/components.dart';

class SPCommonBackgroundImgView extends SpriteComponent with HasGameRef {
  final String imgPath;

  SPCommonBackgroundImgView({required this.imgPath}) : super(size: Vector2.all(100.0));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(imgPath);
    position = gameRef.size / 2;
    size = gameRef.size;
  }
}