import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';

import '../../ViewModel/Map/SPVMBuilding.dart';

class SPBuildingView extends SpriteComponent with TapCallbacks {
  final void Function(SPVMBuildingType) onTap;
  final SPVMBuildingType type;
  late final String _imagePath; // Store the determined path

  SPBuildingView({
    required super.position,
    Vector2? size,
    String? imagePath, // imagePath is now optional
    required this.onTap,
    required this.type,
  }) : super(size: size ?? Vector2(50, 50)) {
    _init(imagePath, type);
  }

  void _init(String? imagePath, SPVMBuildingType type) {
    _imagePath = imagePath ?? getImagePathForType(type);
  }

  @override
  Future<void> onLoad() async {
    sprite = Sprite(await Flame.images.load(_imagePath));
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap(type);
    event.handled = true;
  }
}