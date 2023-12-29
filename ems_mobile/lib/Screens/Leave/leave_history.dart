import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Screens/Leave/leave_detail.dart';
import 'package:ems_mobile/Services/Leave/leave_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveHistory extends StatelessWidget {
  const LeaveHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveService>(builder: (controller) {
      controller.getLeave();
      return Obx(
        () => Scaffold(
          appBar: AppBar(
            title: const Text("Leave History"),
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: CommonWidget.commonBackground(),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonWidget.commonLeftLeave("Annual Leave"),
                      CommonWidget.commonLeftLeave("Sick Leave"),
                      CommonWidget.commonLeftLeave("Casual Leave")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonWidget.commonLeftLeave(
                          "(${controller.remainLeave["Annual"]})"),
                      CommonWidget.commonLeftLeave(
                          "(${controller.remainLeave["Sick"]})"),
                      CommonWidget.commonLeftLeave(
                          "(${controller.remainLeave["Casual"]})")
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.leaves.length,
                    itemBuilder: (BuildContext context, index) {
                      final leave = controller.leaves[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0XFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 3,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                              onTap: () {
                                Get.to(() => LeaveDetail(
                                      leave: leave,
                                      status: controller.status,
                                    ));
                              },
                              leading: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonWidget.commonLeftLeave(
                                        "${leave.totalDays} D"),
                                    CommonWidget.profileTitle(
                                        leave.leaveType.toString()),
                                  ],
                                ),
                              ),
                              title: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_month,
                                                color:
                                                    CommonWidget.primaryColor),
                                            const SizedBox(width: 8),
                                            Text(leave.leaveDate.toString()),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(Icons.message,
                                                color:
                                                    CommonWidget.primaryColor),
                                            const SizedBox(width: 8),
                                            Text(leave.description.toString()),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              trailing: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonWidget.commonStatus(controller
                                        .status[leave.leaveDetailStatus])
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
