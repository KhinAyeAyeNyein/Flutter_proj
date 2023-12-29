class RouteForm {
  int? addressChangeId;
  String fromRoute;
  String toRoute;
  int routeOrder;
  int? transportationId;
  String travelBy;
  bool? delFlg;
  double fees;

  RouteForm({
    this.addressChangeId,
    required this.fromRoute,
    required this.toRoute,
    required this.routeOrder,
    this.transportationId,
    required this.fees,
    required this.travelBy,
    this.delFlg,
  });

  RouteForm.empty()
      : fromRoute = "",
        toRoute = "",
        routeOrder = 0,
        travelBy = "",
        fees = 0.0,
        delFlg = false;

  factory RouteForm.fromJson(Map<String, dynamic> json) {
    return RouteForm(
      addressChangeId: json['address_change_id'],
      fromRoute: json['from_route'],
      toRoute: json['to_route'],
      routeOrder: json['route_order'],
      fees: json['fees'],
      travelBy: json['travel_by'],
      delFlg: json['del_flg'],
      transportationId: json['transportation_id'],
    );
  }

  static Map<String, dynamic> toJson(RouteForm route) {
    return {
      "from_route": route.fromRoute,
      "to_route": route.toRoute,
      "route_order": route.routeOrder,
      "fees": route.fees,
      "travel_by": route.travelBy,
      "del_flg": false
    };
  }
}
