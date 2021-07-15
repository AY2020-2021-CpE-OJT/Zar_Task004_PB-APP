// import 'package:flutter/material.dart';
// import 'API.dart';
// import 'ContactList.dart';

// class Dialogue {
//   information(BuildContext context, String message) {
//     return showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(message),
//           actions: <Widget>[
//             FlatButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 deleteContact("_id".toString());
//               },
//               child: Text("Yes"),
//             ),
//             FlatButton(
//                 onPressed: () => Navigator.pop(context), child: Text("No"))
//           ],
//         );
//       },
//     );
//   }
// }
