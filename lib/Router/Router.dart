import 'package:flutter/material.dart';

import '../Page/Game/SPGameKylinHomePage.dart';
import '../Page/SPHomePage.dart';
import '../Page/SPSplashPage.dart';

/// 需要引入跳转页面地址
enum GlobalRoutes {
  splashPage,
  homePage,
  kylinHomePage
}

/// 配置路由
final _routes = {
  /// 前面是自己的命名 后面是加载的方法
  /// 不用传参的写法
  GlobalRoutes.splashPage.name: (context) => const SPSplashPage(),
  GlobalRoutes.homePage.name: (context) => const SPHomePage(),
  GlobalRoutes.kylinHomePage.name: (context) => const SPGameKylinHomePage(),
};

extension _GlobalRoutesExtension on GlobalRoutes {
  String get name {
    return toString().split('.').last;
  }
}
/// 固定写法，统一处理，无需更改
var globalGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  if (name != null) {
    final Function? pageContentBuilder = _routes[name];
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        final Route route = MaterialPageRoute(
          builder: (context) => pageContentBuilder(context, arguments: settings.arguments),
        );
        return route;
      } else {
        final Route route = MaterialPageRoute(
          builder: (context) => pageContentBuilder(context),
        );
        return route;
      }
    }
  }
};
