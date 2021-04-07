
// import 'package:attendance/models/holiday.dart';
// import 'package:attendance/screens/drawers/holiday.dart';
// import 'package:attendance/screens/drawers/school.dart';

// import 'package:attendance/widgets/provider.dart';
// import 'package:flutter/material.dart';

// class Dashboard extends StatefulWidget {
//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: Column(
//       children: <Widget>[
//         FutureBuilder(
//             future: Provider.of(context).auth.getCurrentUser(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return displayDashboard(context, snapshot);
//               } else {
//                 return CircularProgressIndicator();
//               }
//             })
//       ],
//     ));
//   }

//   Widget displayDashboard(context, snapshot) {
//     Holiday holiday = new Holiday("");

//     _getHolidayInfo() async {
//       try {
//         await Provider.of(context)
//             .db
//             .collection('holiday')
//             .document('holiday')
//             .get()
//             .then((result) {
//           holiday.today = result.data['today'];
//         });
//       } on Exception catch (e) {
//         print(e);
//       }
//     }

//     return Column(children: <Widget>[
//       FutureBuilder(
//           future: _getHolidayInfo(),
//           builder: (context, snapshot) {
//             return holiday.today == 'yes'
//                 ? SchoolDay()
//                 : NoSchool();
//           })
//     ]);
//   }
// }
