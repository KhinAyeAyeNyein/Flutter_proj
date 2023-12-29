import 'package:firebase_flutter/Screens/home_screen.dart';
import 'package:firebase_flutter/Services/Utils/config.dart';
import 'package:firebase_flutter/Services/Utils/next_screen.dart';
import 'package:firebase_flutter/Services/Utils/snack_bar.dart';
import 'package:firebase_flutter/Services/internet_service.dart';
import 'package:firebase_flutter/Services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _key = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage(Config.app_icon),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Learn Auth Provider",
                      style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),

              //RoundedButton
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedLoadingButton(
                    controller: googleController,
                    successColor: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.8,
                    elevation: 0,
                    borderRadius: 30,
                    color: Colors.green,
                    onPressed: () {
                      //handleGoogleSignIn();
                      handleFacebookAuth();
                    },
                    child: Wrap(
                      children: const [
                        Icon(
                          FontAwesomeIcons.google,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedLoadingButton(
                    controller: facebookController,
                    successColor: Colors.blue,
                    width: MediaQuery.of(context).size.width * 0.8,
                    elevation: 0,
                    borderRadius: 30,
                    color: Colors.blue,
                    onPressed: () {
                      handleFacebookAuth();
                    },
                    child: Wrap(
                      children: const [
                        Icon(
                          FontAwesomeIcons.facebook,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Sign in with Facebook",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

//handle after signIn
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, HomeScreen());
    });
  }

  //Future handleGoogleSignIn() async {
  Future handleFacebookAuth() async {
    final sp = context.read<SignInService>();
    final ip = context.read<InternetService>();
    await ip.checkInternetConnection();
    if (ip.hasInternet == false) {
      // ignore: use_build_context_synchronously
      openSnackbar(context, "Check Internet connection", Colors.red);
      //googleController.reset();
      facebookController.reset();
    } else {
      //await sp.signInWithGoogle().then(
      await sp.signInWithFacebook().then(
        (value) {
          if (sp.hasError == true) {
            openSnackbar(context, sp.errorCode.toString(), Colors.red);
            //googleController.reset();
            facebookController.reset();
          } else {
            //check user exists or not
            sp.checkUserExist().then(
              (value) async {
                if (value == true) {
                  //user exists
                  await sp.getUserDataFromFirestore(sp.uid).then(
                        (value) => sp.saveDataToFirestore().then(
                          (value) {
                            //googleController.success();
                            facebookController.success();
                            handleAfterSignIn();
                          },
                        ),
                      );
                } else {
                  sp.saveDataToFirestore().then(
                        (value) => sp.saveDataToSharedPeferences().then(
                              (value) => sp.setSignIn().then(
                                (value) {
                                  //googleController.success();
                                  facebookController.success();
                                  //handleGoogleSignIn();
                                  handleAfterSignIn();
                                },
                              ),
                            ),
                      );
                }
              },
            );
          }
        },
      );
    }
  }
  //handling facebook
}
