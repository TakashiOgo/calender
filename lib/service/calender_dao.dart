import 'package:drift/drift.dart';
import 'db_service.dart';

part 'calender_dao.g.dart';

@DriftAccessor(tables: [ScheduleEntities])
class ScheduleDao extends DatabaseAccessor<MyDatabase> with _$ScheduleDaoMixin {
  ScheduleDao(MyDatabase db) : super(db);

  Future<int> insert(ScheduleEntity schedule) async {
    return await into(scheduleEntities).insert(schedule);
  }

  Future<int> updateSchedule(ScheduleEntity schedule) async {
    return await (update(scheduleEntities)..where((d) => d.id.equals(schedule.id!)))
        .write(schedule);
  }

  Future clearById(int id) =>
      (delete(scheduleEntities)..where((d) => d.id.equals(id))).go();

}