

// import 'package:attendance/models/attendance.dart';
// import 'package:attendance/widgets/provider.dart';
// import 'package:flutter/material.dart';

// class NoSchool extends StatefulWidget {
//   @override
//   _NoSchoolState createState() => _NoSchoolState();
// }

// class _NoSchoolState extends State<NoSchool> {
//   UserInfo userInfo = new UserInfo(0, 0);
//   AbsentPercent absPercent = new AbsentPercent(0);
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: Column(
//       children: <Widget>[
//         FutureBuilder(
//             future: Provider.of(context).auth.getCurrentUser(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return displayUserInformation(context, snapshot);
//               } else {
//                 return CircularProgressIndicator();
//               }
//             })
//       ],
//     ));
//   }

//   Widget displayUserInformation(context, snapshot) {

//       _getStudentInfo() async {
//         var uid = await Provider.of(context).auth.getCurrentUID();
//         try {
//           await Provider.of(context)
//               .db
//               .collection('students')
//               .document(uid)
//               .get()
//               .then((results) {
//             userInfo.present = results.data['present'];
//             userInfo.absent = results.data['absent'];
//             double present = userInfo.present.toDouble();
//             double absent = userInfo.absent.toDouble();
//             absPercent.percent = (present / (present + absent)) * 100;
//           });
//         } on Exception catch (e) {
//           print(e);
//         }
//       }

//       return Column(
//         children: <Widget>[
//           FutureBuilder(
//               future: _getStudentInfo(),
//               builder: (context, snapshot) {
//                 return Column(children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('${userInfo.present}'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('${userInfo.absent} (${absPercent.percent}%)'),
//                   ),
//                 ]);
//               })
//         ],
//       );
//     }
// }


    