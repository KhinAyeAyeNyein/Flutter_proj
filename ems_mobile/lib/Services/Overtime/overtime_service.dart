import 'dart:convert';

import 'package:ems_mobile/Models/Overtime/overtime_model.dart';
import 'package:ems_mobile/Services/Common/api_service.dart';
import 'package:ems_mobile/Services/Common/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OvertimeService extends GetxController {
  final _overtime = Overtime.empty().obs;
  RxList<Overtime> overtimeList = RxList<Overtime>([]);
  RxMap<String, dynamic> status = RxMap<String, dynamic>();
  final _dateController = TextEditingController().obs;
  final _fromTimeController = TextEditingController().obs;
  final _toTimeController = TextEditingController().obs;
  final _otHourController = TextEditingController().obs;
  final _isloading = false.obs;

  TextEditingController get dateController => _dateController.value;
  TextEditingController get fromTimeController => _fromTimeController.value;
  TextEditingController get toTimeController => _toTimeController.value;
  TextEditingController get otHourController => _otHourController.value;
  Overtime get overtime => _overtime.value;
  // RxList<Overtime> get overtimeList => _overtimeList.value;
  bool get isLoading => _isloading.value;

  ApiService api = ApiService();

  Future<void> overtimeRegister() async {
    _dateController.value.text = DateTime.now().toString().split(" ")[0];
    _overtime.value.appliedDate = DateTime.now().toString().split(" ")[0];
    _isloading(true);
    final response =
        await api.get("${Config.domainUrl}${Config.overtimeRegist}");
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    //_overtime.value =
    _overtime.value = Overtime.fromJson(jsonResponse["overtimeRequest"]);
    var fromTime = _fromTimeController.value.text;
    var toTime = _toTimeController.value.text;
    _calculateOtHour(fromTime, toTime);
    _isloading(false);
  }

  Future<bool> overtimeRequest(isSave) async {
    var param = isSave ? "save" : "request";
    final response = await api.post(
        "${Config.domainUrl}${Config.overtimeRegist}?request=$param",
        Overtime.toJson(overtime));
    if (response.statusCode == 200) return true;
    return false;
  }

  getOvertimeList() async {
    _isloading(true);
    final response =
        await api.get("${Config.domainUrl}${Config.overtimeHistory}");
    Map<String, dynamic> map = jsonDecode(response.body);
    overtimeList.value = RxList<Overtime>.from(
        (map["overtimeRecordHistory"] as List)
            .map((x) => Overtime.fromJson(x)));
    status.value = map["status"] as Map<String, dynamic>;
    _isloading(false);
  }

  _calculateOtHour(fromTime, toTime) {
    if ((fromTime != null && toTime != null) &&
        (fromTime != "" && toTime != "")) {
      String fTime =
          (double.parse(fromTime.split(":")[1]) / 60).toString().split(".")[1];
      String tTime =
          (double.parse(toTime.split(":")[1]) / 60).toString().split(".")[1];

      double timeFrom = double.parse("${fromTime.split(":")[0]}.$fTime");
      double timeTo = double.parse("${toTime.split(":")[0]}.$tTime");
      _otHourController.value.text = (timeTo - timeFrom).toString();
    } else {
      _otHourController.value.text = "0.0";
    }
  }
}
