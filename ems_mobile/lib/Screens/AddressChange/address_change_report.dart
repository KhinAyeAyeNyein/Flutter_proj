import 'package:ems_mobile/Models/AddressChange/address_change.dart';
import 'package:ems_mobile/Screens/AddressChange/route_dialog.dart';
import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/AddressChange/address_change_service.dart';
import 'package:ems_mobile/Services/Overtime/overtime_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddressChangeRequest extends StatefulWidget {
  // final AddressChange data;
  // const AddressChangeRequest({super.key, required this.data});
  @override
  State<AddressChangeRequest> createState() => _AddressChangeRequestState();
}

class _AddressChangeRequestState extends State<AddressChangeRequest> {
  final _formKey = GlobalKey<FormState>();
  // late AddressChange addressChange;
  final String _today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final _employeeId = TextEditingController();
  final _employeeName = TextEditingController();
  final _address = TextEditingController();
  final _newAddress = TextEditingController();
  final _startDate = TextEditingController();
  final _requestDate = TextEditingController();
  final _fees = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddressChange addressChangeData = AddressChange(
      employeeId: _employeeId.text,
      employeeName: _employeeName.text,
      address: _address.text,
      newAddress: _newAddress.text,
      startDate: _startDate.text != ""
          ? CommonWidget.YMDtoDMY(_startDate.text)
          : _startDate.text,
      requestDate: CommonWidget.YMDtoDMY(_today),
      totalFees: _fees.text,
    );
    return GetBuilder<AddressChangeService>(builder: (controller) {
      controller.addressChangeRegister();
      return Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        _employeeId.text = controller.addressChange.employeeId;
        _employeeName.text = controller.addressChange.employeeName;
        _address.text = controller.addressChange.address!;
        _fees.text = controller.totalFees.text;
        addressChangeData.route = controller.routes;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Address Change Registration"),
            backgroundColor: CommonWidget.primaryColor,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        CommonWidget.commonText("Employee Id"),
                        const SizedBox(height: 5),
                        TextFormField(
                          readOnly: true,
                          controller: _employeeId,
                          // initialValue:
                          //     controller.addressChange.employeeId,
                          decoration:
                              CommonWidget.commonInput("Employee Id", true),
                        ),
                        const SizedBox(height: 15),
                        CommonWidget.commonText("Employee Name"),
                        const SizedBox(height: 5),
                        TextFormField(
                          readOnly: true,
                          controller: _employeeName,
                          // initialValue:
                          //     controller.addressChange.employeeName,
                          decoration:
                              CommonWidget.commonInput("Employee Name", true),
                          //validator: (value) => CommonWidget.isEmpty(value),
                          // onChanged: (value) =>
                          //     controller.overtime.employeeName = value,
                        ),
                        const SizedBox(height: 15),
                        CommonWidget.commonText("Address"),
                        const SizedBox(height: 5),
                        TextFormField(
                          readOnly: true,
                          controller: _address,
                          // initialValue: controller.addressChange.address,
                          decoration: CommonWidget.commonInput("Address", true),
                          //validator: (value) => CommonWidget.isEmpty(value),
                          // onChanged: (value) =>
                          //     controller.overtime.appliedDate = value,
                        ),
                        const SizedBox(height: 15),
                        CommonWidget.commonText("New Address"),
                        const SizedBox(height: 5),
                        TextFormField(
                          decoration:
                              CommonWidget.commonInput("New Address", false),
                          controller: _newAddress,
                          //validator: (value) => CommonWidget.isEmpty(value),
                          // onChanged: (value) =>
                          //     controller.overtime.appliedDate = value,
                        ),
                        const SizedBox(height: 15),
                        CommonWidget.commonText("Start Date"),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _startDate,
                          decoration: CommonWidget.dobDecoration(
                              context,
                              "Start Date",
                              controller.dateController.text,
                              (datetime) => {
                                    setState(() {
                                      controller.dateController.text =
                                          datetime.toString().split(" ")[0];
                                      controller.addressChange.startDate =
                                          controller.dateController.text;
                                      _startDate.text = DateFormat('yyyy-MM-dd')
                                          .format(datetime);
                                      DateTime.parse(
                                          controller.dateController.text);
                                    })
                                  }),
                          validator: (value) =>
                              CommonWidget.isEmpty(value, "Start Date"),
                          onChanged: (v) {
                            controller.addressChange.startDate = v;
                            DateTime.parse(controller.dateController.text);
                          },
                        ),
                        const SizedBox(height: 15),
                        CommonWidget.commonText("Request Date"),
                        const SizedBox(height: 5),
                        TextFormField(
                          readOnly: true,
                          initialValue: _today,
                          decoration: CommonWidget.commonInput("", true),
                        ),
                        const SizedBox(height: 15),
                        CommonWidget.commonText("Total Fees"),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _fees,
                          readOnly: true,
                          enabled: false,
                          decoration:
                              CommonWidget.commonInput("Total Fees", true),
                          validator: (value) => CommonWidget.isEmpty(value, ""),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Address Change Route Information",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: CommonWidget.primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.routes.length,
                            itemBuilder: (BuildContext context, i) {
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CommonWidget.commonText(
                                                "${controller.routes[i].fromRoute} -> ${controller.routes[i].toRoute}"),
                                            PopupMenuButton(
                                              icon: const Icon(Icons.more_vert),
                                              tooltip: "Setting",
                                              offset: const Offset(50, 35),
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return [
                                                  const PopupMenuItem(
                                                    child: Text('Edit'),
                                                  ),
                                                  const PopupMenuItem(
                                                    child: Text('Delete'),
                                                  ),
                                                ];
                                              },
                                              onSelected: (value) {},
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(controller.routes[i].travelBy),
                                            Column(
                                              children: [
                                                const Text("Fees"),
                                                Text(
                                                    "${controller.routes[i].fees}")
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return RouteDialog();
                                      });
                                },
                                style: CommonWidget.primaryButtonStyle(),
                                child: const Text("Add Route"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    bool request =
                                        await controller.addressChangeRequest(
                                            addressChangeData, true);
                                    if (request) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                style: CommonWidget.primaryButtonStyle(),
                                child: const Text("Save"),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: CommonWidget.primaryButtonStyle(),
                                child: const Text("Reset"),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    bool request =
                                        await controller.addressChangeRequest(
                                            addressChangeData, false);
                                    if (request) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                style: CommonWidget.primaryButtonStyle(),
                                child: const Text("Request"),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
