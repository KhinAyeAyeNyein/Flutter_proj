import 'dart:core';

import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/Dashboard/dashboard_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime mainDate = DateTime.now();
  DateTime firstDayOfMonth = DateTime.now();
  DateTime lastDayOfMonth = DateTime.now();
  late String _month = "";
  bool rowFlag = false;

  @override
  void initState() {
    _generateCalendar();
    super.initState();
  }

  bool _isWeekend(int index) {
    final dayOfWeek = (index) % DateTime.daysPerWeek + 1;
    return dayOfWeek == 1 || dayOfWeek == 7;
  }

  void _generateCalendar() {
    DateTime d = DateTime.now();
    mainDate = DateTime(d.year, d.month, d.day);
    firstDayOfMonth = DateTime(mainDate.year, mainDate.month, 1);
    lastDayOfMonth = DateTime(mainDate.year, mainDate.month + 1, 0);
    if (firstDayOfMonth.weekday == 5 && lastDayOfMonth.day > 30) {
      rowFlag = true;
    }
    if (firstDayOfMonth.weekday == 6 && lastDayOfMonth.day > 29) {
      rowFlag = true;
    }
    _month = DateFormat("MMMM").format(mainDate);
  }

  bool _isToday(int index) {
    return firstDayOfMonth.weekday + mainDate.day == index;
  }

  List titleD = ["S", "M", "T", "W", "T", "F", "S"];

  @override
  Widget build(BuildContext context) {
    DashboardService controller = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            flex: 6,
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: SizedBox(
                height: rowFlag ? 410 : 350,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(flex: 1, child: Text(_month)),
                        const SizedBox(height: 20),
                        Flexible(
                            flex: 1,
                            child: Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: CommonWidget.softColor,
                              ),
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7,
                                        crossAxisSpacing: 6,
                                        mainAxisSpacing: 6),
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Center(
                                        child: Text(titleD[index],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold))),
                                  );
                                },
                              ),
                            )),
                        const SizedBox(height: 5),
                        Flexible(
                            flex: 6,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 7,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6),
                              itemCount:
                                  DateTime.daysPerWeek * (rowFlag ? 6 : 5),
                              itemBuilder: (context, index) {
                                int day = (index) - firstDayOfMonth.weekday + 1;
                                String currentDateString =
                                    "${controller.padZero(day)}/${controller.padZero(mainDate.month)}/${mainDate.year}";
                                return Obx(() {
                                  if (controller.isLoading) {
                                    return Center(
                                        child: Container(
                                      decoration:
                                          CommonWidget.calendarOfficeDay(),
                                    ));
                                  }
                                  return Container(
                                      decoration: _isToday(index + 1)
                                          ? CommonWidget.calendarDayActive()
                                          : controller
                                                  .isLeave(currentDateString)
                                              ? CommonWidget.calendarLeaveDay()
                                              : controller.attendanceRecord(
                                                          ((index) -
                                                              firstDayOfMonth
                                                                  .weekday +
                                                              1)) ==
                                                      2
                                                  ? CommonWidget
                                                      .calendarOfficeDay()
                                                  : controller.attendanceRecord(
                                                              ((index) -
                                                                  firstDayOfMonth
                                                                      .weekday +
                                                                  1)) ==
                                                          3
                                                      ? CommonWidget
                                                          .calendarWFHDay()
                                                      : controller.isHoliday(
                                                              currentDateString)
                                                          ? CommonWidget
                                                              .calendarHolidayDay()
                                                          : null,
                                      child: Center(
                                          child: firstDayOfMonth.weekday <=
                                                      index &&
                                                  lastDayOfMonth.day +
                                                          firstDayOfMonth
                                                              .weekday >
                                                      index
                                              ? TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "${(index) - firstDayOfMonth.weekday + 1}",
                                                    style: TextStyle(
                                                        color: _isToday(
                                                                index + 1)
                                                            ? Colors.white
                                                            : _isWeekend(index)
                                                                ? Colors.black54
                                                                : Colors.black,
                                                        fontWeight: _isWeekend(
                                                                index)
                                                            ? FontWeight.normal
                                                            : FontWeight.bold),
                                                  ),
                                                )
                                              : const SizedBox()));
                                });
                              },
                            ))
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
