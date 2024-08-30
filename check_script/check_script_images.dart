import 'dart:io';

import 'package:path/path.dart' as path;

Future<void> checkImages() async {
  // 获取 assets/images 目录
  final audioDir = Directory('assets/images');
  final audioFiles = audioDir.listSync().whereType<File>();

  // 生成 SPAssetImages.dart 文件内容
  final buffer = StringBuffer();
  buffer.writeln('class SPAssetImages {');
  for (var file in audioFiles) {
    final fileName = path.basenameWithoutExtension(file.path);
    final assetPath = 'assets/images/${path.basename(file.path)}';
    buffer.writeln('  static String get $fileName => \'$assetPath\';');
  }
  buffer.writeln('}');

  // 写入 lib/Util/Asset/SPAssetImages.dart 文件
  final outputFile = File('lib/Util/Asset/SPAssetImages.dart');
  await outputFile.writeAsString(buffer.toString());

  print('SPAssetImages.dart generated successfully!');
}