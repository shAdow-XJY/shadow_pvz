import 'dart:ui';

import 'package:flame/components.dart';

class SPProgressBarView extends SpriteComponent with HasGameRef {
  SPProgressBarView({required Vector2 size}) : super(size: size);

  double progress = 0.0;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('progress_bar.png');
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.scale(progress, 1.0);
    super.render(canvas);
    canvas.restore();
  }
}