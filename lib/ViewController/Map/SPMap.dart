import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shadow_pvz/Util/Asset/SPAsset.dart';
import 'package:shadow_pvz/ViewModel/Map/import/SPMapViewModel.dart';

import '../../View/Map/import/SPMapView.dart';
import '../Game/GameEntry.dart';

class SPMap extends Component with HasGameRef {
  late Sprite _mapSprite;
  final SPVMMap _mapViewModel = SPVMMap(); // Create SPVMMap instance

  @override
  Future<void>? onLoad() async {
    _mapSprite = Sprite(await Flame.images.load(SPAssetImages.backgroundOfMap));

    // Create buildings from _mapViewModel
    for (final building in _mapViewModel.buildings) {
      add(SPBuildingView(
        position: Vector2(building.positionX * gameRef.size.x, building.positionY * gameRef.size.y),
        onTap: _handleBuildingTap,
        type: building.type,
      ));
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    // Update building positions on resize
    int i = 0;
    for (final building in children.whereType<SPBuildingView>()) {
      building.position = Vector2(
        _mapViewModel.buildings[i].positionX * size.x,
        _mapViewModel.buildings[i].positionY * size.y,
      );
      i++;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _mapSprite.render(canvas, size: gameRef.size); // 使用游戏尺寸绘制背景
  }

  // Callback function to handle building taps
  void _handleBuildingTap(SPVMBuildingType type) {
    switch (type) {
      case SPVMBuildingType.house:
        // replaceRootWidget
        // // Transition to Kylin game module
        // Navigator.push(
        //   _buildContext, // You'll need to get the context here
        //   MaterialPageRoute(builder: (context) => GameWidget(game: SPGameKylinHome())),
        // );

        break;
      case SPVMBuildingType.school:
      // Handle school tap
        print('School tapped!');
        break;
    }
  }
}