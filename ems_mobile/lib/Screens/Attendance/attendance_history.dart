import 'package:ems_mobile/Screens/Attendance/attendance_edit.dart';
import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/Attendance/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceHistory extends StatelessWidget {
  const AttendanceHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceService>(builder: (controller) {
      controller.getAttendance();

      String isAttendance(String active, String wfh) {
        bool _office = active == "1" ? true : false;
        bool _wfh = wfh == "1" ? true : false;
        if (_office && _wfh) {
          return "WFH";
        } else if (_office && !_wfh) {
          return "Office";
        } else {
          return "";
        }
      }

      return Obx(() => Scaffold(
            appBar: AppBar(
              title: const Text("Attendance History"),
            ),
            body: Container(
              decoration: CommonWidget.commonBackground(),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: controller.attendances.length,
                itemBuilder: (BuildContext context, index) {
                  final attendance = controller.attendances[index];
                  final isActive = attendance.activeFlag == "1";
                  final isWFH = isActive &&
                      isAttendance(
                              attendance.activeFlag!, attendance.wfhFlag!) ==
                          "WFH";
                  final isOffice = isActive &&
                      isAttendance(
                              attendance.activeFlag!, attendance.wfhFlag!) ==
                          "Office";
                  final isNotWFHApproved = attendance.wfhStatus != "2";
                  final isModify = isOffice || isWFH && isNotWFHApproved;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    elevation: 10,
                    borderOnForeground: true,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            if (isModify) {
                              Get.to(() =>
                                  AttendanceEditReport(attendance: attendance, attTypelist: controller.attendanceTypeList));
                            }
                          },
                          leading: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CommonWidget.commonLeftLeave(
                                  attendance.activeFlag == "0"
                                      ? ""
                                      : isWFH
                                          ? "WFH"
                                          : "Office",
                                ),
                                const SizedBox(height: 8),
                                attendance.wfhStatus != null
                                    ? CommonWidget.commonStatus(
                                        controller
                                            .status[attendance.wfhStatus!],
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                          title: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: CommonWidget.primaryColor,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        attendance.recordDate.toString(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: CommonWidget.primaryColor,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        attendance.arrivalTime == null
                                            ? ""
                                            : "${attendance.arrivalTime}~${attendance.leaveTime}",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.message,
                                        color: CommonWidget.primaryColor,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        controller
                                            .attendances[index].description
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: Colors.black, height: 0),
                        if (isModify)
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(bottom: 1),
                            width: 120,
                            child: MaterialButton(
                              onPressed: () {
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
                                                      "Delete WFH?",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0,
                                                        vertical: 10.0),
                                                child: Center(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(Icons.delete_forever,
                                                          size: 60,
                                                          color: Colors.red),
                                                      SizedBox(height: 8),
                                                      Text(
                                                          "Do you want to Delete?",
                                                          style: TextStyle(
                                                              fontSize: 20))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                        child:
                                                            const Text("Close"),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20),
                                                    Expanded(
                                                      flex: 1,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          controller
                                                              .deleteAttendance(
                                                                  attendance
                                                                      .attendanceRecordId!);
                                                          Get.back();
                                                        },
                                                        style: CommonWidget
                                                            .deleteButtonStyle(
                                                                Colors.red),
                                                        child: const Text(
                                                            "Delete"),
                                                      ),
                                                    )
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
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.delete_forever, color: Colors.red),
                                  Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  );
                },
              ),
            ),
          ));
    });
  }
}
