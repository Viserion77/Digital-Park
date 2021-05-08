import 'package:digital_park/database/dao/session_dao.dart';
import 'package:digital_park/models/session.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDataBase() async {
  final String path = join(await getDatabasesPath(), 'digital_park.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(SessionDao.tableSql);
      SessionDao sessionDao = SessionDao();
      db.insert(SessionDao.tableName, sessionDao.toMap(Session(0, '', false)));
    },
    version: 2,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
