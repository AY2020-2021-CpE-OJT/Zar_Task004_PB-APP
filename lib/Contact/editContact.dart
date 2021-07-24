import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobileapp/ContactList.dart';
import 'package:flutter_mobileapp/Model/data_model.dart';
import 'package:http/http.dart';
import '../API.dart';
import 'package:http/http.dart' as http;
import '../Auth/token.dart';
import './newContact.dart';

class EditContact extends StatefulWidget {
  final String passid,pfirstname,plastname;
  final List<dynamic> phonenum;
  // EditContact({required this.passid, required this.pfirstname, required this.plastname, required this.phonenum});

  const EditContact({Key? key, required this.passid, required this.pfirstname, required this.plastname, required this.phonenum}) : super(key: key);

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
 
  
  TextEditingController editfname = TextEditingController();
  TextEditingController editlname = TextEditingController();
  List<TextEditingController> editphonenum = <TextEditingController>[TextEditingController()];
  Future<Contacts>? _futureContacts;
  final List<Todo> _list = <Todo>[];

  int _num = 0;
 
  @override
  void initState() {
    super.initState();
      

      editfname = TextEditingController(text: widget.pfirstname);
      editlname = TextEditingController(text: widget.plastname);
      editphonenum = <TextEditingController>[TextEditingController()];      
  }


  void addContact() {
    List<String> phonenum = <String>[];
    
    for (int i = 0; i < _num; i++) {
      phonenum.add(editphonenum[i].text);
    }
    setState(() {
    _list.insert(0, Todo(editlname.text, editfname.text, phonenum));
    _futureContacts = editContact(widget.passid, editfname.text, editlname.text, phonenum);
    });
                  
    for (int i = 0; i < _num; i++) {
      editlname.clear();
      editfname.clear();
      editphonenum[i].clear();
      }

    final toast = SnackBar(
      content: Text("Edit Succesful",
          style: TextStyle(fontSize: 17, color: Colors.white)),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(toast);
  }

  void add() {
    setState(() {
       _num++;
      // editphonenum.insert(0, TextEditingController());
      editphonenum = <TextEditingController>[TextEditingController()];
    });
  }


  @override
  Widget build(BuildContext context) {
    List nums = widget.phonenum;
    nums.getRange(0, widget.phonenum.length);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Contact", style: TextStyle(color: Colors.black, fontSize: 20)),
        backgroundColor: Colors.redAccent.shade100),
        backgroundColor: Colors.white,
        floatingActionButton: new RaisedButton(
          color: Colors.redAccent.shade100,
          onPressed: () {
          if (editlname.text.isEmpty && editfname.text.isEmpty) {
            
            final toast = SnackBar( content: Text("Must Enter Empty Fields!", style: TextStyle(fontSize: 17, color: Colors.red)),
                    backgroundColor: Colors.black);
                  ScaffoldMessenger.of(context).showSnackBar(toast);
                } else {       
                  addContact();
                  print(nums);
                }
          },
      child: Text("SAVE", style: TextStyle(color: Colors.black, fontSize: 20))),
      body: Column(children: [
        CircleAvatar(
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image(
              image: AssetImage('lib/Contact/add-user-icon-6-removebg-preview.png'),
            ),
          ),
          backgroundColor: Colors.white,
          radius: 90,
        ),
        SizedBox(height: 10),
        Flexible(
          child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return ListTile(
              title: TextField(
                  controller: editfname,
                  decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder()),
                keyboardType: TextInputType.name,
              ),
            );
          },
          itemCount: 1,
        )),
        Flexible(
            child: ListView.builder(
         
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return ListTile(
              title: TextField(
                controller: editlname,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  icon: SizedBox(width: 24),
                  border: OutlineInputBorder()),
                keyboardType: TextInputType.name,
              ),
            );
          },
          itemCount: 1,
        )),
        Flexible(
            child: ListView.builder(
          
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return ListTile(
              title: TextField(
                controller: editphonenum[i],
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    border: OutlineInputBorder()),
                maxLength: 11,
                keyboardType: TextInputType.number,
              ),
            );
          },
          itemCount: _num,
        )),
        SizedBox(height: 30),
        TextButton(
          onPressed: add,
          child: Text( 
          " ➕ Add Phone Number",
          style: TextStyle(fontSize: 15, color: Colors.black), 
        )),
      ]),
    );
  }
}
