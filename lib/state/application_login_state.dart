import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_stripe_shopper/utils/common_util.dart';

enum ApplicationLoginState { loggedOut, loggedIn }

class ApplicationState extends ChangeNotifier {
  ///
  ApplicationState() {
    init();
  }

  User? user;

  ApplicationLoginState loginState = ApplicationLoginState.loggedOut;

  ///
  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((loginUser) {
      if (loginUser != null) {
        loginState = ApplicationLoginState.loggedIn;

        user = loginUser;
      } else {
        loginState = ApplicationLoginState.loggedOut;
      }

      notifyListeners();
    });
  }

  ///
  Future<void> signIn(String email, String password, void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      errorCallBack(e);
    }
  }

  ///
  Future<void> signUp(String email, String password, void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      await CommonUtil.backendCall(userCredential.user!, CommonUtil.stripeUserCreate);
    } on FirebaseAuthException catch (e) {
      errorCallBack(e);
    }
  }

  ///
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
