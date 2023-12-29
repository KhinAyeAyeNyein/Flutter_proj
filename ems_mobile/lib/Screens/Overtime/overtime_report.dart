import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/Overtime/overtime_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class OvertimeReport extends StatefulWidget {
  const OvertimeReport({super.key});

  @override
  State<OvertimeReport> createState() => _OvertimeReportState();
}

class _OvertimeReportState extends State<OvertimeReport> {
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
                                  initialValue:
                                      controller.overtime.employeeName,
                                  decoration: CommonWidget.commonInput(
                                      "Employee Name", true),
                                  //validator: (value) => CommonWidget.isEmpty(value),
                                  // onChanged: (value) =>
                                  //     controller.overtime.employeeName = value,
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("Department Name"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  readOnly: true,
                                  initialValue:
                                      controller.overtime.employeeName,
                                  decoration: CommonWidget.commonInput(
                                      "Department Name", true),
                                  //validator: (value) => CommonWidget.isEmpty(value),
                                  onChanged: (value) =>
                                      controller.overtime.appliedDate = value,
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("Overtime Date"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: controller.dateController,
                                  decoration: CommonWidget.dobDecoration(
                                      context,
                                      "Overtime Date",
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
                                              final hour = time.hour
                                                  .toString()
                                                  .padLeft(2, '0');
                                              final minute = time.minute
                                                  .toString()
                                                  .padLeft(2, '0');
                                              controller.fromTimeController
                                                  .text = "$hour:$minute";
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
                                const SizedBox(height: 15),
                                CommonWidget.commonText("OT Hour"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: controller.otHourController,
                                  readOnly: true,
                                  enabled: false,
                                  //initialValue: "0.0",
                                  decoration:
                                      CommonWidget.commonInput("OT Hour", true),
                                  validator: (value) =>
                                      CommonWidget.isEmpty(value, ""),
                                  // onChanged: (value) =>
                                  //     controller.overtime.employeeName = value,
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("Description"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue: controller.overtime.description,
                                  maxLines: 3,
                                  decoration: CommonWidget.commonInput(
                                      "Description", false),
                                  validator: (value) => CommonWidget.isEmpty(
                                      value, "Description"),
                                  onChanged: (value) =>
                                      controller.overtime.description = value,
                                ),
                              ],
                            ),
                            // CommonWidget.commonInputwithTitle(
                            //     "Employee Name", _form.employeeName),
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
                                    style: CommonWidget.secondaryButtonStyle(),
                                    child: const Text("Save"),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        bool request = await controller
                                            .overtimeRequest(false);
                                        if (request) {
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    child: Text("Request"),
                                    style: CommonWidget.primaryButtonStyle(),
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
              ),
      );
    });
  }
}
