import 'package:ems_mobile/Models/AddressChange/route.dart';
import 'package:ems_mobile/Screens/AddressChange/address_change_report.dart';
import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/AddressChange/address_change_service.dart';
import 'package:ems_mobile/Services/Common/config.dart';
import 'package:ems_mobile/Services/Overtime/overtime_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteDialog extends StatefulWidget {
  @override
  State<RouteDialog> createState() => _RouteDialogState();
}

class _RouteDialogState extends State<RouteDialog> {
  final _formKey = GlobalKey<FormState>();

  final _fromInput = TextEditingController();
  final _toInput = TextEditingController();
  final _travelByInput = TextEditingController();
  final _feesInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['Bus', 'Taxi', 'Other'];

    RouteForm route = RouteForm(
        fromRoute: _fromInput.text,
        toRoute: _toInput.text,
        routeOrder: 0,
        fees: _feesInput.text == "" ? 0.0 : double.parse(_feesInput.text),
        travelBy: _travelByInput.text);
    String dropdownValue = list.first;
    return GetBuilder<AddressChangeService>(builder: (controller) {
      return Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: CommonWidget.softColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0))),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "Route Add",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.commonText("From"),
                        const SizedBox(height: 5),
                        TextFormField(
                            controller: _fromInput,
                            //initialValue: controller.routeController.fromRoute,
                            decoration: CommonWidget.commonInput("From", false),
                            validator: (value) =>
                                CommonWidget.isEmpty(value, "From"),
                            onChanged: (value) => {
                                  controller.routeController.fromRoute = value,
                                  route.fromRoute = value
                                }),
                        const SizedBox(height: 5),
                        CommonWidget.commonText("To"),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _toInput,
                          decoration: CommonWidget.commonInput("To", false),
                          validator: (value) =>
                              CommonWidget.isEmpty(value, "To"),
                          onChanged: (value) => {
                            controller.routeController.toRoute = value,
                            route.toRoute = value
                          },
                        ),
                        const SizedBox(height: 5),
                        CommonWidget.commonText("Travel By"),
                        const SizedBox(height: 5),
                        DropdownButtonFormField<String>(
                          decoration: CommonWidget.commonInput("Period", false),
                          isExpanded: true,
                          value: dropdownValue,
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // showDropdown(newValue == "bus");
                            setState(() {
                              dropdownValue = newValue!;
                              controller.travelBy.text = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 5),
                        CommonWidget.commonText("Fees"),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _feesInput,
                          keyboardType: TextInputType.number,
                          decoration: CommonWidget.commonInput("Fees", false),
                          validator: (value) =>
                              CommonWidget.isEmpty(value, "Fees"),
                          onChanged: (value) {
                            controller.routeController.fees =
                                value != "" ? double.parse(value) : 0.0;
                            route.fees = double.parse(value);
                          },
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
                            onPressed: () {
                              Get.back();
                            },
                            style: CommonWidget.secondaryButtonStyle(),
                            child: const Text("Close"),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                AddressChangeService().addRoute(route);
                              }
                            },
                            style: CommonWidget.primaryButtonStyle(),
                            child: const Text("Add Route"),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
          // title: Center(
          //   child: const Text("Route Add"),
          // ),
          // content:
        );
      });
    });
  }
}
