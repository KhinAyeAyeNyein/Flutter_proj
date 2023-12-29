class Attendance{

  int? attendanceRecordId;
  String? employeeId;
  String? employeeName;
  String? departmentName;
  String? cardId;
  String? recordDate;
  String? arrivalTime;
  String? leaveTime;
  int? lateMinutes;
  int? earlyLeaveMin;
  String? overtimeDay;
  bool? delFlag;
  String? offDayFlag;
  String? wfhFlag;
  String? fingerpFlag;
  String? wfhStatus;
  String? description;
  String? remark;
  String? createdUserId;
  String? updatedUserId;
  String? fromDate;
  String? toDate;
  String? dateRangeForReport;
  String? activeFlag;
  String? leavePeriod;
  String? checkBy;
  String? leaveDetailStatus;
  bool? isOffice;
  bool? isWFH;
  bool? isLeave;

  Attendance({
      this.attendanceRecordId,
      this.employeeId,
      this.employeeName,
      this.departmentName,
      this.cardId,
      this.recordDate,
      this.arrivalTime,
      this.leaveTime,
      this.lateMinutes,
      this.earlyLeaveMin,
      this.overtimeDay,
      this.delFlag,
      this.offDayFlag,
      this.wfhFlag,
      this.fingerpFlag,
      this.wfhStatus,
      this.description,
      this.remark,
      this.createdUserId,
      this.updatedUserId,
      this.fromDate,
      this.toDate,
      this.dateRangeForReport,
      this.activeFlag,
      this.leavePeriod,
      this.checkBy,
      this.leaveDetailStatus,
      this.isOffice,
      this.isWFH,
      this.isLeave});
  Attendance.empty();

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
        attendanceRecordId: json["attendanceRecordId"],
        employeeId: json["employeeId"],
        employeeName: json["employeeName"],
        departmentName: json["departmentName"],
        cardId: json["cardId"],
        recordDate: json["recordDate"],
        arrivalTime: json["arrivalTime"],
        leaveTime: json["leaveTime"],
        lateMinutes: json["lateMinutes"],
        earlyLeaveMin: json["earlyLeaveMin"],
        overtimeDay: json["overtimeDay"],
        delFlag: json["delFlag"],
        offDayFlag: json["offDayFlag"],
        wfhFlag: json["wfhFlag"],
        fingerpFlag: json["fingerpFlag"],
        wfhStatus: json["wfhStatus"],
        description: json["description"]??"",
        remark: json["remark"],
        createdUserId: json["createdUserId"],
        updatedUserId: json["updatedUserId"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
        dateRangeForReport: json["dateRangeForReport"],
        activeFlag: json["activeFlag"],
        leavePeriod: json["leavePeriod"],
        checkBy: json["checkBy"],
        leaveDetailStatus: json["leaveDetailStatus"],
        isOffice: json["office"],
        isWFH: json["wfh"],
        isLeave: json["leave"]
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "attendanceRecordId": attendanceRecordId,
      "employeeId": employeeId,
      "employeeName": employeeName,
      "departmentName": departmentName,
      "cardId": cardId,
      "recordDate": recordDate,
      "arrivalTime": arrivalTime,
      "leaveTime": leaveTime,
      "lateMinutes": lateMinutes,
      "earlyLeaveMin": earlyLeaveMin,
      "overtimeDay": overtimeDay,
      "delFlag": delFlag,
      "offDayFlag": offDayFlag,
      "wfhFlag": wfhFlag,
      "fingerpFlag": fingerpFlag,
      "wfhStatus": wfhStatus,
      "description": description,
      "remark": remark,
      "createdUserId": createdUserId,
      "updatedUserId": updatedUserId,
      "fromDate": fromDate,
      "toDate": toDate,
      "dateRangeForReport": dateRangeForReport,
      "activeFlag": activeFlag,
      "leavePeriod": leavePeriod,
      "checkBy": checkBy,
      "leaveDetailStatus": leaveDetailStatus,
      "wfh": isWFH,
      "office": isOffice,
      "leave": isLeave
    };
  }
}
