// ignore_for_file: file_names
import 'package:ems_mobile/Models/Auth/auth_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Credential {
  String? employeeId;
  String? employeeName;
  int? employeeType;
  String? token;

  static const storage = FlutterSecureStorage();

  Credential({
    this.employeeId,
    this.employeeName,
    this.employeeType,
    this.token,
  });

  static void setEmployeeId(employeeId) async {
    await storage.write(key: "employeeId", value: employeeId);
  }

  static void setEmployeeName(employeeName) async {
    await storage.write(key: "employeeName", value: employeeName);
  }

  static void setEmployeeType(employeeType) async {
    await storage.write(key: "employeeType", value: employeeType.toString());
  }

  static void setToken(token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<bool> isLoggedIn() async {
    final token = await storage.read(key: "token");
    if(token != null){
      //check jwt token time 
      DateTime expiryDate = Jwt.getExpiryDate(token)??DateTime.now();
      if(DateTime.now().isBefore(expiryDate)){
        return true;
      }
    }
    return false;
  }

  static Future<Credential> getCredential() async {
    final employeeId = await storage.read(key: "employeeId");
    final employeeName = await storage.read(key: "employeeName");
    final employeeType = await storage.read(key: "employeeType");
    final token = await storage.read(key: "token");
    return Credential(
      employeeId: employeeId,
      employeeName: employeeName,
      employeeType: int.tryParse(employeeType ?? ''),
      token: token,
    );
  }
  static void setCredential(AuthResponse authResponse){
    if(authResponse.userInformation == null) return;
    setEmployeeId(authResponse.userInformation!.employeeId);
    setEmployeeName(authResponse.userInformation!.employeeName);
    setEmployeeType(authResponse.userInformation!.employeeType);
    setToken(authResponse.token);
  }
  static void clearStorage() async {
    await storage.deleteAll();
  }

}
