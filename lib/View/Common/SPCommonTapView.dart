import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class SPCommonTapView extends PositionComponent with HasGameRef, TapCallbacks {
  final String btnText;
  final Function? _onTap;
  final Vector2? _size;
  final Vector2? _position;

  SPCommonTapView({
    required this.btnText,
    Function? onTap,
    Vector2? size,
    Vector2? position,
  })  : _onTap = onTap,
        _size = size,
        _position = position;

  @override
  Future<void> onLoad() async {
    final parentSize = (parent is PositionComponent) ? (parent as PositionComponent).size : gameRef.size;    size = _size ?? Vector2(parentSize.x, 80); // Access size directly
    position = _position ?? parentSize / 2 - size / 2;

    final textPaint = TextPaint(
      style: const TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
    );

    final textComponent = TextComponent(
      text: btnText,
      textRenderer: textPaint,
      anchor: Anchor.center,
    );

    final button = RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.blue,
    );

    textComponent.position = button.size / 2;
    add(button);
    add(textComponent);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (_onTap != null) {
      _onTap();
    }
  }
}