class Overtime {
  int? overtimeRecordId;
  String employeeId;
  String employeeName;
  String departmentName;
  String? fromDate;
  String? toDate;
  String? requestDate;
  String? appliedDate;
  String? fromTime;
  String? toTime;
  double? otHour;
  String? description;
  String? overTimeStatus;
  String? remark;
  String? approvedDate;
  double? overtimeFee;
  bool? compensatoryFlag;
  bool? delFlag;

  Overtime({
    this.overtimeRecordId,
    required this.employeeId,
    required this.employeeName,
    required this.departmentName,
    this.requestDate,
    this.appliedDate,
    this.fromTime,
    this.toTime,
    this.otHour,
    this.description,
    this.remark,
    this.delFlag,
    this.overTimeStatus,
  });

  Overtime.empty()
      : employeeId = "",
        employeeName = "",
        departmentName = "",
        appliedDate = "",
        fromTime = "",
        toTime = "",
        otHour = 0.0,
        description = "",
        remark = "",
        delFlag = false;

  factory Overtime.fromJson(Map<String, dynamic> json) {
    return Overtime(
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
      departmentName: json['departmentName'],
      appliedDate: json['appliedDate'],
      fromTime: json['fromTime'],
      toTime: json['toTime'],
      otHour: json['otHour'],
      description: json['description'],
      remark: json['remark'],
      delFlag: json['delFlag'],
      overTimeStatus: json['overtimeStatus'],
    );
  }

  static Map<String, dynamic> toJson(Overtime overtime) {
    return {
      "employeeId": overtime.employeeId,
      "employeeName": overtime.employeeName,
      "departmentName": overtime.departmentName,
      "appliedDate": overtime.appliedDate,
      "fromTime": overtime.fromTime,
      "toTime": overtime.toTime,
      "otHour": overtime.otHour,
      "description": overtime.description,
      "remark": "",
      "delFlag": false
    };
  }
}
