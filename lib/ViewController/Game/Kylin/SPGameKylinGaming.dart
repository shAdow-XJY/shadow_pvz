import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:shadow_pvz/Util/Asset/SPAsset.dart';
import 'package:shadow_pvz/Util/Log/SPLogger.dart';

import '../../../View/Game/Kylin/SPGameKylinRole.dart';


class SPGameKylinGaming extends Component with HasGameRef<FlameGame>, KeyboardHandler {
  late SPGameKylinRole _kylin;
  late RectangleComponent _floor;

  final double _maxHeight = 200;
  final double _jumpSpeed = 0.6;
  final double _fallSpeed = 0.45;
  double _currentHeight = 0;
  bool _isJumping = false;
  bool _isFalling = false;

  @override
  Future<void>? onLoad() async {
    // Load the background image
    final background = await Sprite.load(SPAssetImages.backgroundOfMap); // Replace with your background image
    add(SpriteComponent(sprite: background, size: gameRef.size));

    // Create the floor
    _floor = RectangleComponent(
      size: Vector2(gameRef.size.x, 50),
      position: Vector2(0, gameRef.size.y - 50),
      paint: Paint()..color = SPAssetColor.kylinFloorColor, // Example color
    );
    add(_floor);
    _floor.add(RectangleHitbox());

    // // Create the kylin
    // _kylin = SPGameKylinRole(Vector2(100, gameRef.size.y - 50));
    // _kylin.roleCollisionStart = (intersectionPoints, other) { // Set the callback
    //   if (other is RectangleComponent) {
    //     _isJumping = false;
    //     _isFalling = false;
    //     _currentHeight = 0;
    //     _kylin.updateState(KylinState.running);
    //   }
    // };
    // // _kylin.priority = 1;
    // add(_kylin);
    // Create the kylin
    _kylin = SPGameKylinRole(Vector2(100, gameRef.size.y - 200));
    _kylin.roleCollisionStart = (intersectionPoints, other) { // Set the callback
      if (other is RectangleComponent) {
        _isJumping = false;
        _isFalling = false;
        _currentHeight = 0;
        _kylin.updateState(KylinState.running); // Access inner role
      }
    };
    add(_kylin);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    SPLogger.d('Kylin Key Event');
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.keyZ && !_isFalling) { // Allow jump if falling
      SPLogger.d('Kylin _isJumping');
      _isJumping = true;
      _isFalling = false; // Reset isFalling when jumping
      _kylin.updateState(KylinState.jumping);
      return true;
    } else if (event is KeyUpEvent && event.logicalKey == LogicalKeyboardKey.keyZ && _isJumping) {
      SPLogger.d('Kylin _isFalling');
      _isJumping = false;
      _isFalling = true; // Set isFalling when no longer jumping
      return true;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_isJumping) {
      _currentHeight += _jumpSpeed; // Adjust jump speed

      if (_currentHeight >= _maxHeight) {
        _isJumping = false;
      }
    } else if (_currentHeight > 0) {
      _kylin.updateState(KylinState.falling);
      _isFalling = true; // Set isFalling when falling
      _currentHeight -= _fallSpeed; // Adjust fall speed

      if (_currentHeight <= 0) {
        _currentHeight = 0;
        _isFalling = false; // Reset isFalling when landed
        _kylin.updateState(KylinState.running);
      }
    }

    _kylin.updatePosition(Vector2(100, gameRef.size.y - 50 - _currentHeight));
  }
}