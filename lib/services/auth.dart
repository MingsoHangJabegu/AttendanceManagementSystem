import 'dart:async';

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
    logoutTime = loginTime.add(const Duration(hours: 12));
    _autoLogout();
    return (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  Future<void> logout() async {
    return await _auth.signOut();
    // print(loginTime);
  }

  _autoLogout() {
    final timeToExpiry = logoutTime.difference(loginTime).inSeconds;
    Timer(Duration(seconds: timeToExpiry), logout);
  }
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
