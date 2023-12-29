import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Screens/Overtime/overtime_detail.dart';
import 'package:ems_mobile/Services/Overtime/overtime_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OvertimeHistory extends StatelessWidget {
  const OvertimeHistory({super.key});

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.42;
    return GetBuilder<OvertimeService>(builder: (controller) {
      controller.getOvertimeList();
      return Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Overtime History"),
            backgroundColor: CommonWidget.primaryColor,
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: CommonWidget.commonBackground(),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.overtimeList.length,
                      itemBuilder: (BuildContext context, index) {
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
                                Get.to(() => OvertimeDetail(
                                    overtime: controller.overtimeList[index],
                                    status: controller.status));
                              },
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CommonWidget.commonLeftLeave(
                                      "${controller.overtimeList[index].otHour} hrs"),
                                ],
                              ),
                              title: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_month,
                                              color: CommonWidget.primaryColor),
                                          const SizedBox(width: 8),
                                          Text(
                                              "${controller.overtimeList[index].appliedDate}"),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.access_time_outlined,
                                              color: CommonWidget.primaryColor),
                                          const SizedBox(width: 8),
                                          Text(
                                              "${controller.overtimeList[index].fromTime} ~ ${controller.overtimeList[index].toTime}"),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.message,
                                              color: CommonWidget.primaryColor),
                                          const SizedBox(width: 8),
                                          Container(
                                              width: cWidth,
                                              child: Text(
                                                "${controller.overtimeList[index].description}",
                                                textAlign: TextAlign.left,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonWidget.commonStatus(controller.status[
                                      controller
                                          .overtimeList[index].overTimeStatus])
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
              // );
              //   },
              // )
            ),
          ),
        );
      });
    });
  }
}
