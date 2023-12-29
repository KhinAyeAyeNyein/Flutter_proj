import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/Screens/splash_screen.dart';
import 'package:firebase_flutter/Services/internet_service.dart';
import 'package:firebase_flutter/Services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  //initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInService()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetService()),
        ),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
