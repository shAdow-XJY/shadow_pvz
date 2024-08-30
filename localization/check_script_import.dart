import 'dart:io';

Future<void> checkImport() async {
  final spLocalizationFile = File('lib/Localization/import/SPLocalization.dart');

  // if (await spLocalizationFile.exists()) {
  //   print('SPLocalization.dart already exists.');
  //   return;
  // }

  const content = '''
// lib/Localization/import/SPLocalization.dart

class SPLocalization {
  SPLocalization._();

  static final SPLocalization _instance = SPLocalization._();

  factory SPLocalization() => _instance;

  String locale = 'en';
}
''';

  await spLocalizationFile.writeAsString(content);

  print('SPLocalization.dart created successfully.');
}