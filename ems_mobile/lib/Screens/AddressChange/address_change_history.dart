import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/AddressChange/address_change_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressChangeHistory extends StatelessWidget {
  const AddressChangeHistory({super.key});

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.57;
    return GetBuilder<AddressChangeService>(builder: (controller) {
      controller.getAddressChangeList();
      return Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Address Change History"),
            backgroundColor: CommonWidget.primaryColor,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: CommonWidget.commonBackground(),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controller.addressChangeList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      //color: Colors.grey,
                      decoration: CommonWidget.commonBackground(),
                      // margin: const EdgeInsets.symmetric(
                      //     vertical: 10, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                  title: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_month,
                                                  color: CommonWidget
                                                      .primaryColor),
                                              const SizedBox(width: 8),
                                              Text(controller
                                                      .addressChangeList[index]
                                                      .startDate ??
                                                  ""),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.attach_money_outlined,
                                                  color: CommonWidget
                                                      .primaryColor),
                                              const SizedBox(width: 8),
                                              Container(
                                                  width: cWidth,
                                                  child: Text(
                                                    "${controller.addressChangeList[index].totalFees} Ks",
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.message,
                                                  color: CommonWidget
                                                      .primaryColor),
                                              const SizedBox(width: 8),
                                              Container(
                                                  width: cWidth,
                                                  child: Text(
                                                    "${controller.addressChangeList[index].remark} ",
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on,
                                                  color: CommonWidget
                                                      .primaryColor),
                                              const SizedBox(width: 8),
                                              Container(
                                                  width: cWidth,
                                                  child: Text(
                                                    controller
                                                            .addressChangeList[
                                                                index]
                                                            .newAddress ??
                                                        "",
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonWidget.commonStatus(
                                          controller.status[controller
                                              .addressChangeList[index].status])
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                      // );
                      //   },
                      // )
                    );
                  }),
            ),
          ),
        );
      });
    });
  }
}
