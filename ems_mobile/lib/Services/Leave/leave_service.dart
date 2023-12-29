import 'dart:convert';

import 'package:ems_mobile/Models/Leave/leave.dart';
import 'package:ems_mobile/Services/Common/api_service.dart';
import 'package:ems_mobile/Services/Common/config.dart';
import 'package:get/get.dart';

class LeaveService extends GetxController {
  final _loading = false.obs;
  RxList<Leave> leaves = RxList<Leave>([]);
  RxMap<String, dynamic> remainLeave = RxMap<String, dynamic>();
  RxMap<String, dynamic> status = RxMap<String, dynamic>();
  ApiService api = ApiService();
  bool get isLoading => _loading.value;

  getLeave() async {
    _loading(true);
    final response = await api.get("${Config.domainUrl}${Config.leaveHistory}");
    Map<String, dynamic> map = jsonDecode(response.body);
    leaves.value = RxList<Leave>.from(
        (map["leaveRecordHistory"] as List).map((x) => Leave.fromJson(x)));
    remainLeave.value = map["remainLeaves"] as Map<String, dynamic>;
    status.value = map["status"] as Map<String, dynamic>;
    _loading(false);
  }
}
