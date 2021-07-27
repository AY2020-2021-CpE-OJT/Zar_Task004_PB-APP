
import 'package:flutter/material.dart';
import 'package:flutter_mobileapp/ContactList.dart';
import 'package:flutter_mobileapp/Model/data_model.dart';
import '../API.dart';
import './newContact.dart';
import 'package:toast/toast.dart';
import './displayContact.dart';


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


  bool _isVisible = true;
  bool _isVisible2 = false;
      void showToast() {
	
      setState(() {
	
        _isVisible = !_isVisible;
        _isVisible2 = !_isVisible2;
	
      });
	
    }


  
  @override
  void initState() {
    super.initState();
    
      editfname = TextEditingController(text: widget.pfirstname);
      editlname = TextEditingController(text: widget.plastname);
  }
  
  void addContact() {
    List<String> phonenum = <String>[];

    
    for (int i = 0; i < _num; i++) {
      phonenum.add(editphonenum[i].text);
    }
    if (_num == 0) {
      editContact(widget.passid, editfname.text, editlname.text, widget.phonenum);
    } else {
    setState(() {
      editContact(widget.passid, editfname.text, editlname.text, phonenum);
      });
    }
                  
    for (int i = 0; i < _num; i++) {
      editlname.clear();
      editfname.clear();
      editphonenum[i].clear();
      }

    String x = "Edit Succesful";
    Toast.show(x, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.grey, textColor: Colors.black);

    
  }

  void addeditphone() {
    setState(() {
      _num+=widget.phonenum.length;
      widget.phonenum.forEach((var str) {
        editphonenum.insert(0, TextEditingController(text: str));
      });
    });
  }
  void hidenumbers() {
    setState(() {
      _num=0;
      widget.phonenum.forEach((var str) {
        editphonenum.insert(0, TextEditingController(text: str));
      });
    });
  }
  void addphone() {
    setState(() {
      _num++;
        editphonenum.insert(0, TextEditingController());
      });
  }
  void subtracteditphone() {
    setState(() {
      _num--;
     widget.phonenum.forEach((var str) {
        editphonenum.insert(0, TextEditingController(text: str));
      });
    });
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
        Padding( padding: EdgeInsets.all(0),
        child: CircleAvatar(
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image(
              width: 180,
              fit: BoxFit.fill,
              alignment: Alignment.center,
              image: AssetImage('lib/Contact/edit.png'),
            ),
          ),
          backgroundColor: Colors.grey[50],
          radius: 80,
        )),
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
                controller: editlname,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  icon: SizedBox(width: 24),
                  border: OutlineInputBorder()),
                  style: TextStyle(color: Colors.black, fontSize: 17, fontStyle: FontStyle.italic),
                keyboardType: TextInputType.name,
              ),
            );
          },
          itemCount: 1,
        )),
        SizedBox(height: 0),
        Flexible(
          child: ListView.builder(
            itemCount: _num,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: TextField(
                  controller: editphonenum[index],
                  decoration: InputDecoration(
                  icon: Icon(Icons.phone_android, color: Colors.black),
                  border: UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: subtracteditphone,
                    icon: Text("-", style: TextStyle(fontSize: 50, height: 0.75, color: Colors.red)),
                  )),
                  style: TextStyle(color: Colors.black, fontSize: 17, fontStyle: FontStyle.italic),
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                ));
            })),
            Visibility(
              visible: _isVisible,
              child: TextButton(
              onPressed: () {
                if (_num != widget.phonenum.length) {
                  addeditphone();
                  _isVisible = false;
                  _isVisible2 = true;
                } else if (_num == widget.phonenum.length){
                  String msg = "No other existing numbers";
                    Toast.show(msg, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                }
              },
              child: Text( 
              " SHOW NUMBERS",
              style: TextStyle(fontSize: 15, color: Colors.black, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, height: 1, decoration: TextDecoration.underline
              ),
            )
          )),
          Visibility(
              visible: _isVisible2,
              child: TextButton(
              onPressed: () {
                if (_num == widget.phonenum.length) {
                  hidenumbers();
                  _isVisible2 = false;
                  _isVisible = true;
                }
              },
              child: Text( 
              " HIDE NUMBERS",
              style: TextStyle(fontSize: 15, color: Colors.black, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, height: 1, decoration: TextDecoration.underline
              ),
            )
          )),
          TextButton(
              onPressed: () {
                if (_num != widget.phonenum.length -1) {addphone();}else {}
              },
              child: Text( 
              " ➕ add phone",
              style: TextStyle(fontSize: 15, color: Colors.black
              ), 
            )
          ),
      ]),
    );
  }
}

