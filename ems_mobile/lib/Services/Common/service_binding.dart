import 'package:ems_mobile/Services/Attendance/attendance_service.dart';
import 'package:ems_mobile/Services/AddressChange/address_change_service.dart';
import 'package:ems_mobile/Services/Leave/leave_service.dart';
import 'package:ems_mobile/Services/Login/login_service.dart';
import 'package:ems_mobile/Services/Overtime/overtime_service.dart';
import 'package:ems_mobile/Services/Profile/change_password_service.dart';
import 'package:ems_mobile/Services/Profile/profile_service.dart';
import 'package:get/get.dart';

import '../Dashboard/dashboard_service.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginService());
    Get.put(AttendanceService());
    Get.put(DashboardService());
    Get.put(ChangePasswordService());
    Get.put(ProfileService());
    Get.put(LeaveService());
    Get.put(OvertimeService());
    Get.put(AddressChangeService());
  }
}
