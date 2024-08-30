import 'dart:io';

Future<void> checkUpdateExport() async {
  final localizationDir = Directory('lib/Localization');
  final spLocalizationFile = File('lib/Localization/import/SPLocalization.dart');

  if (!await localizationDir.exists()) {
    print('lib/Localization directory does not exist.');
    return;
  }

  if (!await spLocalizationFile.exists()) {
    print('lib/Localization/import/SPLocalization.dart does not exist.');
    return;
  }

  final dartFiles = localizationDir
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart') && file.path != spLocalizationFile.path);

  final buffer = StringBuffer();
  buffer.writeln('// lib/Localization/import/SPLocalization.dart');
  buffer.writeln('');
  for (var file in dartFiles) {
    final fileName = file.path.split('/').last.replaceAll('.dart', '');
    buffer.writeln('import \'../$fileName.dart\';');
  }
  buffer.writeln('');
  for (var file in dartFiles) {
    final className = file.path.split('/').last.replaceAll('.dart', '');
    final instanceName = className[0].toLowerCase() + className.substring(1);
    buffer.writeln('final $instanceName = $className();');
  }
  buffer.writeln('');
  buffer.writeln('class SPLocalization {');
  buffer.writeln('  SPLocalization._();');
  buffer.writeln('  static final SPLocalization _instance = SPLocalization._();');
  buffer.writeln('  factory SPLocalization() => _instance;');
  buffer.writeln('');
  buffer.writeln('  String locale = \'en\';');
  buffer.writeln('');
  buffer.writeln('');
  buffer.writeln('}');

  await spLocalizationFile.writeAsString(buffer.toString());

  print('SPLocalization.dart updated successfully.');
}