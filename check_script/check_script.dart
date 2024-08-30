import 'check_script_audio.dart';
import 'check_script_images.dart';

Future<void> main() async
{
  await checkAudio();
  await checkImages();
}