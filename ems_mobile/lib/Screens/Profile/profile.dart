import 'package:ems_mobile/Screens/Common/common_widget.dart';
// import 'package:ems_mobile/Services/Common/config.dart';
import 'package:ems_mobile/Services/Profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileService>(builder: (controller) {
      return Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              actions: [
                PopupMenuButton(
                  icon: const Icon(Icons.settings),
                  tooltip: "Setting",
                  offset: const Offset(-50, 0),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        child: Text('Address Change'),
                      ),
                      const PopupMenuItem(
                        child: Text('Password Change'),
                      ),
                    ];
                  },
                  onSelected: (value) {},
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                  decoration: CommonWidget.commonBackground(),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              children: [
                                controller.commonImageWidget(),
                                const SizedBox(height: 5),
                                CommonWidget.profileTitle(
                                    controller.employee.employeeName ?? "-"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                CommonWidget.profileTitle("Detail Information"),
                                const SizedBox(height: 10),
                                Wrap(
                                  children: [
                                    CommonWidget.profileRow("Employee ID",
                                        controller.employee.employeeId ?? "-"),
                                    CommonWidget.profileRow(
                                        "Employee Name",
                                        controller.employee.employeeName ??
                                            "-"),
                                    CommonWidget.profileRow("Position",
                                        controller.employee.position ?? "-"),
                                    CommonWidget.profileRow(
                                        "Join Date",
                                        controller.employee.joinDate
                                                ?.toString() ??
                                            "-"),
                                    CommonWidget.profileRow("Company ",
                                        controller.employee.companyName ?? "-"),
                                    CommonWidget.profileRow("Card ID",
                                        controller.employee.cardId ?? "-"),
                                    CommonWidget.profileRow(
                                        "Department",
                                        controller.employee.departmentName ??
                                            "-"),
                                    CommonWidget.profileRow("Type",
                                        controller.employee.type ?? "-"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                CommonWidget.profileTitle(
                                    "Education Detail Information"),
                                const SizedBox(height: 10),
                                Wrap(
                                  children: [
                                    CommonWidget.profileRow("Language Skill",
                                        controller.employee.jlpt ?? "-"),
                                    CommonWidget.profileRow(
                                        "IQ Mark",
                                        controller.employee.iqTestRemark
                                                .toString()
                                                .isEmpty
                                            ? "-"
                                            : controller.employee.iqTestRemark
                                                .toString()),
                                    CommonWidget.profileRow(
                                        "Programming",
                                        controller.employee.languageSkill ??
                                            "-"),
                                    CommonWidget.profileRow(
                                        "Graduated University",
                                        controller
                                                .employee.graduateUniversity ??
                                            "-"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                CommonWidget.profileTitle(
                                    "Personal Detail Information"),
                                const SizedBox(height: 10),
                                Wrap(
                                  children: [
                                    CommonWidget.profileRow("DOB",
                                        controller.employee.dateOfBirth ?? "-"),
                                    CommonWidget.profileRow("NRC DOB",
                                        controller.employee.nrcDob ?? "-"),
                                    CommonWidget.profileRow("Gender",
                                        controller.employee.gender ?? "-"),
                                    CommonWidget.profileRow("NRC No.",
                                        controller.employee.nrc ?? "-"),
                                    CommonWidget.profileRow("Phone",
                                        controller.employee.phone ?? "-"),
                                    CommonWidget.profileRow("Email",
                                        controller.employee.email ?? "-"),
                                    CommonWidget.profileRow("BankAccount",
                                        controller.employee.bankAccount ?? "-"),
                                    CommonWidget.profileRow("SSB No.", "-"),
                                    CommonWidget.profileRow(
                                        "SSB Card Issue Date", "-"),
                                    CommonWidget.profileRow("Religion",
                                        controller.employee.religion ?? "-"),
                                    CommonWidget.profileRow("PC No.",
                                        controller.employee.pcNo ?? "-"),
                                    CommonWidget.profileRow("PC Password",
                                        controller.employee.pcPassword ?? "-"),
                                    CommonWidget.profileRow("MAC Address",
                                        controller.employee.macAddress ?? "-"),
                                    CommonWidget.profileRow(
                                        "Contact Name",
                                        controller.employee.contactPerson ??
                                            "-"),
                                    CommonWidget.profileRow(
                                        "Contact Phone",
                                        controller.employee.contactPhone ??
                                            "-"),
                                    CommonWidget.profileRow("Relation",
                                        controller.employee.relation ?? "-"),
                                    CommonWidget.profileRow("Address",
                                        controller.employee.address ?? "-"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ));
      });
    });
  }
}
