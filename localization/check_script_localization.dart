import 'dart:convert';
import 'dart:io';

class LocalizationGenerator {
  Future<void> generate() async {
    final localizationDir = Directory('localization');
    if (await localizationDir.exists()) {
      final categories = localizationDir.listSync().whereType<Directory>();
      for (var category in categories) {
        final categoryName = category.path.split('/').last;
        final className = 'SPS$categoryName';
        final buffer = StringBuffer();
        buffer.writeln('import \'import/SPLocalization.dart\';');

        buffer.writeln('class $className {');

        buffer.writeln('  $className._();');
        buffer.writeln('  static final $className _instance = $className._();');
        buffer.writeln('  factory $className() => _instance;');

        buffer.writeln(
            '  static final Map<String, Map<String, String>> _localizedValues = {');

        final files = category
            .listSync()
            .whereType<File>()
            .where((file) => file.path.endsWith('.json'));
        final allKeys = <String>{};
        for (var file in files) {
          final locale = file.path
              .split('/')
              .last
              .split('(')
              .last
              .split(')')
              .first;
          final jsonString = await file.readAsString();
          final values = json.decode(jsonString) as Map<String, dynamic>;
          buffer.writeln('    \'$locale\': {');
          values.forEach((key, value) {
            allKeys.add(key);
            final dartKey = key.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');
            buffer.writeln('      \'$dartKey\': \'$value\',');
          });
          buffer.writeln('    },');
        }

        buffer.writeln('  };');

        const defaultLocale = 'en'; // 设置默认语言
        for (var key in allKeys) {
          final dartKey = key.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');
          buffer.writeln(
              '  String get $dartKey => _localizedValues[SPLocalization().locale]?[\'$key\'] ?? _localizedValues[\'$defaultLocale\']?[\'$key\'] ?? \'\';');
        }

        buffer.writeln('}');
        final outputFile = File('lib/Localization/$className.dart');
        await outputFile.writeAsString(buffer.toString());
      }
    }
  }
}

Future<void> checkLocalization() async {
  final generator = LocalizationGenerator();
  await generator.generate();
  print('Localization files generated successfully!');
}