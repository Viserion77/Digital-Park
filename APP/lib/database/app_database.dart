import 'package:learning/models/event.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDataBase() {
  return getDatabasesPath().then(
    (dbPath) {
      final String path = join(dbPath, 'parquemalwee.db');
      return openDatabase(
        path,
        onCreate: (db, version) {
          db.execute('CREATE TABLE events('
              'id INTEGER PRIMARY KEY, '
              'name TEXT, '
              'numero INTEGER)');
        },
        version: 1,
      );
    },
  );
}

Future<int> save(Event event) {
  return createDataBase().then(
    (db) {
      final Map<String, dynamic> eventMap = Map();
      eventMap['name'] = event.name;
      eventMap['numero'] = event.numero;

      return db.insert('events', eventMap);
    },
  );
}

Future<List<Event>> findAll() {
  return createDataBase().then(
    (db) {
      return db.query('events').then(
        (maps) {
          final List<Event> events = List();
          for (Map<String, dynamic> map in maps) {
            final Event event = Event(
              map['id'],
              map['name'],
              map['numero'],
            );
            events.add(event);
          }
          return events;
        },
      );
    },
  );
}
