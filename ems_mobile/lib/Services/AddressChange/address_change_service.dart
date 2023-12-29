import 'dart:convert';

import 'package:ems_mobile/Models/AddressChange/address_change.dart';
import 'package:ems_mobile/Models/AddressChange/route.dart';
import 'package:ems_mobile/Services/Common/api_service.dart';
import 'package:ems_mobile/Services/Common/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressChangeService extends GetxController {
  RxList<AddressChange> addressChangeList = RxList<AddressChange>([]);
  RxMap<String, dynamic> status = RxMap<String, dynamic>();
  ApiService api = ApiService();
  List<RouteForm> routeList = [];
  RxList<RouteForm> routes = RxList<RouteForm>([]);

  final _addressChange = AddressChange.empty().obs;
  final _dateController = TextEditingController().obs;
  final _totalFees = TextEditingController().obs;
  final _travelBy = TextEditingController().obs;
  final _route = RouteForm.empty().obs;
  final _isloading = false.obs;

  TextEditingController get dateController => _dateController.value;
  TextEditingController get totalFees => _totalFees.value;
  TextEditingController get travelBy => _travelBy.value;
  AddressChange get addressChange => _addressChange.value;
  RouteForm get routeController => _route.value;
  bool get isLoading => _isloading.value;

  Future<void> addressChangeRegister() async {
    _dateController.value.text = DateTime.now().toString().split(" ")[0];
    final prefs = await SharedPreferences.getInstance();
    _isloading(true);
    final response =
        await api.get("${Config.domainUrl}${Config.addressChangeRegist}");
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    _addressChange.value =
        AddressChange.fromJson(jsonResponse["addressChangeForm"]);
    // prefs.clear();
    List<dynamic> routeListData = [];
    List<dynamic> storedData = prefs.getStringList("route") ?? [];
    for (int i = 0; i < storedData.length; i++) {
      var tempdata = storedData[i];
      Map<String, dynamic> data = jsonDecode(tempdata);
      routeListData.add(data);
    }
    routes.value = RxList<RouteForm>.from(
        (routeListData).map((x) => RouteForm.fromJson(x)));
    List<double> totalFee = routes.map((r) => r.fees).toList();
    double sum = totalFee.fold(0, (acc, val) => acc + val);
    _totalFees.value.text = (sum * 2).toString();
    _isloading(false);
  }

  addRoute(RouteForm route) async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    routeList.add(route);
    // var order = routes.length + 1;
    List<String> listData = prefs.getStringList("route") ?? [];
    var order = listData.length + 1;
    routes.value.add(route);
    Map<String, dynamic> routeData = {
      'from_route': route.fromRoute,
      'to_route': route.toRoute,
      'fees': route.fees,
      'route_order': order,
      'travel_by': travelBy.text
    };
    String storedata = jsonEncode(routeData);

    listData.add(storedata);
    prefs.setStringList("route", listData);
    update();
    List<dynamic> routeListData = [];
    List<dynamic> storedData = prefs.getStringList("route") ?? [];
    for (int i = 0; i < storedData.length; i++) {
      var tempdata = storedData[i];
      Map<String, dynamic> data = jsonDecode(tempdata);
      routeListData.add(data);
    }
    routes.value = RxList<RouteForm>.from(
        (routeListData).map((x) => RouteForm.fromJson(x)));
    Get.back();
  }

  getAddressChangeList() async {
    _isloading(true);
    final response =
        await api.get("${Config.domainUrl}${Config.addressChangeHistory}");
    Map<String, dynamic> map = jsonDecode(response.body);
    addressChangeList.value = RxList<AddressChange>.from(
        (map["addressChangeHistoryList"] as List)
            .map((x) => AddressChange.fromJson(x)));
    status.value = map["status"] as Map<String, dynamic>;
    _isloading(false);
  }

  Future<bool> addressChangeRequest(AddressChange data, isSave) async {
    data.route = routes.value;
    List<dynamic> route = [];
    for (int i = 0; i < routes.length; i++) {
      route.add(RouteForm.toJson(routes[i]));
    }
    data.route = route;
    var param = isSave ? Config.addressChangeSave : Config.addressChangeRequest;
    final response =
        await api.post("${Config.domainUrl}$param", AddressChange.toJson(data));
    if (response.statusCode == 200) {
      Get.toNamed(Config.addressChangeHistoryPage);
    }
    return false;
  }
}
