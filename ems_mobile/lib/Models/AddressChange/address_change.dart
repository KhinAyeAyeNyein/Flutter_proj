import 'package:ems_mobile/Models/AddressChange/route.dart';

class AddressChange {
  int? addressChangeId;
  String employeeId;
  String employeeName;
  String? newAddress;
  String? address;
  String? startDate;
  String? requestDate;
  String? totalFees;
  String? status;
  String? remark;
  String? delFlag;
  List<dynamic>? route;

  AddressChange({
    this.addressChangeId,
    required this.employeeId,
    required this.employeeName,
    this.address,
    this.newAddress,
    this.startDate,
    this.requestDate,
    this.remark,
    this.totalFees,
    this.status,
    this.delFlag,
    this.route,
  });

  AddressChange.empty()
      : employeeId = "",
        employeeName = "",
        address = "",
        newAddress = "",
        startDate = "",
        totalFees = "",
        status = "",
        remark = "",
        delFlag = "0";

  factory AddressChange.fromJson(Map<String, dynamic> json) {
    return AddressChange(
        addressChangeId: json['addressChangeId'],
        employeeId: json['employeeId'],
        employeeName: json['employeeName'],
        newAddress: json['newAddress'],
        address: json['address'],
        startDate: json['startDate'],
        requestDate: json['requestDate'],
        totalFees: json['totalFees'],
        status: json['status'],
        remark: json['remark'] ?? "",
        route: json['routeList'],
        delFlag: json['delFlag']);
  }
  static Map<String, dynamic> toJson(AddressChange addressChange) {
    return {
      "employeeId": addressChange.employeeId,
      "employeeName": addressChange.employeeName,
      "address": addressChange.address,
      "startDate": addressChange.startDate,
      "totalFees": addressChange.totalFees,
      "newAddress": addressChange.newAddress,
      "remark": addressChange.remark,
      "routeList": addressChange.route,
      "delFlag": false,
    };
  }
}
