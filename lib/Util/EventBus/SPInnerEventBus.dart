import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import 'SPEvents.dart';


class SPEventBus {
  static final SPEventBus _instance = SPEventBus._internal();

  factory SPEventBus() {
    return _instance;
  }

  SPEventBus._internal() : _eventBus = EventBus();

  final EventBus _eventBus;

  // 包装fire方法
  void fire(SPEvent event) {
    debugPrint('Firing event: ${event.eventCode}, Data: ${event.data}');
    _eventBus.fire(event);
  }

  // 包装on方法
  Stream<T> on<T>() {
    debugPrint('Listening to event type: $T');
    // 返回一个被包装过的Stream
    return _eventBus.on<T>().map((event) {
      // 在事件处理时打印信息
      if (event is SPEvent) {
        debugPrint('Received event: ${event.eventCode}, Data: ${event.data}');
      }
      return event;
    });
  }

}