import 'dart:convert';

import 'package:ems_mobile/Models/Auth/user.dart';

class AuthResponse{
  double? timestamp;
  int? responseCode;
  String? responseDescription;
  String? token;
  User? userInformation;

  AuthResponse(
  {
    this.timestamp,
    this.responseCode,
    this.responseDescription, 
    this.token, 
    this.userInformation
  }
  );
  factory AuthResponse.successJson(Map<String, dynamic> json){
    return AuthResponse(
          timestamp: json['timestamp'],
          responseCode: json['responseCode'],
          responseDescription: json['responseDescription'],
          token: json['token'],
          userInformation: User.fromJson(json['userInfomation'])
        );
  }
  factory AuthResponse.failJson(Map<String, dynamic> json) {
    return AuthResponse(
        timestamp: json['timestamp'],
        responseCode: json['responseCode'],
        responseDescription: json['responseDescription']);
  }
  @override
  String toString() {
    return jsonEncode({
      "timestamp": timestamp,
      "responseCode": responseCode,
      "responseDescription": responseDescription,
      "token": token,
      "userInformation": userInformation.toString()
    });
  }
}