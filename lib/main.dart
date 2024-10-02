import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shadow_pvz/Util/GlobalVar/GlobalVar.dart';

import 'Localization/import/SPLocalization.dart';
import 'Router/Router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Locale locale = PlatformDispatcher.instance.locale;
  SPLocalization().locale = locale.toString();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // // FIXME: test
      // initialRoute: GlobalRoutes.homePage.name,

      initialRoute: GlobalRoutes.splashPage.name,
      onGenerateRoute: globalGenerateRoute,
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: GlobalVar.isDebugMode,
    );
  }
}
