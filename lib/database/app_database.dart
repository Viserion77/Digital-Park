import 'package:digital_park/database/dao/user_settings_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'learningFlutter.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(
        UserSettingsDao.tableSql,
      );
    },
    version: 1,
  );
}
