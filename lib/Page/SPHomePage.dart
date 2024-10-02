import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../Router/Router.dart';
import '../Util/EventBus/SPEventBus.dart';
import '../Util/GlobalVar/GlobalVar.dart';
import '../ViewController/Map/SPMap.dart';
import '../ViewModel/Map/import/SPMapViewModel.dart';

class SPHomePage extends StatefulWidget {
  const SPHomePage({super.key});

  @override
  State<SPHomePage> createState() => _SPHomePageState();
}

class _SPHomePageState extends State<SPHomePage> {
  final _subscriptions = <StreamSubscription>[];

  @override
  void initState() {
    super.initState();
    _subscriptions.add(
        eventBus.on<SPEvent>().listen((event) {
          if (event.eventCode == SPEventCode.mapEnterBuilding && event is SPMapEnterBuildingEvent) {
            // Access buildingType: event.buildingType
            _onBuildingTap(event);
          }
        })
    );
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
    super.dispose();
  }

  void _onBuildingTap(SPMapEnterBuildingEvent event) {
    switch (event.buildingType) {
      case SPVMBuildingType.house:
        Navigator.pushNamed(context, GlobalRoutes.kylinHomePage.name);
        break;
      case SPVMBuildingType.school:

        break;
    // ... handle other types ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Focus(child: GameWidget(game: SPMap(GlobalVar.isDebugMode))),
    );
  }
}