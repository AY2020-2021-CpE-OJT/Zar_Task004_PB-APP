import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobileapp/ContactList.dart';
import 'package:flutter_mobileapp/Model/data_model.dart';
import '../API.dart';

class NewContact extends StatefulWidget {
  const NewContact({Key? key}) : super(key: key);

  @override
  _NewContactState createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  Future<Contacts>? _futureContacts;
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  List<TextEditingController> _phonenumbers = <TextEditingController>[
    TextEditingController()
  ];
  final List<Todo> _list = <Todo>[];

  int _num = 0;


  
  void addContact() {
    List<String> phonenum = <String>[];

    for (int i = 0; i < _num; i++) {
      phonenum.add(_phonenumbers[i].text);
    }
    setState(() {
      _list.insert(0, Todo(_lastname.text, _firstname.text, phonenum));
      _futureContacts = createContact(_lastname.text, _firstname.text, phonenum);
    });

    for (int i = 0; i < _num; i++) {
      _lastname.clear();
      _firstname.clear();
      _phonenumbers[i].clear();
      }

    final toast = SnackBar(
      content: Text("Succesfuly added",
          style: TextStyle(fontSize: 17, color: Colors.white)),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(toast);
  }

  void add() {
    setState(() {
      _num++;
      _phonenumbers.insert(0, TextEditingController());
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Contact", style: TextStyle(color: Colors.black, fontSize: 20)),
        backgroundColor: Colors.redAccent.shade100),
        backgroundColor: Colors.white,
        floatingActionButton: new RaisedButton(
          color: Colors.redAccent.shade100,
          onPressed: () {
          if (_lastname.text.isEmpty && _firstname.text.isEmpty) {
            final toast = SnackBar( content: Text("Must Enter Empty Fields!", style: TextStyle(fontSize: 17, color: Colors.red)),
                    backgroundColor: Colors.black);
                  ScaffoldMessenger.of(context).showSnackBar(toast);
                } else {
                  addContact();
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
                controller: _lastname,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: "Firstname"),
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
                controller: _firstname,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  icon: SizedBox(width: 24),
                  border: OutlineInputBorder(),
                  labelText: "Lastname"),
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
                controller: _phonenumbers[i],
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                    labelText: "Phone number"),
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

class Todo {
  final String last_name;
  final String first_name;
  final List<String> phone_numbers;

  Todo(this.last_name, this.first_name, this.phone_numbers);
}
