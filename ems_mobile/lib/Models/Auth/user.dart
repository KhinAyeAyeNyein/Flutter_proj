import 'dart:convert';

class User {
  final String employeeId;
  final String employeeName;
  final int employeeType;
  const User(
      {required this.employeeId,
      required this.employeeName,
      required this.employeeType});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        employeeId: json['employeeId'],
        employeeName: json['employeeName'],
        employeeType: json['employeeType']);
  }
  @override
  String toString() {
    return jsonEncode({
      "employeeId": employeeId,
      "employeeName": employeeName,
      "employeeType": employeeType
    });
  }
}