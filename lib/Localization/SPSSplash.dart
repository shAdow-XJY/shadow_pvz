import 'import/SPLocalization.dart';
class SPSSplash {
  SPSSplash._();
  static final SPSSplash _instance = SPSSplash._();
  factory SPSSplash() => _instance;
  static final Map<String, Map<String, String>> _localizedValues = {
    'zh_CN': {
      'title': '首页',
      'welcome': '欢迎来到首页！',
    },
    'en': {
      'title': 'Home',
      'welcome': 'Welcome to the home page!',
    },
  };
  String get title => _localizedValues[SPLocalization().locale]?['title'] ?? _localizedValues['en']?['title'] ?? '';
  String get welcome => _localizedValues[SPLocalization().locale]?['welcome'] ?? _localizedValues['en']?['welcome'] ?? '';
}
