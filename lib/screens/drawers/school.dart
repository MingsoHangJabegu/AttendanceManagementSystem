// import 'package:attendance/models/attendance.dart';
// import 'package:attendance/widgets/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SchoolDay extends StatefulWidget {
//   @override
//   _SchoolDayState createState() => _SchoolDayState();
// }

// class _SchoolDayState extends State<SchoolDay> {
//   UserInfo userInfo = new UserInfo(0, 0);
//   AbsentPercent absPercent = new AbsentPercent(0);
//   Attend attendanceInfo = new Attend('');

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: Column(
//       children: <Widget>[
//         FutureBuilder(
//             future: Provider.of(context).auth.getCurrentUser(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return displayUserInformationAndSetAbsent(context, snapshot);
//               } else {
//                 return CircularProgressIndicator();
//               }
//             })
//       ],
//     ));
//   }

//   Widget displayUserInformationAndSetAbsent(context, snapshot) {
    

//     _getStudentInfo() async {
     
//     }

//     Future<void> _updateStudentInfo(int absent) async {
//       var uid = await Provider.of(context).auth.getCurrentUID();
//       final doc = Firestore.instance.collection('students').document(uid);
//       return await doc
//           .updateData({
//             'absent': absent,
//           })
//           .catchError((error) => print(error));
//     }

//     checkVisit() async {
//       Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//       SharedPreferences preferences = await _prefs;
//       String lastVisitDate = preferences.get("mDateKey");
//       String todayDate = DateTime.now().day.toString();

//       if (todayDate != lastVisitDate) {
//         if (attendanceInfo.today == "") {
//           int absent = userInfo.absent + 1;
//           _updateStudentInfo(absent);
//           preferences.setString("mDateKey", todayDate);
//         }
//       }
//     }

//     return Column(
//       children: <Widget>[
//         FutureBuilder(
//             future: _getStudentInfo(),
//             builder: (context, snapshot) {
//               checkVisit();
//               return Column(children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('${userInfo.present}'),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('${userInfo.absent} (${absPercent.percent}%)'),
//                 ),
//               ]);
//             })
//       ],
//     );
//   }
// }
