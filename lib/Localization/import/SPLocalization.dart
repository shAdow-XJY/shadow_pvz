// lib/Localization/import/SPLocalization.dart

import '../SPSHome.dart';
import '../SPSSplash.dart';

final sPSHome = SPSHome();
final sPSSplash = SPSSplash();

class SPLocalization {
  SPLocalization._();
  static final SPLocalization _instance = SPLocalization._();
  factory SPLocalization() => _instance;

  String locale = 'en';


}
