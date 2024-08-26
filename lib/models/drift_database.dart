import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'drift_database.g.dart';

class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get subTitle => text()();
  TextColumn get date => text()();
}

@DriftDatabase(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'my_database');
  }
}
