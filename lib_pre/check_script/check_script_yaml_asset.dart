import 'dart:io';

Future<void> checkYamlAsset() async {
  final pubspecFile = File('pubspec.yaml');
  final pubspecContent = await pubspecFile.readAsString();

  final assetsDir = Directory('assets');
  final assetPaths = _getAssetPaths(assetsDir);

  final updatedPubspecContent = _updateAssets(pubspecContent, assetPaths);
  await pubspecFile.writeAsString(updatedPubspecContent);

  print('Assets updated in pubspec.yaml');
}

List<String> _getAssetPaths(Directory dir) {
  final paths = <String>[];
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is Directory) {
      paths.add('${entity.path}/');
    }
  }
  return paths;
}

String _updateAssets(String pubspecContent, List<String> assetPaths) {
  final lines = pubspecContent.split('\n');
  final assetsIndex = lines.indexWhere((line) => line.trim().startsWith('assets:'));

  if (assetsIndex != -1) {
    lines.removeRange(assetsIndex + 1, lines.length);
    lines.addAll(assetPaths.map((path) => '    - $path'));
  }

  return lines.join('\n');
}