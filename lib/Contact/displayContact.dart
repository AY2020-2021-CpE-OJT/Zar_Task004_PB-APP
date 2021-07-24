import 'package:flutter/material.dart';



class Display extends StatefulWidget {
  final String firstnames, lastnames;
  final List<dynamic> phonenum;
  const Display({ Key? key, required this.firstnames, required this.lastnames, required this.phonenum }) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contact details", style: TextStyle(color: Colors.black, fontSize: 17)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: 
        Text("Firstname: " + " \n" + widget.firstnames + "\n\n" + "Lastname: " + " \n" + widget.lastnames + "\n\nPhone numbers: \n" + widget.phonenum.toString().replaceAll('[', '✆ ').replaceAll(']','').replaceAll(',', '\n✆').replaceAll(',', '\n'), style: TextStyle(fontSize: 20, color: Colors.black),),
          
      ),
      backgroundColor: Colors.blue[50],
    );
  }
}