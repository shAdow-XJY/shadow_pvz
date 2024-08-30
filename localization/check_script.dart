import 'check_script_import.dart';
import 'check_script_localization.dart';
import 'check_script_update_export.dart';

Future<void> main() async
{
  await checkImport();
  await checkLocalization();
  await checkUpdateExport();
}