import 'package:ems_mobile/Models/Attendance/attendance.dart';
import 'package:ems_mobile/Screens/Attendance/attendance_history.dart';
import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/Attendance/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceEditReport extends StatefulWidget {
  final Attendance attendance;
  final List<String> attTypelist;
  const AttendanceEditReport(
      {super.key, required this.attendance, required this.attTypelist});

  @override
  State<AttendanceEditReport> createState() => _AttendanceEditReportState();
}

class _AttendanceEditReportState extends State<AttendanceEditReport> {
  final _formKey = GlobalKey<FormState>();
  final _empIdController = TextEditingController();
  final _empNameController = TextEditingController();
  final _dateController = TextEditingController();
  final _fromTimeController = TextEditingController();
  final _toTimeController = TextEditingController();
  final _descController = TextEditingController();
  RxBool showDropdown = false.obs;
  bool state = false;

  List<String> statuslist = ["Request", "Save"];
  String statusValue = "";
  String type = "";
  String status = "";
  late Attendance attendance = Attendance.empty();
  List<String> attTypelist = [];
  String attTypeValue = "";
  @override
  void initState() {
    super.initState();
    statusValue = statuslist.first;
    attendance = widget.attendance;
    attTypelist = widget.attTypelist;
    _empIdController.text = attendance.employeeId!;
    _empNameController.text = attendance.employeeName!;
    _dateController.text = attendance.recordDate!;
    _fromTimeController.text = attendance.arrivalTime!;
    _toTimeController.text = attendance.leaveTime!;
    _descController.text = attendance.description!;
    String dateString = _dateController.text;
    List<String> parts = dateString.split('/');
    String formattedDate = '${parts[2]}-${parts[1]}-${parts[0]}';
    DateTime recordDate = DateTime.parse(formattedDate);
    attTypeValue = attendance.wfhFlag == "1" && attendance.activeFlag == "1"
        ? attTypelist.first
        : attTypelist.last;
    statusValue =
        attendance.wfhStatus == "1" ? statuslist.first : statuslist.last;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceService>(builder: (controller) {
      showDropdown(attTypeValue == "WFH" ? true : false);
      return Scaffold(
        appBar: AppBar(title: const Text("Attendance Report Edit")),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          CommonWidget.commonText("Employee Id"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _empIdController,
                            decoration:
                                CommonWidget.commonInput("Employee Id", true),
                            validator: (value) =>
                                CommonWidget.isEmpty(value, "Employee Id"),
                            onChanged: (value) => attendance.employeeId = value,
                          ),
                          const SizedBox(height: 15),
                          CommonWidget.commonText("Employee Name"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _empNameController,
                            decoration:
                                CommonWidget.commonInput("Employee Name", true),
                            validator: (value) =>
                                CommonWidget.isEmpty(value, "Employee Name"),
                            onChanged: (value) =>
                                attendance.employeeName = value,
                          ),
                          const SizedBox(height: 15),
                          CommonWidget.commonText("Date"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _dateController,
                            decoration: CommonWidget.commonInput(
                                _dateController.text, true),
                            validator: (value) =>
                                CommonWidget.isEmpty(value, "Record Date"),
                          ),
                          const SizedBox(height: 15),
                          CommonWidget.commonText("From Time"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _fromTimeController,
                            decoration: CommonWidget.timeInput(
                                context,
                                "From Time",
                                (time) => {
                                      setState(() {
                                        _fromTimeController.text =
                                            "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                        attendance.arrivalTime =
                                            _fromTimeController.text;
                                      }),
                                    },
                                CommonWidget.getTimeOfDayFromString(
                                    _fromTimeController.text)),
                            validator: (value) =>
                                CommonWidget.isEmpty(value, "From Time"),
                            onChanged: (v) {
                              attendance.arrivalTime = v;
                              _fromTimeController.text = v;
                            },
                          ),
                          const SizedBox(height: 15),
                          CommonWidget.commonText("To Time"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _toTimeController,
                            decoration: CommonWidget.timeInput(
                                context,
                                "To Time",
                                (time) => {
                                      setState(() {
                                        _toTimeController.text =
                                            "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                        attendance.leaveTime =
                                            _toTimeController.text;
                                      }),
                                    },
                                CommonWidget.getTimeOfDayFromString(
                                    _toTimeController.text)),
                            validator: (value) =>
                                CommonWidget.isEmpty(value, "To Time"),
                            onChanged: (v) {
                              attendance.leaveTime = v;
                              _toTimeController.text = v;
                            },
                          ),
                          const SizedBox(height: 15),
                          CommonWidget.commonText("Attendance Type"),
                          const SizedBox(height: 5),
                          DropdownButtonFormField<String>(
                            decoration: CommonWidget.commonInput(
                                "Attendance Type", false),
                            isExpanded: true,
                            value: attTypeValue,
                            items: attTypelist
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              showDropdown(newValue == "WFH");
                              setState(() {
                                attTypeValue = newValue!;
                                type = attTypeValue;
                              });
                            },
                          ),
                          showDropdown.isTrue
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 15),
                                    CommonWidget.commonText("Status"),
                                    const SizedBox(height: 5),
                                    DropdownButtonFormField<String>(
                                      decoration: CommonWidget.commonInput(
                                          "Status", false),
                                      isExpanded: true,
                                      value: statusValue,
                                      items: statuslist
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          statusValue = newValue!;
                                          status = newValue;
                                        });
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(height: 15),
                          CommonWidget.commonText("Description"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _descController,
                            maxLines: 3,
                            decoration:
                                CommonWidget.commonInput("Description", false),
                            onChanged: (value) =>
                                attendance.description = value,
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                DateTime now = DateTime.now();
                                DateTime fromTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    int.parse(
                                        _fromTimeController.text.split(":")[0]),
                                    int.parse(_fromTimeController.text
                                        .split(":")[1]));
                                DateTime toTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    int.parse(
                                        _toTimeController.text.split(":")[0]),
                                    int.parse(
                                        _toTimeController.text.split(":")[1]));
                                if (fromTime.isBefore(toTime)) {
                                  controller.updateAttendance(
                                      attendance, type, status);
                                  Get.to(() => const AttendanceHistory());
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: CommonWidget
                                                      .commonDialogTitle(
                                                          Colors.red),
                                                  child: const Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.0),
                                                      child: Text(
                                                        "Error!",
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 10.0),
                                                  child: Center(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Icon(Icons.warning,
                                                            size: 60,
                                                            color: Colors.red),
                                                        SizedBox(height: 8),
                                                        Text(
                                                            "From Time must be eariler than To Time",
                                                            style: TextStyle(
                                                                fontSize: 20))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 30),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          style: CommonWidget
                                                              .deleteButtonStyle(
                                                                  Colors.grey),
                                                          child: const Text(
                                                              "Close"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }
                              }
                            },
                            style: CommonWidget.primaryButtonStyle(),
                            child: const Text("Update"),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => const AttendanceHistory());
                            },
                            style: CommonWidget.secondaryButtonStyle(),
                            child: const Text("Back"),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
