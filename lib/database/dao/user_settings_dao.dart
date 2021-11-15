import 'package:digital_park/database/app_database.dart';
import 'package:digital_park/models/user/user_settings.dart';
import 'package:sqflite/sqflite.dart';

class UserSettingsDao {
  static const String _tableName = 'user_settings';
  static const String _id = 'id';
  static const String _staySignIn = 'stay_sign_in';
  static const String _provider = 'provider';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_staySignIn INTEGER, '
      '$_provider TEXT)';

  Future<int> save(UserSettings userSettings) async {
    final Database db = await getDatabase();
    Map<String, dynamic> userSettingsMap = _toMap(userSettings);

    print('save ${userSettings.toString()}');
    return db.insert(_tableName, userSettingsMap);
  }

  Future<int> update(UserSettings userSettings) async {
    final Database db = await getDatabase();
    Map<String, dynamic> userSettingsMap = _toMap(userSettings);
    userSettingsMap[_id] = userSettings.id;

    print('update ${userSettings.toString()}');
    return db.update(
      _tableName,
      userSettingsMap,
      where: '$_id = ?',
      whereArgs: [userSettingsMap[_id]],
    );
  }

  Future<UserSettings> find() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);

    UserSettings userSettings = _toUserSettings(result[0]);
    print('find ${userSettings.toString()}');
    return userSettings;
  }

  UserSettings _toUserSettings(Map<String, dynamic> row) {
    final UserSettings userSettings = UserSettings(
      row[_id],
      staySignIn: row[_staySignIn] == 1,
      provider: row[_provider],
    );

    return userSettings;
  }

  Map<String, dynamic> _toMap(UserSettings userSettings) {
    final Map<String, dynamic> userSettingsMap = {};

    userSettingsMap[_staySignIn] = userSettings.staySignIn ? 1 : 0;
    userSettingsMap[_provider] = userSettings.provider;
    return userSettingsMap;
  }
}
