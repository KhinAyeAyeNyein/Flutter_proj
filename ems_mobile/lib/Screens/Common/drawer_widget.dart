import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Services/Common/config.dart';

class DrawerWidget extends StatelessWidget {
  final String employeeName;
  final Widget employeeProfile;

  const DrawerWidget(
      {super.key, required this.employeeName, required this.employeeProfile});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CommonWidget.lightColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: DrawerHeader(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                child: Container(
                    color: CommonWidget.primaryColor,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50.0, // adjust the radius as needed
                                child: ClipOval(
                                  child: employeeProfile,
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Text(
                                employeeName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ))
                            ]),
                      ],
                    )),
              )),
          Flexible(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            color: CommonWidget.lightColor,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Icon(
                              Icons.account_box,
                              color: CommonWidget.primaryColor,
                            ),
                          ),
                          Container(
                            color: CommonWidget.lightColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: const Text("Account",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )
                    ],
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Profile",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.profilePage);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Change password",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.changePasswordPage);
                    },
                  ),
                  const Divider(),
                  Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            color: CommonWidget.lightColor,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Icon(
                              Icons.add_box_rounded,
                              color: CommonWidget.primaryColor,
                            ),
                          ),
                          Container(
                            color: CommonWidget.lightColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: const Text("Requests",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )
                    ],
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Single leave request",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.singleLeaveRequestPage);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Long term request",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.longTermLeaveRequestPage);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Overtime request",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.overtimeRequestPage);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Attendance request",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.attendanceRequestPage);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Transportation request",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.transportationRequestPage);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Address change request",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.addressChangeRequestPage);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Daily temperature report",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.dailyTemperatureReportPage);
                    },
                  ),
                  const Divider(),
                  Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            color: CommonWidget.lightColor,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Icon(
                              Icons.list,
                              color: CommonWidget.primaryColor,
                            ),
                          ),
                          Container(
                            color: CommonWidget.lightColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: const Text("History",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )
                    ],
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Leave history",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.leaveHistoryPage);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Overtime history",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.overtimeHistoryPage);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Attendance history",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.attendanceHistoryPage);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Transportation history",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.transportationHistoryPage);
                    },
                  ),
                  ListTile(
                    dense: true,
                    title: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Address change history",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed(Config.addressChangeHistoryPage);
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
