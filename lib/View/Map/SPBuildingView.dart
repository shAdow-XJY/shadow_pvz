import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';

import '../../ViewModel/Map/SPVMBuilding.dart';

class SPBuildingView extends SpriteComponent with TapCallbacks {
  final void Function(SPVMBuildingType) onTap;
  final SPVMBuildingType type;

  SPBuildingView({
    required super.position,
    Vector2? size,
    String? imagePath, // imagePath is now optional
    required this.onTap,
    required this.type,
  }) : super(size: size ?? Vector2(50, 50)) {
    _init(imagePath);
  }

  Future<void> _init(String? imagePath) async {
    if (imagePath != null) {
      sprite = Sprite(await Flame.images.load(imagePath));
    } else {
      final path = getImagePathForType(type);
      sprite = Sprite(await Flame.images.load(path));
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap(type);
    event.handled = true;
  }
}