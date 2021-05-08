import 'package:digital_park/database/app_database.dart';
import 'package:digital_park/models/session.dart';
import 'package:sqflite/sqflite.dart';

class SessionDao {
  static const String _tableName = 'sessions';
  static const String tableName = 'sessions';
  static const String _id = 'sessions';
  static const String _authToken = 'auth_token';
  static const String _staySignIn = 'stay_sign_in';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_authToken TEXT, '
      '$_staySignIn BOOLEAN);';

  Future<int> save(Session session) async {
    final Database db = await getDataBase();
    Map<String, dynamic> sessionMap = toMap(session);
    return db.insert(_tableName, sessionMap);
  }

  Map<String, dynamic> toMap(Session session) {
    final Map<String, dynamic> sessionMap = Map();
    sessionMap[_authToken] = session.authToken;
    sessionMap[_staySignIn] = session.staySignIn;
    return sessionMap;
  }

  Future<List<Session>> findAll() async {
    final Database db = await getDataBase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Session> sessions = toList(result);
    return sessions;
  }

  Future<Session> getLast() async {
    List<Session> sessions = await findAll();
    Session session = sessions.last;
    return session;
  }

  List<Session> toList(List<Map<String, dynamic>> result) {
    final List<Session> sessions = [];
    for (Map<String, dynamic> row in result) {
      final Session session = Session(
        row[_id],
        row[_authToken],
        row[_staySignIn] == 1 ? true : false,
      );
      sessions.add(session);
    }
    return sessions;
  }
}
