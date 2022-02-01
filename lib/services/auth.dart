import 'dart:async';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DateTime loginTime;
  DateTime logoutTime;

  Stream<String> get onAuthStateChanged => _auth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  //GET UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }

  //GET CURRENTUSER
  Future getCurrentUser() async {
    return _auth.currentUser();
  }

  //SignIn with Email and Password

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    loginTime = DateTime.now();
    logoutTime = loginTime.add(const Duration(seconds: 5));

    final timeToLogout = logoutTime.difference(loginTime).inSeconds;
    print(timeToLogout);

    AndroidAlarmManager.oneShot(Duration(seconds: timeToLogout), 0, logout);
    return (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  // _autoLogout() {
  //   final timeToExpiry = logoutTime.difference(loginTime).inSeconds;
  //   Timer(Duration(seconds: timeToExpiry), logout);
  // }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Passord can't be empty";
    }
    return null;
  }
}

Future<void> logout() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  return await _auth.signOut();
  // print(loginTime);
}
