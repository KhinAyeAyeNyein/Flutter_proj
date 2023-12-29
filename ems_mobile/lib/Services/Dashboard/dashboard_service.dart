import 'dart:convert';

import 'package:ems_mobile/Models/Attendance/attendance.dart';
import 'package:ems_mobile/Models/Employee/employee.dart';
import 'package:ems_mobile/Models/Leave/leave.dart';
import 'package:ems_mobile/Models/Overtime/overtime_model.dart';
import 'package:ems_mobile/Services/Common/api_service.dart';
import 'package:ems_mobile/Services/Common/config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardService extends GetxController {
  final _isLoading = false.obs;
  final _isLeaveLoading = false.obs;
  final _isOvertimeLoading = false.obs;
  final _isHolidayLoading = false.obs;
  final _attendanceList = <Attendance>[].obs;
  final _leaveHistory = <Leave>[].obs;
  final _overtimeHistory = <Overtime>[].obs;
  final _holidayLists = <String>[].obs;
  final _employee = Employee.empty().obs;

  ApiService api = ApiService();

  bool get isLoading => _isLoading.value;
  bool get isLeaveLoading => _isLeaveLoading.value;
  bool get isOvertimeLoading => _isOvertimeLoading.value;
  bool get isHolidayLoading => _isHolidayLoading.value;

  List<Attendance> get getAttendanceList => _attendanceList.value;
  List<Leave> get getLeaveHistory => _leaveHistory.value;
  List<Overtime> get getOvertimeHistory => _overtimeHistory.value;
  List<String> get getHolidayLists => _holidayLists.value;

  @override
  void onInit() {
    DateTime now = DateTime.now() /*DateTime(2023, 3, 1)*/;
    getAttendanceData(now);
    fetchLeaveHistory(now);
    fetchOvertimeHistory(now);
    fetchHolidayLists(now);
    super.onInit();
  }

  Future<bool> getAttendanceData(DateTime dateTime) async {
    _isLoading(true);
    DateTime fromDate = DateTime(dateTime.year, dateTime.month, 1);
    DateTime toDate = DateTime(dateTime.year, dateTime.month + 1, 0);
    final response = await api.post(
        "${Config.domainUrl}${Config.attendanceHistory}&search=true",
        {
          "fromDate": DateFormat("d/MM/y").format(fromDate),
          "toDate": DateFormat("d/MM/y").format(toDate),
          "attendanceType": 0
        });
    _isLoading(false);
    if (response.statusCode != 200) {
      return false;
    }
    Map<String, dynamic> body = jsonDecode(response.body);
    final listBody = body["wfhHistory"] as List<dynamic>;
    _attendanceList.value =
        listBody.map((e) => Attendance.fromJson(e)).toList().reversed.toList();

    return true;
  }

  int attendanceRecord(int day) {
    Attendance? attendance = getAttendanceList.firstWhereOrNull(
            (element) => parseDate(element.recordDate!).day == day);
    if(attendance == null) return 0; // no record
    if(attendance.wfhFlag == "1") return 3; // WFH
    if((attendance.offDayFlag == "0" && attendance.wfhFlag == null)) return 4; //leave
    bool noReport = attendance.arrivalTime == null && attendance.leaveTime == null;
    if(noReport) return 1; // noReport
    if(!noReport) return 2; //attendance
    return 0; // no record
  }

  Future<bool> fetchLeaveHistory(DateTime dateTime) async {
    _isLeaveLoading(true);
    DateTime fromDate = DateTime(dateTime.year, dateTime.month, 1);
    DateTime toDate = DateTime(dateTime.year, dateTime.month + 1, 0);
    final response = await api.post("${Config.domainUrl}${Config.leaveHistoryRecord}?offset=1&limit=31&search=true", {
      "fromDate": DateFormat("d/MM/y").format(fromDate),
      "toDate": DateFormat("d/MM/y").format(toDate),
    });
    if(response.statusCode != 200) return false;
    Map<String, dynamic> body = jsonDecode(response.body);
    final listBody = body["leaveRecordHistory"] as List<dynamic>;
    _leaveHistory.value = listBody.map((e) => Leave.fromJson(e)).toList().reversed.toList();
    _isLeaveLoading(false);
    return true;
  }

  Future<bool> fetchOvertimeHistory (DateTime dateTime) async{
    _isOvertimeLoading(true);
    DateTime fromDate = DateTime(dateTime.year, dateTime.month, 1);
    DateTime toDate = DateTime(dateTime.year, dateTime.month + 1, 0);
    final response = await api.post("${Config.domainUrl}${Config.overtimeHistoryRecord}?offset=1&limit=31&search=true", {
      "fromDate": DateFormat("d/MM/y").format(fromDate),
      "toDate": DateFormat("d/MM/y").format(toDate),
    });
    if(response.statusCode != 200) return false;
    Map<String, dynamic> body = jsonDecode(response.body);
    final listBody = body["overtimeRecordHistory"] as List<dynamic>;
    _overtimeHistory.value = listBody.map((e) => Overtime.fromJson(e)).toList().reversed.toList();
    _isOvertimeLoading(false);
    return true;
  }
  Future<bool> fetchHolidayLists(DateTime dateTime) async {
    _isHolidayLoading(true);
    DateTime fromDate = DateTime(dateTime.year, dateTime.month, 1);
    DateTime toDate = DateTime(dateTime.year, dateTime.month + 1, 0);
    final response = await api.post("${Config.domainUrl}${Config.holidayList}?fromDate=${
        DateFormat("d/MM/y").format(fromDate)
    }&toDate=${
        DateFormat("d/MM/y").format(toDate)
    }", null);

    if(response.statusCode != 200) return false;
    Map<String, dynamic> body = jsonDecode(response.body);
    final listBody = body["holidayList"] as List<dynamic>;
    // _holidayLists.value = listBody.map((e)=> e.toString()).toList();
    _holidayLists.value = ["10/04/2023","11/04/2023","12/04/2023","13/04/2023","14/04/2023","17/04/2023"];
    _isHolidayLoading(false);
    return true;
  }
  DateTime parseDate(String date){
    List<String> ddate = date.split("/");
    if(ddate.isEmpty) return DateTime.now();
    return DateFormat("yyyy-MM-dd").parse("${ddate[2]}-${ddate[1]}-${ddate[0]}");
  }

  String timeDifference(String time1, String time2){
    DateTime now = DateTime.now();
    DateTime dateTime1 = DateTime(now.year, now.month, now.day, int.parse(time1.split(":")[0]), int.parse(time1.split(":")[1]));
    DateTime dateTime2 = DateTime(now.year, now.month, now.day, int.parse(time2.split(":")[0]), int.parse(time2.split(":")[1]));
    Duration difference = dateTime2.difference(dateTime1);
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    if(minutes == 0) return "$hours";
    return "$hours : $minutes";
  }

  isLeave(String dateTime) {
    Leave? index = getLeaveHistory.firstWhereOrNull((leave) => leave.leaveDate == dateTime && leave.leaveDetailStatus == "2");
    return index != null;
  }
  isHoliday(String dateTime) {
    String? index = getHolidayLists.firstWhereOrNull((holiday) => holiday == dateTime);
    return index != null;
  }
  String padZero(int value){
    return value < 10 ? "0$value" : value.toString();
  }
}
