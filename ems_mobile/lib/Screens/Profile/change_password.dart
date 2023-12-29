import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Services/Profile/change_password_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final ChangePasswordService controller = Get.put(ChangePasswordService());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordService>(
      builder: (c) {
        return Obx(() => Scaffold(
            backgroundColor: CommonWidget.lightColor,
              appBar: AppBar(
                backgroundColor: CommonWidget.primaryColor,
                title: const Text("Change Password"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: _formKey,
                            child: Column(children: [
                              TextFormField(
                                controller:
                                    controller.currentPasswordController,
                                obscureText: controller.isSecureCP.value,
                                decoration:
                                    CommonWidget.passwordInputDecoration(
                                        "Current Password",
                                        controller.isSecureCP.value
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                        () => {
                                              controller.isSecureCP.value =
                                                  !controller.isSecureCP.value
                                            }),
                                validator: (value) =>
                                    CommonWidget.validatePassword(
                                        value, "Current password"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: controller.newPasswordController,
                                obscureText: controller.isSecureNP.value,
                                decoration:
                                    CommonWidget.passwordInputDecoration(
                                        "New Password",
                                        controller.isSecureNP.value
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                        () => controller.isSecureNP.value =
                                            !controller.isSecureNP.value),
                                validator: (value) =>
                                    CommonWidget.validatePassword(
                                        value, "New Password"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller:
                                    controller.confirmPasswordController,
                                obscureText: controller.isSecureCMP.value,
                                decoration:
                                    CommonWidget.passwordInputDecoration(
                                        "Confirm Password",
                                        controller.isSecureCMP.value
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                        () => controller.isSecureCMP.value =
                                            !controller.isSecureCMP.value),
                                validator: (value) =>
                                    CommonWidget.validateAndComparePassword(
                                        value,
                                        controller.newPasswordController.text),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                          style:
                                              CommonWidget.primaryButtonStyle(),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              controller.changePassword();
                                            }
                                          },
                                          child:
                                              const Text("Change Password"))),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: TextButton(
                                          onPressed: () {Get.back();},
                                          child: const Text("Cancel"))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
