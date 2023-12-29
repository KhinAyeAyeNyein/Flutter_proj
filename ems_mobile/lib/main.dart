import 'package:ems_mobile/Screens/Dashboard/dashboard.dart';
import 'package:ems_mobile/Screens/Login/login_page.dart';
import 'package:ems_mobile/Services/Common/pages_config.dart';
import 'package:ems_mobile/Services/Common/service_binding.dart';
import 'package:ems_mobile/Services/Credential/credential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

Widget pageDefault = LoginPage();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Credential.clearStorage();
  final result = await Credential.isLoggedIn();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  if (result) {
    pageDefault = const Dashboard();
  }
  runApp(const EmsApp());
}

class EmsApp extends StatelessWidget {
  const EmsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "EMS Mobile",
      home: pageDefault,
      initialBinding: ServiceBinding(),
      getPages: PagesConfig.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
