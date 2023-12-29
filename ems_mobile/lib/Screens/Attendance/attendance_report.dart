import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/Overtime/overtime_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({super.key});

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OvertimeService>(builder: (controller) {
      controller.overtimeRegister();
      return Obx(
        () => controller.isLoading
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(height: 30),
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
                                  readOnly: true,
                                  initialValue: controller.overtime.employeeId,
                                  decoration: CommonWidget.commonInput(
                                      "Employee Id", true),
                                  // validator: (value) => CommonWidget.isEmpty(
                                  //     value, "Employee Id"),
                                  //onChanged: (value) => controller.overtime.employeeName = value,
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("Employee Name"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  readOnly: true,
                                  initialValue:
                                      controller.overtime.employeeName,
                                  decoration: CommonWidget.commonInput(
                                      "Employee Name", true),
                                  //validator: (value) => CommonWidget.isEmpty(value),
                                  // onChanged: (value) =>
                                  //     controller.overtime.employeeName = value,
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("Date"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: controller.dateController,
                                  decoration: CommonWidget.dobDecoration(
                                      context,
                                      "Date",
                                      controller.dateController.text,
                                      (datetime) => {
                                            setState(() {
                                              controller.dateController.text =
                                                  datetime
                                                      .toString()
                                                      .split(" ")[0];
                                              controller.overtime.appliedDate =
                                                  controller
                                                      .dateController.text;
                                              // DateTime.parse(controller
                                              //     .dateController.text);
                                            })
                                          }),
                                  validator: (value) => CommonWidget.isEmpty(
                                      value, "Overtime Date"),
                                  onChanged: (v) {
                                    controller.overtime.appliedDate = v;
                                    // DateTime.parse(
                                    //     controller.dateController.text);
                                  },
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("From Time"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: controller.fromTimeController,
                                  readOnly: true,
                                  decoration: CommonWidget.timeInput(
                                      context,
                                      "From Time",
                                      (time) => {
                                            setState(() {
                                              controller
                                                      .fromTimeController.text =
                                                  "${time.hour}:${time.minute}";
                                            }),
                                          },
                                CommonWidget.getTimeOfDayFromString(
                                    controller.fromTimeController.text)),
                                  validator: (value) =>
                                      CommonWidget.isEmpty(value, "From Time"),
                                  onChanged: (v) {
                                    controller.overtime.fromTime = v;
                                    controller.fromTimeController.text = v;
                                  },
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("To Time"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: controller.toTimeController,
                                  readOnly: true,
                                  decoration: CommonWidget.timeInput(
                                      context,
                                      "To Time",
                                      (time) => {
                                            setState(() {
                                              controller.toTimeController.text =
                                                  "${time.hour}:${time.minute}";
                                            }),
                                          },
                                CommonWidget.getTimeOfDayFromString(
                                    controller.toTimeController.text)),
                                  validator: (value) =>
                                      CommonWidget.isEmpty(value, "To Time"),
                                  onChanged: (v) {
                                    controller.overtime.toTime = v;
                                    controller.toTimeController.text = v;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        bool request = await controller
                                            .overtimeRequest(true);
                                        if (request) {
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    child: Text("Show"),
                                    style: CommonWidget.secondaryButtonStyle(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
