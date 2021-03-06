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

  int _num = 0;

  void addContact() {
    List<String> phonenum = <String>[];

    for (int i = 0; i < _num; i++) {
      phonenum.add(_phonenumbers[i].text);
    }
    setState(() {
      createContact(_lastname.text, _firstname.text, phonenum);
    });
    _lastname.clear();
    _firstname.clear();
    for (int i = 0; i < _num; i++) {
      _phonenumbers[i].clear();
      }
    final toast = SnackBar(
      content: Text("Succesfuly added",
          style: TextStyle(fontSize: 17, color: Colors.white)),
      backgroundColor: Colors.blue[40],
    );
    ScaffoldMessenger.of(context).showSnackBar(toast);
  }

  void addphone() {
    setState(() {
      _num++;
      _phonenumbers.insert(0, TextEditingController());
    });
  }
  void subtractphone() {
    setState(() {
      _num--;
      _phonenumbers.insert(0, TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Contact", style: TextStyle(color: Colors.black, fontSize: 20)),
        leading: TextButton(   
          child: Icon(Icons.list, color: Colors.black, size: 35,),
          onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ViewContact(),
                ),
              );
          },
        ),
        leadingWidth: 50,
        backgroundColor: Colors.redAccent.shade100),
        backgroundColor: Colors.blue[50],
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
        Padding(padding: EdgeInsets.all(15),
        child: CircleAvatar(
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image(
              image: AssetImage('lib/Contact/user.png'),
            ),
          ),
          backgroundColor: Colors.blue[50],
          radius: 70,
        )),
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
                  icon: Icon(Icons.person, color: Colors.black),
                  border: OutlineInputBorder(),
                  labelText: "Firstname"),
                  style: TextStyle(color: Colors.black, fontSize: 17, fontStyle: FontStyle.italic),
                keyboardType: TextInputType.name,
              ),
            );
          },
          itemCount: 1,
        )),
        SizedBox(height: 5),
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
                  style: TextStyle(color: Colors.black, fontSize: 17, fontStyle: FontStyle.italic),
                keyboardType: TextInputType.name,
              ),
            );
          },
          itemCount: 1,
        )),
        SizedBox(height: 20),
        Flexible(
            child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return ListTile(
              title: TextField(
                controller: _phonenumbers[i],
                decoration: InputDecoration(
                  icon: Icon(Icons.phone_android, color: Colors.black),
                  border: UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: subtractphone,
                    icon: Text("-", style: TextStyle(fontSize: 50, height: 0.75, color: Colors.red)),
                  )), 
                style: TextStyle(color: Colors.black, fontSize: 17, fontStyle: FontStyle.italic),
                maxLength: 11,
                keyboardType: TextInputType.number,
              ),
            );
          },
          itemCount: _num,
        )),
        TextButton(
          onPressed: addphone,
          child: Text( 
          " ??? add phone",
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
