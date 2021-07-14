// import 'package:flutter/material.dart';
// import 'package:flutter_mobileapp/Model/data_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class SearchList extends StatefulWidget {
//   const SearchList({ Key? key }) : super(key: key);

//   @override
//   _SearchListState createState() => _SearchListState();
// }

// // @override
// // void initState() {
// //   super.initState() {

// //   }
// // }
// class _SearchListState extends State<SearchList> {

//   // fetchUser() async {
//   //   Uri url = Uri.http('10.0.2.2:3000', '/router/delete/:id');
//   //   http.Response res = await http.delete(url);

//   //   if (res.statusCode == 200) {
//   //     var items = json.decode(res.body);
//   //     //print(items);
//   //     setState(() {
//   //       contacts = items;
//   //     });
//   //   } else {
//   //     setState(() {
//   //       contacts =[];
//   //       Center(child: Text("Add List"));
//   //     });
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Contact List"),
//       ),
//       body: Center(
//         child: FutureBuilder<List<Contacts>>(
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (context, i) {
//                   return Dismissible(
//                     key: key, child: child)
//                 }
//             }
//           }
//         ),
//       ),

//     );
//   }
// }
