import 'dart:math';

import 'package:flutter/material.dart';

class SPAssetColor {
  static Color getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  static Color get kylinFloorColor => getRandomColor();

}
