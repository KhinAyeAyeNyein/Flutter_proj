import 'dart:convert';

import 'package:ems_mobile/Models/Employee/employee.dart';
import 'package:ems_mobile/Services/Common/api_service.dart';
import 'package:ems_mobile/Services/Common/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ems_mobile/Services/Credential/credential.dart';

class ProfileService extends GetxController {
  final _loading = false.obs;
  var emp = Employee.empty().obs;
  ApiService api = ApiService();

  Employee get employee => emp.value;
  bool get isLoading => _loading.value;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  getProfile() async {
    if (await Credential.isLoggedIn()) {
      _loading(true);
      final response = await api.get("${Config.domainUrl}${Config.profile}");
      Map<String, dynamic> map = jsonDecode(response.body);
      emp.value = Employee.formJson(map["profileForm"]);
      _loading(false);
    }
  }

  Image commonImageWidget() => _loading.value ||
          employee.photo?.split("/").last == "null"
      ? Image.asset("assets/images/img_profile.jpg", width: 100, height: 100)
      : Image.network(employee.photo!, width: 100, height: 100);
}
