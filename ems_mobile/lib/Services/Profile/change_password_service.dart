import 'dart:convert';

import 'package:ems_mobile/Models/Employee/employee.dart';
import 'package:ems_mobile/Services/Common/api_service.dart';
import 'package:ems_mobile/Services/Common/config.dart';
import 'package:ems_mobile/Services/Credential/credential.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordService extends GetxController{
  final _currentPasswordController = TextEditingController().obs;
  final _newPasswordController = TextEditingController().obs;
  final _confirmPasswordController = TextEditingController().obs;
  var isSecureCP = true.obs;
  var isSecureNP = true.obs;
  var isSecureCMP = true.obs;
  Credential? credential;
  String? employeeId = "";

  late ApiService api;

  TextEditingController get currentPasswordController => _currentPasswordController.value;
  TextEditingController get newPasswordController => _newPasswordController.value;
  TextEditingController get confirmPasswordController => _confirmPasswordController.value;

  Future<bool> changePassword() async{
    Employee employee = Employee.empty();
    employee.employeeId=employeeId;
    employee.password = currentPasswordController.text;
    employee.newPassword = newPasswordController.text;
    employee.confirmPassword = confirmPasswordController.text;
    final response = await api.post("${Config.domainUrl}${Config.changePassword}", employee.toJson());
    if(response.statusCode == 503){
      return false;
    }
    Map<String, dynamic> map = jsonDecode(response.body);
    if (map["responseCode"] != 200 && response.statusCode != 200) {
      return false;
    }else{
      return true;
    }
  }
}