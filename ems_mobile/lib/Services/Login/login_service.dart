
import 'dart:convert';

import 'package:ems_mobile/Models/Auth/auth_response.dart';
import 'package:ems_mobile/Services/Common/api_service.dart';
import 'package:ems_mobile/Services/Common/config.dart';
import 'package:ems_mobile/Services/Credential/credential.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginService extends GetxController{

  Credential? _credential;
  ApiService api = ApiService();
  var isLoadingCredential = false.obs;

  var loginIdController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var isSecurePassword = true.obs;

  var processingLogin = false.obs;
  var loginSuccess = false.obs;
  var showSnackbar = false.obs;
  var loginMessage = "".obs;

  Credential? get credential => _credential;

  Future<bool> login() async {
    processingLogin(true);
    showSnackbar(true);
    final response = await api.post("${Config.domainUrl}${Config.login}", {
      "loginId" : loginIdController.value.text,
      "password" : passwordController.value.text
    });
    processingLogin(false);
    if(response.statusCode == 503){
      loginSuccess(false);
      loginMessage("Enable to fetch the api!");
      return false;
    }
    final body = response.body;
    AuthResponse authResponse = AuthResponse.successJson(jsonDecode(body));
    if(authResponse.responseCode != 200){
      loginSuccess(false);
      showSnackbar(true);
      loginMessage(authResponse.responseDescription);
      return false;
    }
    Credential.setCredential(authResponse);
    loginSuccess(true);
    showSnackbar(false);
    return true;
  }

}