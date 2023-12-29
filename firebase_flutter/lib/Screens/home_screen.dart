import 'package:firebase_flutter/Screens/login_screen.dart';
import 'package:firebase_flutter/Services/Utils/next_screen.dart';
import 'package:firebase_flutter/Services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future getData() async {
    final sp = context.read<SignInService>();
    sp.getDataFromSharedPeferences();
  }

  @override
  //to fetch data from firebase
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    //change read to watch
    final sp = context.read<SignInService>();
    return Scaffold(
      body: Center(
        // child: ElevatedButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage("${sp.imgUrl}"),
              radius: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Welcome ${sp.name}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${sp.email}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Provider"),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${sp.provider}".toUpperCase(),
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                sp.userSignOut();
                nextScreenReplace(context, const LoginScreen());
              },
              child: const Text(
                "SignOut",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        // child: const Text("Sign Out"),
        // onPressed: () {
        //   sp.userSignOut();
        //   //nextScreenReplace(context, const LoginScreen());
        // },
        // ),
      ),
    );
  }
}
