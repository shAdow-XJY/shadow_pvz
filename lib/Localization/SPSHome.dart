import 'import/SPLocalization.dart';
class SPSHome {
  SPSHome._();
  static final SPSHome _instance = SPSHome._();
  factory SPSHome() => _instance;
  static final Map<String, Map<String, String>> _localizedValues = {
    'zh_CN': {
      'title': '首页',
      'subtitle': '欢迎来到首页！',
    },
    'en': {
      'title': 'Home',
      'subtitle': 'Welcome to the home page!',
    },
  };
  String get title => _localizedValues[SPLocalization().locale]?['title'] ?? _localizedValues['en']?['title'] ?? '';
  String get subtitle => _localizedValues[SPLocalization().locale]?['subtitle'] ?? _localizedValues['en']?['subtitle'] ?? '';
}
