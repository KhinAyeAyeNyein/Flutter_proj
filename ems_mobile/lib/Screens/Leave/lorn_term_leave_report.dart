import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/Overtime/overtime_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class LongTermLeaveReport extends StatefulWidget {
  const LongTermLeaveReport({super.key});

  @override
  State<LongTermLeaveReport> createState() => _LongTermLeaveReportState();
}

class _LongTermLeaveReportState extends State<LongTermLeaveReport> {
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
                                CommonWidget.commonText("Leave Type"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  readOnly: true,
                                  initialValue:
                                      controller.overtime.employeeName,
                                  decoration:
                                      CommonWidget.commonInput("TBD", true),
                                  //validator: (value) => CommonWidget.isEmpty(value),
                                  onChanged: (value) =>
                                      controller.overtime.appliedDate = value,
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("Request Date"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: controller.dateController,
                                  decoration: CommonWidget.dobDecoration(
                                      context,
                                      "Request Date",
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
                                  validator: (value) =>
                                      CommonWidget.isEmpty(value, "Request Date"),
                                  onChanged: (v) {
                                    controller.overtime.appliedDate = v;
                                    // DateTime.parse(
                                    //     controller.dateController.text);
                                  },
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("From Date"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: controller.dateController,
                                  decoration: CommonWidget.dobDecoration(
                                      context,
                                      "From Date",
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
                                  validator: (value) =>
                                      CommonWidget.isEmpty(value, "From Date"),
                                  onChanged: (v) {
                                    controller.overtime.appliedDate = v;
                                    // DateTime.parse(
                                    //     controller.dateController.text);
                                  },
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("To Date"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: controller.dateController,
                                  decoration: CommonWidget.dobDecoration(
                                      context,
                                      "To Date",
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
                                  validator: (value) =>
                                      CommonWidget.isEmpty(value, "To Date"),
                                  onChanged: (v) {
                                    controller.overtime.appliedDate = v;
                                    // DateTime.parse(
                                    //     controller.dateController.text);
                                  },
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("Leave Reason"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue: controller.overtime.description,
                                  maxLines: 3,
                                  decoration: CommonWidget.commonInput(
                                      "Leave Reason", false),
                                  validator: (value) => CommonWidget.isEmpty(
                                      value, "Leave Reason"),
                                  onChanged: (value) =>
                                      controller.overtime.description = value,
                                ),
                                const SizedBox(height: 15),
                                CommonWidget.commonText("Attach File"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  readOnly: true,
                                  onTap: () async {
                                    await CommonWidget.pickFile();
                                  },
                                  initialValue:"",
                                  decoration: CommonWidget.commonAttachmentFile(),
                                  //validator: (value) => CommonWidget.isEmpty(value),
                                  onChanged: (value) =>
                                      controller.overtime.appliedDate = value,
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
                                    style: CommonWidget.secondaryButtonStyle(),
                                    child: const Text("Show"),
                                  ),
                                ),
                                // const SizedBox(width: 20),
                                // Expanded(
                                //   flex: 1,
                                //   child: ElevatedButton(
                                //     onPressed: () async {
                                //       if (_formKey.currentState!.validate()) {
                                //         bool request = await controller
                                //             .overtimeRequest(false);
                                //         if (request) {
                                //           Navigator.pop(context);
                                //         }
                                //       }
                                //     },
                                //     style: CommonWidget.primaryButtonStyle(),
                                //     child: const Text("Request"),
                                //   ),
                                // )
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
