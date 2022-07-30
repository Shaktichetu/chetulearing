import 'package:hive/hive.dart';
import 'package:project_architech/common/strings.dart';

class HiveHelper {

  static void openHive() async{

    await Hive.openBox(Strings.API_BOX);
    await Hive.openBox('PasswordSaveDb');
    await Hive.openBox(Strings.event_data_local);
    await Hive.openBox(Strings.dashboard_data_local);
    await Hive.openBox(Strings.progress_data_local);

  }
}