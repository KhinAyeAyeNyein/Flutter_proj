import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignInService extends ChangeNotifier {
  //instance of firebaseauth, facebook, google
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  //hasError, errorCode, privider, uid, email, name, imgUrl
  bool _hasError = false;
  bool get hasError => _hasError;
  String? _errorCode;
  String? get errorCode => _errorCode;
  String? _provider;
  String? get provider => _provider;
  String? _uid;
  String? get uid => _uid;
  String? _email;
  String? get email => _email;
  String? _name;
  String? get name => _name;
  String? _imgUrl;
  String? get imgUrl => _imgUrl;

  SignInService() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("sign_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  //sign in with Google
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      //executing auth
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final User userDetail =
            (await firebaseAuth.signInWithCredential(credential)).user!;

        //save all values
        _name = userDetail.displayName;
        _email = userDetail.email;
        _imgUrl = userDetail.photoURL;
        _provider = "Google";
        _uid = userDetail.uid;
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode = "You already have account";
            _hasError = true;
            break;
          case "null":
            _errorCode = "unexpected error occoured";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  //Facebook SignIn
  Future signInWithFacebook() async {
    facebookAuth.logOut();
    final LoginResult result = await facebookAuth.login();
    //getting profile
    final graphResponse = await http.get(Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result.accessToken!.token}'));
    final profile = jsonDecode(graphResponse.body);

    if (result.status == LoginStatus.success) {
      try {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        await firebaseAuth.signInWithCredential(credential);
        //saving values
        _name = profile['name'];
        _email = profile['email'];
        _imgUrl = profile['picture']['data']['url'];
        _uid = profile['id'];
        _hasError = false;
        _provider = "FACEBOOK";
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode = "You already have account";
            _hasError = true;
            break;
          case "null":
            _errorCode = "unexpected error occoured";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  //entry for cloudFirestore
  Future getUserDataFromFirestore(String? uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) => {
              _uid = snapshot["uid"],
              _email = snapshot["email"],
              _name = snapshot["name"],
              _imgUrl = snapshot["image_url"],
              _provider = snapshot["provider"],
            });
  }

  Future saveDataToFirestore() async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection("users").doc(uid);
    await r.set({
      "name": _name,
      "email": _email,
      "uid": _uid,
      "image_url": _imgUrl,
      "provider": _provider,
    });
    notifyListeners();
  }

  Future saveDataToSharedPeferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("name", _name!);
    await s.setString("email", _email!);
    await s.setString("provider", _provider!);
    await s.setString("image_url", _imgUrl!);
    await s.setString("uid", _uid!);
    notifyListeners();
  }

  Future getDataFromSharedPeferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString("name");
    _email = s.getString("email");
    _imgUrl = s.getString("image_url");
    _uid = s.getString("uid");
    _provider = s.getString("provider");
    notifyListeners();
  }

  //check user exists or not in cloudfire
  Future<bool> checkUserExist() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection("users").doc(_uid).get();
    if (snap.exists) {
      print("exist");
      return true;
    } else {
      print("New user");
      return false;
    }
  }

  Future userSignOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    _isSignedIn = false;
    notifyListeners();
    clearStoredData();
  }

  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }
}
