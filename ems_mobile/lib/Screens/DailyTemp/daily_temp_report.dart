import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:flutter/material.dart';

class DailyTempReport extends StatelessWidget {
  DailyTempReport({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Temperature Report"),
        backgroundColor: CommonWidget.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: CommonWidget.commonBackground(),
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.square, color: Colors.green, shadows: [
                        Shadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                            offset: Offset.infinite),
                      ]),
                      const SizedBox(width: 20),
                      CommonWidget.commonText("Normal"),
                    ],
                  ),
                  const SizedBox(width: 20),
                  CommonWidget.commonText("(34°C ~ 37.5°C/93°F ~ 99°F)"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.square,
                          color: Color.fromARGB(255, 249, 168, 37),
                          shadows: [
                            Shadow(
                                color: Colors.black,
                                blurRadius: 1.0,
                                offset: Offset.infinite)
                          ]),
                      const SizedBox(width: 20),
                      CommonWidget.commonText("Slight Fever"),
                    ],
                  ),
                  const SizedBox(width: 20),
                  CommonWidget.commonText("(37.6°C ~ 38°C/99.1°F ~ 100°F)"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.square, color: Colors.red, shadows: [
                        Shadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                            offset: Offset.infinite)
                      ]),
                      const SizedBox(width: 20),
                      CommonWidget.commonText("Fever"),
                    ],
                  ),
                  const SizedBox(width: 20),
                  CommonWidget.commonText("(38.1°C ~ 42°C/100.1°F ~ 108°F)"),
                ],
              ),
              const SizedBox(height: 10),
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
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Khin Aye Aye Nyein",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "21/04/2023",
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          const Text("Temperature"),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: CommonWidget.commonInput(
                                      "Temperature", false),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Flexible(
                                child: TextFormField(
                                  decoration:
                                      CommonWidget.commonInput("Choose", false),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          const Text("Description"),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            decoration:
                                CommonWidget.commonInput("Description", false),
                          ),
                          const SizedBox(height: 8.0),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: CommonWidget.primaryButtonStyle(),
                              child: const Text("Save"),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ],
          ),
          // );
          //   },
          // )
        ),
      ),
    );
  }
}
