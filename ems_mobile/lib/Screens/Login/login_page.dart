// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ems_mobile/Screens/Common/common_widget.dart';
import 'package:ems_mobile/Screens/Common/noti_bar.dart';
import 'package:ems_mobile/Services/Common/config.dart';
import 'package:ems_mobile/Services/Dashboard/dashboard_service.dart';
import 'package:ems_mobile/Services/Login/login_service.dart';
import 'package:ems_mobile/Services/Profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginService>(
      builder: (controller) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: controller.loginIdController.value,
                        decoration: CommonWidget.inputDecoration("Login ID"),
                        validator: (value) {
                          if (value == null) return "Login Id cannot be null!";
                          if (value.isEmpty) return "Login Id cannot be empty";
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controller.passwordController.value,
                        decoration: CommonWidget.passwordInputDecoration(
                          "Password",
                          controller.isSecurePassword.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          () => {
                            controller.isSecurePassword(
                                !controller.isSecurePassword.value)
                          },
                        ),
                        obscureText: controller.isSecurePassword.value,
                        validator: (value) {
                          if (value == null) return "Password cannot be null!";
                          if (value.isEmpty) return "Password cannot be empty";
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (controller.processingLogin.value) return;
                                if (_formKey.currentState!.validate()) {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  NotiBar.showSnackbar(context, "Logging In",
                                      "Please wait", ContentType.help);
                                  await Future.delayed(
                                      const Duration(seconds: 3));
                                  bool login = await controller.login();
                                  if (login) {
                                    DashboardService dashboard = Get.find();
                                    ProfileService profile = Get.find();
                                    profile.onInit();
                                    dashboard.onInit();
                                    Get.offNamed(Config.dashboardPage);
                                  } else {
                                    NotiBar.showSnackbar(
                                        context,
                                        "Login fails",
                                        controller.loginMessage.value,
                                        ContentType.failure);
                                  }
                                }
                              },
                              style: CommonWidget.primaryButtonStyle(),
                              child: Text("Login".toUpperCase()),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
