
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';

import '../Router/Router.dart';

class SPSplashPage extends StatefulWidget {
  const SPSplashPage({super.key});

  @override
  SPSplashPageState createState() => SPSplashPageState();
}

class SPSplashPageState extends State<SPSplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        showBefore: (BuildContext context) {
          return const Text('Before logo');
        },
        showAfter: (BuildContext context) {
          return const Text('After logo');
        },
        theme: FlameSplashTheme.dark,
        onFinish: (context) => Navigator.pushReplacementNamed(context, GlobalRoutes.homePage.name),
      ),
    );
  }
}

