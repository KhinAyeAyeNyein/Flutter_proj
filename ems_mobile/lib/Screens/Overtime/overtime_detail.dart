import 'package:ems_mobile/Models/Overtime/overtime_model.dart';
import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/Overtime/overtime_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OvertimeDetail extends StatefulWidget {
  final Overtime overtime;
  final Map<String, dynamic> status;
  const OvertimeDetail(
      {super.key, required this.overtime, required this.status});

  @override
  State<OvertimeDetail> createState() => _OvertimeDetailState();
}

class _OvertimeDetailState extends State<OvertimeDetail> {
  late Overtime _overtime;
  late final Map<String, dynamic> _status;
  @override
  void initState() {
    super.initState();
    _overtime = widget.overtime;
    _status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OvertimeService>(builder: (controller) {
      controller.getOvertimeList();
      return Scaffold(
        appBar: AppBar(title: const Text('Overtime Detail')),
        body: Container(
            decoration: CommonWidget.commonBackground(),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          CommonWidget.profileTitle(
                              "Overtime Detail Information"),
                          const SizedBox(height: 10),
                          Wrap(
                            children: [
                              CommonWidget.profileRow("Employee ID",
                                  _overtime.employeeId.toString()),
                              CommonWidget.profileRow("Employee Name",
                                  _overtime.employeeName.toString()),
                              CommonWidget.profileRow("Department",
                                  _overtime.departmentName.toString()),
                              CommonWidget.profileRow("Overtime Date",
                                  _overtime.appliedDate.toString()),
                              CommonWidget.profileRow("Requested Date",
                                  _overtime.requestDate.toString()),
                              CommonWidget.profileRow("Approved Date",
                                  _overtime.approvedDate.toString()),
                              CommonWidget.profileRow(
                                  "Start Time", "${_overtime.fromTime} "),
                              CommonWidget.profileRow(
                                  "To Time", "${_overtime.toTime} "),
                              CommonWidget.profileRow(
                                  "OT Hour", _overtime.otHour.toString()),
                              CommonWidget.profileRow(
                                  "Status", _status[_overtime.overTimeStatus]),
                              CommonWidget.profileRow("Description",
                                  _overtime.description.toString()),
                              CommonWidget.profileRow(
                                  "Remark", _overtime.remark.toString()),
                              CommonWidget.profileRow("Compensatory",
                                  _overtime.compensatoryFlag.toString()),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      );
    });
  }
}
