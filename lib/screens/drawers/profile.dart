import 'dart:async';

import 'package:attendance/models/attendance.dart';
import 'package:attendance/models/holiday.dart';
import 'package:attendance/models/user.dart';
import 'package:attendance/widgets/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String myEmail;
  User user = new User("", "", "", "", "", "", "");
  UserInfo userInfo = new UserInfo(0, 0);
  AbsentPercent absPercent = new AbsentPercent("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      )),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    _getProfileData() async {
      var uid = await Provider.of(context).auth.getCurrentUID();

      try {
        await Provider.of(context)
            .db
            .collection('day')
            .document('totalWorkingDays')
            .get()
            .then((result) {
          userInfo.total = result.data['total'];
        });

        await Provider.of(context)
            .db
            .collection('students')
            .document(uid)
            .get()
            .then((results) {
          user.name = results.data['name'];
          user.email = results.data['email'];
          user.faculty = results.data['faculty'];
          user.year = results.data['year'];
          user.phone = results.data['phone'];
          user.roll = results.data['roll'];
          user.image = results.data['image'];
          userInfo.present = results.data['present'];
          double absent = (userInfo.total - userInfo.present).toDouble();
          double total = userInfo.total.toDouble();
          absPercent.percent = ((absent / total) * 100).toStringAsFixed(2);
        });
      } on Exception catch (e) {
        print(e);
      }
    }

    return Container(
      color: Color.fromRGBO(83, 113, 212, 1),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
      child: ListView(
        children: <Widget>[
          FutureBuilder(
              future: _getProfileData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.black),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(user.image)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Name: " + user.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("E-mail Address: " + user.email,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Phone Number: " + user.phone,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Faculty: " + user.faculty,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Roll Number: " + user.roll,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Year: " + user.year,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Number of days present: " +
                                  userInfo.present.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Number of days absent: ${userInfo.total - userInfo.present} (${absPercent.percent}%)",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ),
                      ]);
                } else {
                  return CircularProgressIndicator();
                }
              }),
          Center(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TakeAttendance(),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class TakeAttendance extends StatefulWidget {
  @override
  _TakeAttendanceState createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State<TakeAttendance> {
  Holiday holiday = new Holiday("");
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Future<void> _updateStudentInfo(String time) async {
      var uid = await Provider.of(context).auth.getCurrentUID();

      try {
        await Provider.of(context)
            .db
            .collection('students')
            .document(uid)
            .updateData({
          'today': time,
        });
      } on Exception catch (e) {
        print(e);
      }
    }

    // void _resetButton() async {
    //   _isEnabled = true;
    // }

    void _resetData() async {
      return await _updateStudentInfo("");
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

    void _onPressed() async {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

      SharedPreferences preferences = await _prefs;
      String lastVisitDate = preferences.get("mDateKey");
      String todayDate = DateTime.now().day.toString();
      var uid = await Provider.of(context).auth.getCurrentUID();

      if (todayDate == lastVisitDate) {
        try {
          await Provider.of(context)
              .db
              .collection('day')
              .document('type')
              .get()
              .then((result) {
            holiday.today = result.data['today'];
            print(holiday.today);
          });

          await Provider.of(context)
              .db
              .collection('students')
              .document(uid)
              .updateData({
            'present': FieldValue.increment(1),
          });
        } on Exception catch (e) {
          print(e);
        }

        if (holiday.today == 'working') {
          if (now.hour < 24) {
            DateTime now = DateTime.now();
            String today = DateFormat('dd-MM-yyyy').format(now);
            // DateTime resetButton = now.add(const Duration(hours: 12));
            DateTime resetData = now.add(const Duration(hours: 6));

            // final timeToExpiry = resetButton.difference(now).inSeconds;
            final timeToResetData = resetData.difference(now).inSeconds;

            // Timer(Duration(seconds: timeToExpiry), _resetButton);
            Timer(Duration(seconds: timeToResetData), _resetData);

            String hours = now.hour.toString(),
             minutes = now.minute.toString(), 
             seconds = now.second.toString();

            int hour = now.hour;
            if (hour < 10) {
              hours = '0' + hour.toString();
            }

            int minute = now.minute;
            if (minute < 10) {
              minutes = '0' + minute.toString();
            }

            int second = now.second;
            if (second < 10) {
              seconds = '0' + second.toString();
            }
            String currentTime = hours + ':' + minutes + ':' + seconds;
            print(currentTime);
            // String currentDate = DateFormat('dd-MM-yyyy').format(now);
            // String time = currentDate + ' ' + currentTime;

            await Provider.of(context)
                .db
                .collection('students')
                .document(uid)
                .collection('attendance')
                .document(today)
                .setData({
              'attendanceTime': currentTime,
              'remarks': '-',
            });

            _updateStudentInfo(currentTime);

            showMessage("Attendance recorded");
          } else {
            showMessage("You are too late. Please contact xyz.");
          }
        } else {
          showMessage("Cannot take attendance right now");
        }
        preferences.setString("mDateKey", todayDate);
      } else {
        showMessage("Cannot take attendance right now");
      }
    }

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(88, 145, 209, 1),
            onPrimary: Colors.black,
            elevation: 5,
            shadowColor: Colors.black),
        child: Text("Take Attendance",
            style: TextStyle(
              fontSize: 20,
            )),
        onPressed: _onPressed);
  }
}
