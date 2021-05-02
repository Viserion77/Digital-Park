import 'package:DigitalPark/database/dao/session_dao.dart';
import 'package:DigitalPark/models/session.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDataBase() async {
  final String path = join(await getDatabasesPath(), 'digital_park.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(SessionDao.tableSql);
      SessionDao sessionDao = SessionDao();
      sessionDao.save(Session(0, '', false));
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
