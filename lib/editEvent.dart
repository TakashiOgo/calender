import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _startTimeProvider = StateProvider((ref) => DateTime.now());
final _finishedTimeProvider = StateProvider((ref) => DateTime.now());
final _setStartTimeProvider = StateProvider((ref) => DateTime.now());
final _setFinishedTimeProvider = StateProvider((ref) => DateTime.now());
final isAllDayProvider = StateProvider((ref) => false);

class EditEvent extends ConsumerWidget {
  EditEvent({Key? key}) : super(key: key);

  // bool isAllDay = false;
  // int _initialStartMinute = _startTime.minute % 15 != 0 ? _startTime.minute - _startTime.minute % 15 + 15 : _startTime.minute;
  // int _initialFinishedMinute = _finishedTime.minute % 15 != 0 ? _finishedTime.minute - _finishedTime.minute % 15 + 15 : _finishedTime.minute;


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    DateTime _startTime = ref.watch(_startTimeProvider);
    DateTime _finishedTime = ref.watch(_finishedTimeProvider);
    DateTime _setStartTime = ref.watch(_setStartTimeProvider);
    DateTime _setFinishedTime = ref.watch(_setFinishedTimeProvider);
    bool isAllDay = ref.watch(isAllDayProvider);

    int _initialStartMinute = _startTime.minute % 15 != 0 ? _startTime.minute - _startTime.minute % 15 + 15 : _startTime.minute;
    int _initialFinishedMinute = _finishedTime.minute % 15 != 0 ? _finishedTime.minute - _finishedTime.minute % 15 + 15 : _finishedTime.minute;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('予定の追加'),
      ),
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: Container(
          color: const Color(0x20cccccc),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const TextField(
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'タイトルを入力してください',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 30,),
              Card(
                child: SwitchListTile(
                  title: const Text('終日'),
                  value: isAllDay,
                  onChanged: (bool? value) {
                    if(value != null) {
                      // setState(() {
                      //   isAllDay = value;
                      // });
                      ref.read(isAllDayProvider.state).update((state) => value);
                    }
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Text('開始'),
                  trailing: isAllDay == false ?
                    Text('${_startTime.year}-${_startTime.month.toString().padLeft(2, '0')}-${_startTime.day.toString().padLeft(2, '0')}  ${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}'):
                    Text('${_startTime.year}-${_startTime.month.toString().padLeft(2, '0')}-${_startTime.day.toString().padLeft(2, '0')}'),
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffffffff),
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xff999999),
                                    width: 0.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CupertinoButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 5.0,
                                    ),
                                    child: const Text('キャンセル'),
                                  ),
                                  CupertinoButton(
                                    onPressed: () {
                                      _startTime = _setStartTime;
                                      Navigator.pop(context);
                                    },
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 5.0,
                                    ),
                                    child: const Text('完了'),
                                  ),
                                ],
                              ),
                            ),
                            _bottomPicker(
                              isAllDay == false ? CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.dateAndTime,
                                initialDateTime: DateTime(_setStartTime.year, _setStartTime.month, _setStartTime.day, _setStartTime.hour, _initialStartMinute),
                                onDateTimeChanged: (dateTime) {
                                  // setState(() {
                                  //   _setStartTime = dateTime;
                                  //   _initialStartMinute = _setStartTime.minute;
                                  // });
                                  ref.read(_setStartTimeProvider.state).update((state) => dateTime);
                                  _initialStartMinute = _setStartTime.minute;
                                },
                                minuteInterval: 15,
                              ): CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime(_setStartTime.year, _setStartTime.month, _setStartTime.day),
                                onDateTimeChanged: (dateTime) {
                                  // setState(() {
                                  //   _setStartTime = dateTime;
                                  // });
                                  ref.read(_setStartTimeProvider.state).update((state) => dateTime);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Text('終了'),
                  trailing: isAllDay == false ?
                    Text('${_finishedTime.year}-${_finishedTime.month.toString().padLeft(2, '0')}-${_finishedTime.day.toString().padLeft(2, '0')}  ${_finishedTime.hour.toString().padLeft(2, '0')}:${_finishedTime.minute.toString().padLeft(2, '0')}'):
                    Text('${_finishedTime.year}-${_finishedTime.month.toString().padLeft(2, '0')}-${_finishedTime.day.toString().padLeft(2, '0')}'),
                    onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffffffff),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CupertinoButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 5.0,
                                      ),
                                      child: const Text('キャンセル'),
                                    ),
                                    CupertinoButton(
                                      onPressed: () {
                                        _finishedTime = _setFinishedTime.isBefore(_startTime) ? _startTime.add(const Duration(hours: 1)) : _setFinishedTime;
                                        _initialFinishedMinute = _finishedTime.minute % 15 != 0 ? _finishedTime.minute - _finishedTime.minute % 15 + 15 : _finishedTime.minute;
                                        Navigator.pop(context);
                                      },
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 5.0,
                                      ),
                                      child: const Text('完了'),
                                    ),
                                  ],
                                ),
                              ),
                              _bottomPicker(
                                  isAllDay == false ? CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.dateAndTime,
                                    initialDateTime: DateTime(_finishedTime.year, _finishedTime.month, _finishedTime.day, _finishedTime.hour, _initialFinishedMinute),
                                    onDateTimeChanged: (dateTime) {
                                      // setState(() {
                                      //   _setFinishedTime = dateTime;
                                      // });
                                      ref.read(_setFinishedTimeProvider.state).update((state) => dateTime);
                                    },
                                    minuteInterval: 15,
                                  ): CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: DateTime(_finishedTime.year, _finishedTime.month, _finishedTime.day),
                                    onDateTimeChanged: (dateTime) {
                                      // setState(() {
                                      //   _setFinishedTime = dateTime;
                                      // });
                                      ref.read(_setFinishedTimeProvider.state).update((state) => dateTime);
                                    },
                                  ),
                              ),
                            ],
                          );
                        },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10,),
              const TextField(
                textAlignVertical: TextAlignVertical.top,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 100),
                  border: OutlineInputBorder(),
                  hintText: 'コメントを入力してください',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _bottomPicker(Widget picker) {
  return Container(
    height: 216,
    padding: const EdgeInsets.only(top: 6.0),
    color: CupertinoColors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        onTap: () {},
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    ),
  );
}
