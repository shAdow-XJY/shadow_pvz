import 'dart:io';

import 'package:path/path.dart' as path;

Future<void> checkAudio() async {
  // 获取 assets/audio 目录
  final audioDir = Directory('assets/audio');
  final audioFiles = audioDir.listSync().whereType<File>();

  // 生成 SPAssetAudio.dart 文件内容
  final buffer = StringBuffer();
  buffer.writeln('class SPAssetAudio {');
  for (var file in audioFiles) {
    final fileName = path.basenameWithoutExtension(file.path);
    final assetPath = path.basename(file.path);
    buffer.writeln('  static String get $fileName => \'$assetPath\';');
  }
  buffer.writeln('}');

  // 写入 lib/Util/Asset/SPAssetAudio.dart 文件
  final outputFile = File('lib/Util/Asset/SPAssetAudio.dart');
  await outputFile.writeAsString(buffer.toString());

  print('SPAssetAudio.dart generated successfully!');
}