// import 'dart:async';

// import 'package:attendance/models/attendance.dart';
// import 'package:attendance/models/holiday.dart';
// import 'package:attendance/screens/drawers/dashboard.dart';
// import 'package:attendance/screens/drawers/profile.dart';
// import 'package:attendance/widgets/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';

// class AttendanceTab extends StatefulWidget {
//   @override
//   _AttendanceTabState createState() => _AttendanceTabState();
// }

// class _AttendanceTabState extends State<AttendanceTab> {
  

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: Column(
//       children: <Widget>[
//         FutureBuilder(
//             future: Provider.of(context).auth.getCurrentUser(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return displayButtonOrData(context, snapshot);
//               } else {
//                 return CircularProgressIndicator();
//               }
//             })
//       ],
//     ));
//   }

  
// }
