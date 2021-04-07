

import 'package:attendance/screens/drawers/profile.dart';
import 'package:attendance/screens/login/login.dart';
import 'package:attendance/services/auth.dart';
import 'package:attendance/widgets/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      db:Firestore.instance,
      child: MaterialApp(home: HomeController()),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Profile() : Login();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
