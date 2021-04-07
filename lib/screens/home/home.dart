// import 'dart:ui';

// import 'package:attendance/screens/drawers/dashboard.dart';
// import 'package:attendance/screens/drawers/profile.dart';
// import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:double_back_to_close/double_back_to_close.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int index = 0;
//   String _title;
//   List<Widget> list = [Profile(), Dashboard()];
//   List<bool> isSelected = [true, false, false];

//   @override
//   Widget build(BuildContext context) {
//     if (index == 0) {
//       _title = "Profile";
//     } else if (index == 1) {
//       _title = "Dashboard";
//     }
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//             primaryColor: Colors.blue[200], canvasColor: Colors.blue[100]),
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text(_title),
//           ),
//           body: list[index],
//           drawer: MyDrawer(
//             onTap: (ctx, i) {
//               setState(() {
//                 index = i;
//                 Navigator.pop(ctx);
//               });
//             },
//           ),
//         ));
//   }
// }

// class MyDrawer extends StatelessWidget {
//   final Function onTap;
//   MyDrawer({this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final data = MediaQuery.of(context);
//     return SizedBox(
//       width: data.size.width * 0.8,
//       child: Drawer(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           DrawerHeader(
//             decoration: BoxDecoration(color: Colors.blue[200]),
//             child: Padding(
//               padding: EdgeInsets.all(5),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   //IMAGE OF THE USER
//                   Container(
//                     width: 60,
//                     height: 60,
//                     child: CircleAvatar(
//                       backgroundImage: AssetImage('assets/images/logo.png'),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),

//                   //NAME AND EMAIL OF THE USER
//                   Text(
//                     "John Doe",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                   Text(
//                     "JohnDoe@gmail.com",
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           //SIDEBAR LIST
//           ListTile(
//               leading: Icon(Icons.person),
//               title: Text('Profile'),
//               onTap: () => onTap(context, 0)),
//           ListTile(
//               leading: Icon(Icons.home),
//               title: Text('Dashboard'),
//               onTap: () => onTap(context, 1)),
//           // ListTile(
//           //     leading: Icon(Icons.receipt_long_rounded),
//           //     title: Text('Dashboard'),
//           //     onTap: () => onTap(context, 2)),
//         ],
//       )),
//     );
//   }
// }
