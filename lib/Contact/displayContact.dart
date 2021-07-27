import 'package:flutter/material.dart';
import '../Contact/editContact.dart';
import '../ContactList.dart';

class Display extends StatefulWidget {
  final String id, firstnames, lastnames;
  final List<dynamic> phonenum;
  const Display({ Key? key, required this.id, required this.firstnames, required this.lastnames, required this.phonenum }) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}



class _DisplayState extends State<Display> {
   @override

   Widget align1() {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 200,
      child: Text("\n      Firstname: ", style: TextStyle(fontSize: 23, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),),
    );
  }
  Widget align2() {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 200,
      child: Text("         " + widget.firstnames, style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.orangeAccent.shade700)),
    );
  }
  Widget align3() {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 200,
      child: Text("\n      Lastname: ", style: TextStyle(fontSize: 23, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),),
    );
  }
  Widget align4() {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 200,
      child: Text("         " + widget.lastnames, style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.orangeAccent.shade700)),
    );
  }
  Widget align5() {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 200,
      child: Text("\n      Phone Numbers: ", style: TextStyle(fontSize: 23, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400)),
    );
  }
  Widget align6() {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 200,
      child: Text("         " + widget.phonenum.toString().replaceAll('[', '✆ ').replaceAll(']','').replaceAll(',', '\n         ✆')
      .replaceAll(',', '\n'),style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.orangeAccent.shade700),),
    );
  }
  


  @override
  Widget build(BuildContext context) {
    String initalsName = widget.firstnames.substring(0, 1).toUpperCase() + widget.lastnames.substring(0, 1).toUpperCase();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contact details", style: TextStyle(color: Colors.black, fontSize: 17)),
        leading: TextButton(   
          child: Icon(Icons.arrow_back, color: Colors.black, size: 30,),
          onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ViewContact(),
              ),
            );
          },
        ),
        backgroundColor: Colors.redAccent.shade100,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => EditContact(passid: widget.id, pfirstname: widget.firstnames, plastname: widget.lastnames, phonenum: widget.phonenum),
                ),
              );
            }, 
            icon: Icon(Icons.edit, color: Colors.black
            )
          )
        ],
      ),
      backgroundColor: Colors.blue[40],
      body: Column(
        children: [
          Padding( 
            padding: EdgeInsets.all(25),
            child: CircleAvatar(
              child: Text(
              initalsName,
              style: TextStyle(color: Colors.black, fontSize: 80,)),
              radius: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(widget.firstnames + " " + widget.lastnames, style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400,))),
          Center(
            child: Center(
              child: Text("_________________________________________________", style: TextStyle(height: -0.5),),

            )), 
            align1(),
            align2(),
            align3(),
            align4(),
            align5(),
            align6()
        ]
      )
    );
  }
}