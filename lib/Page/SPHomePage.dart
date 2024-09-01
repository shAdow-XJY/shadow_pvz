import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../ViewController/Splash/SPMapSplash.dart';

class SPHomePage extends StatelessWidget {
  const SPHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: SPMapSplash()),
    );
  }
}