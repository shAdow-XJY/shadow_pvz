import 'check_script_audio.dart';
import 'check_script_images.dart';
import 'check_script_lottie.dart';
import 'check_script_yaml_asset.dart';

Future<void> main() async
{
  await checkAudio();
  await checkImages();
  await checkLottie();
  await checkYamlAsset();
}