
import 'package:flutter/material.dart';
import 'package:flutter_mobileapp/ContactList.dart';
import 'package:flutter_mobileapp/Model/data_model.dart';
import '../API.dart';
import './newContact.dart';


class EditContact extends StatefulWidget {
  final String passid,pfirstname,plastname;
  final List<dynamic> phonenum;
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
      editphonenum = <TextEditingController>[TextEditingController(text: widget.phonenum.toString().replaceAll("[", "").replaceAll("]", ""))];
      
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
      backgroundColor: Colors.blue[40],
    );
    ScaffoldMessenger.of(context).showSnackBar(toast);
  }

  void addphone() {
    setState(() {
      _num++;
      editphonenum.insert(0, TextEditingController());
    });
  }
  void subtractphone() {
    setState(() {
      _num--;
      editphonenum.insert(0, TextEditingController());
    });
  }
  Widget getList() {
  List<dynamic> list = widget.phonenum;
  ListView myList = new ListView.builder(
    itemCount: list.length,
    itemBuilder: (context, index) {
    return new ListTile(
    title: TextField(
          controller: editfname,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            icon: Icon(Icons.person, color: Colors.black),
            border: OutlineInputBorder()),
          keyboardType: TextInputType.name,
        ),
    );
  });
  return myList;
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Contact", style: TextStyle(color: Colors.black, fontSize: 20)),
        leading: TextButton(   
          child: Icon(Icons.arrow_back, color: Colors.black, size: 30,),
          onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ViewContact(),
                ),
              );
          },
        ),
        leadingWidth: 50,
        backgroundColor: Colors.redAccent.shade100),
        backgroundColor: Colors.blue[40],
        floatingActionButton: new RaisedButton(
          color: Colors.redAccent.shade100,
          onPressed: () {
          if (editlname.text.isEmpty && editfname.text.isEmpty) {
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
              image: AssetImage('lib/Contact/user.png'),
            ),
          ),
          backgroundColor: Colors.blue,
          radius: 70,
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
                  icon: Icon(Icons.person, color: Colors.black),
                  border: OutlineInputBorder()),
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
        SizedBox(height: 5),
        Flexible(
            child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return ListTile(
              title: TextField(
                controller: editphonenum[i],
                decoration: InputDecoration(
                  icon: Icon(Icons.phone_android),
                  border: UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: subtractphone,
                    icon: Text("-", style: TextStyle(fontSize: 50, height: 0.75, color: Colors.red)),
                  )
                  ),
                maxLines: 1,
                keyboardType: TextInputType.number,
              ),
            );
          },
          itemCount: _num,
        )),
        TextButton(
          onPressed: addphone,
          child: Text( 
          " ➕ add phone",
          style: TextStyle(fontSize: 15, color: Colors.black), 
        )),
      ].toList()),
    );
  }
}

