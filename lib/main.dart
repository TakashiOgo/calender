import 'dart:collection';

import 'package:calender/editEvent.dart';
import 'package:calender/service/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';

final _focusedDayProvider = StateProvider((ref) => DateTime.now());
final _selectedDayProvider = StateProvider((ref) => DateTime.now());
final _setSelectedDayProvider = StateProvider((ref) => DateTime.now());
final _visibleProvider = StateProvider((ref) => false);
var sampleEvents = {
  DateTime.utc(2023,1,15): ['firstEvent', 'secondEvent'],
  DateTime.utc(2023,1,25): ['christmas'],
  DateTime.utc(2023,1,20): ['aaaaa'],
  DateTime.utc(2023,1,21): ['bbbbb'],
  DateTime.utc(2023,1,22): ['ccccc'],
  DateTime.utc(2023,1,23): ['ddddd'],
};

// var events = {
//   _selectedDay.subtract(Duration(days: 1)):['xxxx'],
//   _selectedDay:['yyyy'],
//   _selectedDay.add(Duration(days: 1)):['zzzz'],
// };
int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}


void main() {
  final database = MyDatabase();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja')
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalenderList(),
    );
  }
}

class CalenderList extends ConsumerWidget {
  const CalenderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Color _textColor(DateTime day) {
      const _defaultTextColor = Colors.black87;

      if(_visibleProvider.notifier == false) {
        if(day.weekday == DateTime.sunday) {
          return Colors.red;
        }
        if(day.weekday == DateTime.saturday) {
          return Colors.blue;
        }
      }
      return _defaultTextColor;
    }

    int eventCount = 0;
    List sample = [
      DateTime.now().subtract(Duration(days: 1)),
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
    ];

    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(sampleEvents);

    List _getEventsForDay(DateTime day) {
      return _events[day] ?? [];
    }

    bool _visible = ref.watch(_visibleProvider);
    DateTime _selectedDay = ref.watch(_selectedDayProvider);
    DateTime _focusedDay = ref.watch(_focusedDayProvider);
    DateTime _setSelectedDay = ref.watch(_setSelectedDayProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('カレンダー'),
      ),
      body: Container(
        color: _visible == true ? Colors.black54 : Colors.white,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (_) {
                // setState(() {
                //   _visible = false;
                // });
                ref.read(_visibleProvider.notifier).update((state) => false);
              },
              child: Stack(
                children: [
                  TableCalendar(
                    locale: 'ja_JP',
                    firstDay: DateTime.utc(2000,12,1),
                    lastDay: DateTime.utc(2050,12,31),
                    rowHeight: 60,
                    daysOfWeekHeight: 32,
                    headerStyle: const HeaderStyle(
                      titleTextStyle: TextStyle(color: Colors.transparent),
                      headerPadding: EdgeInsets.only(top: 20,bottom: 20),
                      titleCentered: true,
                      formatButtonVisible: false,
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onPageChanged: (focusedDay) {
                      ref.read(_focusedDayProvider.notifier).update((state) => focusedDay);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                        // setState(() {
                        //   _selectedDay = selectedDay;
                        //   _focusedDay = focusedDay;
                        //   _visible = true;
                        //   _selectedEvents = sampleEvents[selectedDay] ?? [];
                        // });
                      ref.read(_selectedDayProvider.notifier).update((state) => selectedDay);
                      ref.read(_focusedDayProvider.notifier).update((state) => focusedDay);
                      ref.read(_visibleProvider.notifier).update((state) => true);
                        _getEventsForDay(selectedDay);
                    },
                    focusedDay: _focusedDay,
                    eventLoader: _getEventsForDay,
                    // eventLoader: (date) {
                    //   return sampleEvents[date] ?? [];
                    // },
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (BuildContext context, DateTime day){
                        return Container(
                          child: Center(
                            child: Text(
                              DateFormat.E('ja').format(day),
                              style: TextStyle(color: _textColor(day),),
                            ),
                          ),
                        );
                      },
                      defaultBuilder: (BuildContext context, DateTime day, DateTime focusedDay) {
                        return Container(
                          margin: EdgeInsets.zero,
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: TextStyle(
                                color: _textColor(day),
                              ),
                            ),
                          ),
                        );
                      },
                      disabledBuilder: (
                        BuildContext context, DateTime day, DateTime focusedDay) {
                          return Container(
                            margin: EdgeInsets.zero,
                            child: Center(
                              child: Text(
                                day.day.toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      // selectedBuilder: (
                      //   BuildContext context, DateTime day, DateTime focusedDay) {
                      //     return Container(
                      //       margin: EdgeInsets.zero,
                      //       child: Center(
                      //         child: Text(
                      //           day.day.toString(),
                      //           style: TextStyle(
                      //             color: _textColor(day),
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                    ),
                  ),
                  Align(
                    alignment: const Alignment(-0.9, -0.97),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                      onPressed: () {
                        _visible == true ? null :
                       // setState(() {
                       //   _selectedDay = DateTime.now();
                       //   _focusedDay = DateTime.now();
                       //   _setSelectedDay = DateTime.now();
                       // });
                        ref.read(_selectedDayProvider.notifier).update((state) => DateTime.now());
                        ref.read(_focusedDayProvider.notifier).update((state) => DateTime.now());
                        ref.read(_setSelectedDayProvider.notifier).update((state) => DateTime.now());
                      },
                      child: const Text('今日',style: TextStyle(color: Colors.black),)
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.1,-0.98),
                    child: TextButton(
                        onPressed: () {
                          _visible == true ? null :
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
                                          // setState(() {
                                          //   _selectedDay = _setSelectedDay;
                                          //   _focusedDay = _setSelectedDay;
                                          // });
                                          ref.read(_selectedDayProvider.notifier).update((state) => _selectedDay);
                                          ref.read(_focusedDayProvider.notifier).update((state) => _selectedDay);
                                          print(_selectedDay);
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
                                  CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day),
                                    onDateTimeChanged: (date) {
                                      // setState(() {
                                      //   _setSelectedDay = date;
                                      // });
                                      ref.read(_selectedDayProvider.notifier).update((state) => date);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _visible == true ? Colors.transparent : Colors.white,
                        ),
                        height: 40,
                        width: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${_selectedDay.year}年${_selectedDay.month}月 ',
                              style: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _visible == true ?
            CarouselSlider.builder(
                itemCount: sample.length,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height/3*2,
                  viewportFraction: 0.88,
                  initialPage: 1,
                  onPageChanged: (index, _) {
                    // setState(() {
                    //   _selectedDay = sample[index];
                    //   sample[0] = _selectedDay.subtract(Duration(days: 1));
                    //   sample[1] = _selectedDay;
                    //   sample[2] = _selectedDay.add(Duration(days: 1));
                    //   print(_selectedDay);
                    // });
                    ref.read(_setSelectedDayProvider.notifier).update((state) => sample[index]);
                  },
                ),
                itemBuilder: (context, index, int) {
                  return Container(
                    width: MediaQuery.of(context).size.width/6*5,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DateFormat.yMMMEd('ja').format(_selectedDay!),style: TextStyle(fontSize: 20),),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditEvent()),);
                                  },
                                  icon: const Icon(Icons.add)),
                            ],
                          ),
                        ),
                        Flexible(
                          child: ListView(
                            shrinkWrap: true,
                            children:
                            // Container(
                            //   padding: const EdgeInsets.all(5),
                            //   decoration: const BoxDecoration(
                            //       border: Border(
                            //           top: BorderSide(
                            //             color: Color(0x20aaaaaa),
                            //             width: 1,
                            //           )
                            //       )
                            //   ),
                            //   child:
                            _getEventsForDay(_selectedDay)
                                .map((event) => ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  border: Border(right: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  )),
                                ),
                                child: Column(
                                  children: [
                                    Text('${_selectedDay.hour.toString().padLeft(2, '0')}:${_selectedDay!.minute.toString().padLeft(2, '0')}'),
                                    Text('${(_selectedDay.hour+1).toString().padLeft(2, '0')}:${(_selectedDay!.minute+10).toString().padLeft(2, '0')}')
                                  ],
                                ),
                              ),
                              title: Text(event ?? '予定がありません',
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {},
                            ))
                                .toList(),
                            // ),
                          ),
                        ),
                        // Flexible(
                        //     child: ListView.builder(
                        //       itemCount: _sliderSelectedEvents.length,
                        //       itemBuilder: (context, index) {
                        //         final event = _sliderSelectedEvents[index];
                        //         return Container(
                        //           padding: const EdgeInsets.all(5),
                        //           decoration: const BoxDecoration(
                        //               border: Border(
                        //                   top: BorderSide(
                        //                     color: Color(0x20aaaaaa),
                        //                     width: 1,
                        //                   )
                        //               )
                        //           ),
                        //           child: ListTile(
                        //             leading: Container(
                        //               padding: const EdgeInsets.all(10),
                        //               decoration: const BoxDecoration(
                        //                 border: Border(right: BorderSide(
                        //                   color: Colors.blue,
                        //                   width: 3,
                        //                 )),
                        //               ),
                        //               child: Column(
                        //                 children: [
                        //                   Text('${_selectedDay!.hour.toString().padLeft(2, '0')}:${_selectedDay!.minute.toString().padLeft(2, '0')}'),
                        //                   Text('${(_selectedDay!.hour+1).toString().padLeft(2, '0')}:${(_selectedDay!.minute+10).toString().padLeft(2, '0')}')
                        //                 ],
                        //               ),
                        //             ),
                        //             title: Text(event == null ? '予定がありません' : event,
                        //               overflow: TextOverflow.ellipsis,
                        //             ),
                        //             onTap: () {},
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //     // child: ListTile(
                        //     //   leading: Container(
                        //     //     padding: const EdgeInsets.all(10),
                        //     //     decoration: const BoxDecoration(
                        //     //       border: Border(right: BorderSide(
                        //     //         color: Colors.red,
                        //     //         width: 3,
                        //     //       )),
                        //     //     ),
                        //     //     child: Column(
                        //     //       children: [
                        //     //         Text('${_focusedDay.hour.toString().padLeft(2, '0')}:${_focusedDay.minute.toString().padLeft(2, '0')}'),
                        //     //         Text('${(_focusedDay.hour+1).toString().padLeft(2, '0')}:${(_focusedDay.minute+10).toString().padLeft(2, '0')}')
                        //     //       ],
                        //     //     ),
                        //     //   ),
                        //     //   title: const Text(
                        //     //     'タイトルタイトルタイトルタイトルタイトル',
                        //     //     overflow: TextOverflow.ellipsis,
                        //     //   ),
                        //     //   onTap: () {},
                        //     // ),
                        //   ),
                        // const SizedBox(height: 5,),
                        // Container(
                        //   padding: const EdgeInsets.only(top: 5),
                        //   decoration: const BoxDecoration(
                        //       border: Border(
                        //           top: BorderSide(
                        //             color: Colors.blue,
                        //             width: 1,
                        //           )
                        //       )
                        //   ),
                        //   child: ListTile(
                        //     leading: Container(
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: const BoxDecoration(
                        //         border: Border(right: BorderSide(
                        //           color: Colors.red,
                        //           width: 3,
                        //         )),
                        //       ),
                        //       child: Column(
                        //         children: [
                        //           Text('${_selectedDay!.hour.toString().padLeft(2, '0')}:${_selectedDay!.minute.toString().padLeft(2, '0')}'),
                        //           Text('${(_selectedDay!.hour+1).toString().padLeft(2, '0')}:${(_selectedDay!.minute+10).toString().padLeft(2, '0')}')
                        //         ],
                        //       ),
                        //     ),
                        //     title: const Text(
                        //       'タイトルタイトルタイトルタイトルタイトル',
                        //       overflow: TextOverflow.ellipsis,
                        //     ),
                        //     onTap: () {},
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },

            // CarouselSlider(
            //   options: CarouselOptions(
            //     height: MediaQuery.of(context).size.height/3*2,
            //     viewportFraction: 0.88,
            //     initialPage: 1,
            //   ),
            //   items: events.map((event) {
            //     return setState(() {
            //       Container(
            //         width: MediaQuery.of(context).size.width/6*5,
            //         padding: const EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: Column(
            //           children: [
            //             Container(
            //               padding: const EdgeInsets.all(10),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text(DateFormat.yMMMEd('ja').format(_selectedDay),style: TextStyle(fontSize: 20),),
            //                   IconButton(
            //                       onPressed: () {
            //                         Navigator.push(context, MaterialPageRoute(builder: (context) => EditEvent()),);
            //                       },
            //                       icon: const Icon(Icons.add)),
            //                 ],
            //               ),
            //             ),
            //             // Flexible(
            //             //   child: ListView.builder(
            //             //     itemCount: event.length,
            //             //     itemBuilder: (context, index) {
            //             //       return Container(
            //             //         padding: const EdgeInsets.all(5),
            //             //         decoration: const BoxDecoration(
            //             //             border: Border(
            //             //                 top: BorderSide(
            //             //                   color: Color(0x20aaaaaa),
            //             //                   width: 1,
            //             //                 )
            //             //             )
            //             //         ),
            //             //         child: ListTile(
            //             //           leading: Container(
            //             //             padding: const EdgeInsets.all(10),
            //             //             decoration: const BoxDecoration(
            //             //               border: Border(right: BorderSide(
            //             //                 color: Colors.blue,
            //             //                 width: 3,
            //             //               )),
            //             //             ),
            //             //             child: Column(
            //             //               children: [
            //             //                 Text('${_selectedDay!.hour.toString().padLeft(2, '0')}:${_selectedDay!.minute.toString().padLeft(2, '0')}'),
            //             //                 Text('${(_selectedDay!.hour+1).toString().padLeft(2, '0')}:${(_selectedDay!.minute+10).toString().padLeft(2, '0')}')
            //             //               ],
            //             //             ),
            //             //           ),
            //             //           title: Text(event ?? '予定がありません',
            //             //             overflow: TextOverflow.ellipsis,
            //             //           ),
            //             //           onTap: () {},
            //             //         ),
            //             //       );
            //             //     },
            //             //   ),
            //             // ),
            //             Flexible(
            //               child: ListView(
            //                 shrinkWrap: true,
            //                 children:
            //                 // Container(
            //                 //   padding: const EdgeInsets.all(5),
            //                 //   decoration: const BoxDecoration(
            //                 //       border: Border(
            //                 //           top: BorderSide(
            //                 //             color: Color(0x20aaaaaa),
            //                 //             width: 1,
            //                 //           )
            //                 //       )
            //                 //   ),
            //                 //   child:
            //                 _getEventsForDay(_selectedDay)
            //                     .map((event) => ListTile(
            //                   leading: Container(
            //                     padding: const EdgeInsets.all(10),
            //                     decoration: const BoxDecoration(
            //                       border: Border(right: BorderSide(
            //                         color: Colors.blue,
            //                         width: 3,
            //                       )),
            //                     ),
            //                     child: Column(
            //                       children: [
            //                         Text('${_selectedDay!.hour.toString().padLeft(2, '0')}:${_selectedDay!.minute.toString().padLeft(2, '0')}'),
            //                         Text('${(_selectedDay!.hour+1).toString().padLeft(2, '0')}:${(_selectedDay!.minute+10).toString().padLeft(2, '0')}')
            //                       ],
            //                     ),
            //                   ),
            //                   title: Text(event ?? '予定がありません',
            //                     overflow: TextOverflow.ellipsis,
            //                   ),
            //                   onTap: () {},
            //                 ))
            //                     .toList(),
            //                 // ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     });
            //   },).toList(),
            ):Container(),
          ],
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