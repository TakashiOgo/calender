import 'package:calender/model/model.dart';
import 'package:calender/service/calender_dao.dart';
import 'package:calender/service/db_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final schedulesStreamProvider = StreamProvider.autoDispose<List<Schedule>>(
//     (ref) => ScheduleRepository().getSchedules());

class ScheduleRepository {
  late ScheduleDao _dao;

  ScheduleRepository() {
    _dao = ScheduleDao(MyDatabase.getInstance());
  }

  Future<int> addSchedule(Schedule schedule) async {
    return await _dao.insert(
      ScheduleEntity(
        title: schedule.title,
        fullTime: schedule.fullTime,
        startTime: schedule.startTime,
        finishedTime: schedule.finishedTime,
      ),
    );
  }

  Future<int> updateSchedule(Schedule schedule) async {
    return await _dao.updateSchedule(
      ScheduleEntity(
        id: schedule.id,
        title: schedule.title,
        fullTime: schedule.fullTime,
      ),
    );
  }

  Future<int> removeSchedule(Schedule schedule) async {
    return await _dao.clearById(schedule.id!);
  }

}