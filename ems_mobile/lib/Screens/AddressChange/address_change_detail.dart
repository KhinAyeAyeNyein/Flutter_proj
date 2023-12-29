import 'package:ems_mobile/Models/Overtime/overtime_model.dart';
import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/Overtime/overtime_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressChangeDetail extends StatefulWidget {
  final Overtime addressChange;
  final Map<String, dynamic> status;
  const AddressChangeDetail(
      {super.key, required this.addressChange, required this.status});

  @override
  State<AddressChangeDetail> createState() => _AddressChangeDetailState();
}

class _AddressChangeDetailState extends State<AddressChangeDetail> {
  late Overtime _overtime;
  late final Map<String, dynamic> _status;
  @override
  void initState() {
    super.initState();
    _overtime = widget.addressChange;
    _status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OvertimeService>(builder: (controller) {
      controller.getOvertimeList();
      return Scaffold(
        appBar: AppBar(title: const Text('Address Change Detail')),
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
                              "Address Change Detail Information"),
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
