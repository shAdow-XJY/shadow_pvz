import 'package:logger/logger.dart';

class SPLogger
{
  static final SPLogger _instance = SPLogger._internal();

  factory SPLogger() {
    return _instance;
  }

  SPLogger._internal();

  final _logger = Logger();

  static void d(dynamic message) {
    _instance._logger.d(message);
  }

  static void e(dynamic message) {
    _instance._logger.e(message);
  }

}