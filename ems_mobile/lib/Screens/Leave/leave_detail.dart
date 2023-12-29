import 'package:ems_mobile/Models/Leave/leave.dart';
import 'package:ems_mobile/Screens/Common/common_widget.dart';
// import 'package:ems_mobile/Services/Common/config.dart';
import 'package:ems_mobile/Services/Profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveDetail extends StatefulWidget {
  final Leave leave;
  final Map<String, dynamic> status;
  const LeaveDetail({super.key, required this.leave, required this.status});

  @override
  State<LeaveDetail> createState() => _LeaveDetailState();
}

class _LeaveDetailState extends State<LeaveDetail> {
  late Leave _leave;
  late final Map<String, dynamic> _status;
  @override
  void initState() {
    super.initState();
    _leave = widget.leave;
    _status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileService>(builder: (controller) {
      controller.getProfile();
      return Scaffold(
        appBar: AppBar(title: const Text('Leave Detail')),
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
                          CommonWidget.profileTitle("Leave Detail Information"),
                          const SizedBox(height: 10),
                          Wrap(
                            children: [
                              CommonWidget.profileRow(
                                  "Employee ID", _leave.employeeId.toString()),
                              CommonWidget.profileRow("Employee Name",
                                  _leave.employeeName.toString()),
                              CommonWidget.profileRow("Department",
                                  _leave.departmentName.toString()),
                              CommonWidget.profileRow("Approved Date",
                                  _leave.approvedDate.toString()),
                              CommonWidget.profileRow("Requested Date",
                                  _leave.requestedDate.toString()),
                              CommonWidget.profileRow(
                                  "Leave Date", _leave.leaveDate.toString()),
                              CommonWidget.profileRow(
                                  "Total Day", "${_leave.totalDays} D"),
                              CommonWidget.profileRow(
                                  "Leave Type", _leave.leaveType.toString()),
                              CommonWidget.profileRow(
                                  "Status", _status[_leave.leaveDetailStatus]),
                              CommonWidget.profileRow("Leave Reason",
                                  _leave.description.toString()),
                              CommonWidget.profileRow(
                                  "Remark", _leave.remark.toString()),
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
