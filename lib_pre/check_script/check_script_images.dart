import 'dart:io';

import 'package:path/path.dart' as path;

Future<void> checkImages() async {
  // 获取 assets/images 目录
  final imagesDir = Directory('assets/images');

  // 生成 SPAssetImages.dart 文件内容
  final buffer = StringBuffer();
  buffer.writeln('class SPAssetImages {');
  _generateImagesEntries(imagesDir, buffer, '');
  buffer.writeln('}');

  // 写入 lib/Util/Asset/SPAssetImages.dart 文件
  final outputFile = File('lib/Util/Asset/SPAssetImages.dart');
  await outputFile.writeAsString(buffer.toString());

  print('SPAssetImages.dart generated successfully!');
}

void _generateImagesEntries(Directory dir, StringBuffer buffer, String prefix) {
  final entities = dir.listSync();
  for (var entity in entities) {
    if (entity is File && !path.basename(entity.path).startsWith('.')) {
      final assetPath = path.relative(entity.path, from: 'assets/images');
      final getterName = _generateGetterName(assetPath);
      buffer.writeln('  static String get $getterName => \'$assetPath\';');
    } else if (entity is Directory) {
      final subDirPrefix = prefix.isEmpty ? path.basename(entity.path) : '$prefix/${path.basename(entity.path)}';
      _generateImagesEntries(entity, buffer, subDirPrefix);
    }
  }
}

String _generateGetterName(String assetPath) {
  final parts = assetPath.split('/');
  if (parts.length == 1) {
    final fileName = path.basenameWithoutExtension(assetPath);
    return fileName.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '.');
  } else {
    final nameParts = parts.map((part) => part.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '.'));
    final reversedParts = nameParts.toList().reversed;
    final firstPart = path.basenameWithoutExtension(reversedParts.first); // 去除文件后缀
    return '${firstPart}Of${reversedParts.skip(1).join('Of')}';
  }
}