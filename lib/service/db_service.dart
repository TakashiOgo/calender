import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'db_service.g.dart';

@DataClassName("ScheduleEntity")
class ScheduleEntities extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get fullTime => boolean().withDefault(const Constant(false))();
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get finishedTime => dateTime().nullable()();
  TextColumn get comment => text().nullable()();
}

// @DriftDatabase(tables: [Schedules])
// class AppDatabase extends _$AppDatabase {
//   static AppDatabase? _instance;
//
//   static AppDatabase getInstance() {
//     if (_instance == null) {
//       return _instance = AppDatabase();
//     }
//     return _instance!;
//   }
//
//   @override
//   int get schemaVersion => 1;
//
// }

@DriftDatabase(tables: [ScheduleEntities])
class MyDatabase extends _$MyDatabase {
  static MyDatabase? _instance;

  static MyDatabase getInstance() {
    if (_instance == null) {
      return _instance = MyDatabase();
    }
    return _instance!;
  }

  MyDatabase():super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<ScheduleEntity>> get allSchedulesEntries => select(scheduleEntities).get();

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path,'db.sqlite'));
    return NativeDatabase(file);
  });
}