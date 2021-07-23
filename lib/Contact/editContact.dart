import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobileapp/ContactList.dart';
import 'package:flutter_mobileapp/Model/data_model.dart';
import 'package:http/http.dart';
import '../API.dart';
import 'package:http/http.dart' as http;
import '../Auth/token.dart';

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
  List<TextEditingController> editphonenum = <TextEditingController>[ TextEditingController()];
  Future<Contacts>? _futureContacts;
  final List<Todo> _list = <Todo>[];
  List<String> phonenum = <String>[];
  int _num = 0;

  String fname = "";
  String lname = "";
  List<dynamic> pnum = [];




  @override
  void initState() {
    super.initState();
    
      editfname = TextEditingController(text: widget.pfirstname);
      editlname = TextEditingController(text: widget.plastname);
      editphonenum = <TextEditingController>[TextEditingController(text: widget.phonenum[_num])];  
    
  }


  void updateContact (String id, String fname, String lname, List<dynamic> pnum) async {
     fname = editfname.text;
     lname = editlname.text;
     pnum = editphonenum;
    Uri url = Uri.http('firstappdeployment.herokuapp.com', '/router/edit/$id');
  
  final res = await http.put(url,
      headers: <String, String>{
        'Authorization' : 'Bearer $token'
      },
      body: {
        'firstname': fname,
        'lastname': lname,
        'phonenumbers': pnum,
      });

    if (res.statusCode == 200) {
      List items = jsonDecode(res.body);
      print(items);
    }
      Navigator.pop(context);
  }

  
  void addContact() {
    
    for (int i = 0; i < _num; i++) {
      phonenum.add(editphonenum[i].text);
    }
    setState(() {
    _list.insert(0, Todo(editlname.text, editfname.text, phonenum));
    updateContact("${widget.passid}", editfname.text, editlname.text, phonenum);
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
      editphonenum.insert(0, TextEditingController());
    });
  }


  @override
  Widget build(BuildContext context) {
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
                  setState(() {
                    editContact(widget.passid, editfname.text, editlname.text, editphonenum);  
                  });
                             
                    print(widget.passid);
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
                  controller: editlname,
                  decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  hintText: widget.pfirstname),
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
                controller: editfname,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  icon: SizedBox(width: 24),
                  border: OutlineInputBorder(),
                  hintText: widget.plastname),
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
                    border: OutlineInputBorder(),
                    hintText: widget.phonenum[i]),
                maxLength: 11,
                keyboardType: TextInputType.number,
              ),
            );
          },
          itemCount: widget.phonenum.length,
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

class Todo {
  final String last_name;
  final String first_name;
  final List<String> phone_numbers;

  Todo(this.last_name, this.first_name, this.phone_numbers);
}
