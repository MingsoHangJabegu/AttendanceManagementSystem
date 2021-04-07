// import 'dart:convert';

import 'package:attendance/services/ip.dart';
import 'package:attendance/services/auth.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isHidden = true;

  String _email, _password, _error;

  final AuthService _auth = AuthService();
  final formKey = GlobalKey<FormState>();

//hiding password
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

//checking if user has connection to internet or not
  bool _connection = false;
  _checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("No Internet Connection"),
              content:
                  Text("Please check your internet connection and try again"),
            );
          });
      _connection = false;
    } else {
      _connection = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromRGBO(83, 113, 212, 1),
      body: SingleChildScrollView(
        child: GestureDetector(
          //To remove focus when tapping anywhere on screen
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },

          //LOGO
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: data.size.height * 0.025),
                showAlert(),
                //IMAGE
                Container(
                  height: data.size.height / 2.75,
                  child: Center(
                    child: Image.asset('assets/images/logo.png',
                        width: data.size.width / 1.25,
                        height: data.size.height / 2.5),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),

                  //TEXT FIELDS
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Form(
                            key: formKey,
                            child: Column(
                              children: buildInputs(),
                            )),
                      ),
                      SizedBox(
                        height: 40,
                      ),

                      //LOGIN BUTTON
                      ElevatedButton(
                        onPressed: () async {
                          _checkConnection();
                          if (_connection) {
                            final ipAddress = await IpInfoApi.getIPAddress();
                            String publicIP = "103.10.28.186";
                            if (validate()) {
                              try {
                                if (ipAddress == publicIP) {
                                  String uid =
                                      await _auth.signInWithEmailAndPassword(
                                          _email.trim(), _password);
                                  showMessage("Login successful");
                                  print(uid);
                                } else {
                                  showMessage(
                                      "Please connect to xyz (password) and try again");
                                }
                              } catch (e) {
                                setState(() {
                                  _error = e.message;
                                });
                                print(e);
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(88, 145, 209, 1),
                          onPrimary: Colors.black,
                          elevation: 5,
                          shadowColor: Colors.black
                        ), 
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                          )
                        ),
                      SizedBox(height: 12.0),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    textFields.add(
      Container(
        padding: EdgeInsets.all(6.0),
        child: TextFormField(
          validator: EmailValidator.validate,
          decoration: InputDecoration(
            hintText: "Email",
          ),
          onSaved: (value) => _email = value,
        ),
      ),
    );

    textFields.add(Container(
      padding: EdgeInsets.all(6.0),
      child: TextFormField(
        validator: PasswordValidator.validate,
        decoration: InputDecoration(
          hintText: "Password",
          suffixIcon: IconButton(
            icon:
                _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: _toggleVisibility,
          ),
        ),
        obscureText: _isHidden,
        onSaved: (value) => _password = value,
      ),
    ));

    return textFields;
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _error = null;
                    });
                  }),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  showMessage(String _message) {
    Fluttertoast.showToast(
        msg: _message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 17.0);
  }
}
