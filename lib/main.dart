import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shadow_pvz/ViewController/Splash/SPSplash.dart';
import 'Localization/import/SPLocalization.dart';

void main() {
  Locale locale = PlatformDispatcher.instance.locale;
  SPLocalization().locale = locale.toString();
  runApp(GameWidget(game: SPSplash()));
}


