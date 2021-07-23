import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_mobileapp/API.dart';
import 'package:flutter_mobileapp/Contact/editContact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Model/data_model.dart';
import './Contact/newContact.dart';
import 'API.dart';
import 'Auth/token.dart';
import 'Contact/editContact.dart';

class ViewContact extends StatefulWidget {
  @override
  _ViewContactState createState() => _ViewContactState();
}

var keyRefresh = GlobalKey<RefreshIndicatorState>();
Random random = new Random();
int limit = random.nextInt(10);

class _ViewContactState extends State<ViewContact> {
  late Future<Contacts> futureContacts;
  List contacts = [];
  bool isLoading = false;

  
  fetchUser() async {
    Uri url = Uri.http('firstappdeployment.herokuapp.com', '/router/get');
    http.Response res = await http.get(url, headers: {
      'Authorization': 'Bearer $token'
    });

    if (res.statusCode == 200) {
      List items = json.decode(res.body);
      setState(() {
        contacts = items;
      });
    } else {
      setState(() {
        contacts = [];
        Center(child: Text("Add List"));
      });
    }
  }
  @override
    void initState() {
      super.initState();
      
      setState(() {
        fetchUser();
      });
    
    }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 50,
        backgroundColor: Colors.redAccent.shade100,
        title: Center(child: Text("Contact List",
            style: TextStyle(fontSize: 20, color: Colors.white)),
      )),
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: keyRefresh,
        child: getBody(),
      ),
      backgroundColor: Colors.grey,
      floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.person_add),
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewContact()),
            );
          }),
      );
  }

  Future<void> refreshList() async {
    keyRefresh.currentState?.show(atTop: true);
    await Future.delayed(Duration(milliseconds: 0));
    setState(() {
      fetchUser();
    });
  }

  Widget getBody() {
    Center(child: Icon(Icons.add));
    if (contacts.contains(null) || contacts.length <= 0 || isLoading) {
      return Center(
          child: Text("Empty",
              style: TextStyle(fontSize: 20, color: Colors.black)));
    }
    return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return getCard(contacts[index]);
        });
  }

  Widget deleteBackGround() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right:20),
      color: Colors.red,
      child: Icon(Icons.delete, color: Colors.white),
    );
  }
  
  Widget getCard(item) {
    String firstname = item["firstname"].substring(0, 1).toUpperCase() +
        item["firstname"].substring(1).toLowerCase();

    Color color =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

    String lastname = item["lastname"].substring(0, 1).toUpperCase() +
        item["lastname"].substring(1).toLowerCase();

    var initalsName = item['firstname'].substring(0, 1).toUpperCase() +
        item['lastname'].substring(0, 1).toUpperCase();

    String id = item["_id"];
    final nums = item['phonenumbers'];
    
     
    showSnackbar() {
      final toast = SnackBar( content: Text(firstname + " " + lastname +  " deleted", style: TextStyle(fontSize: 17, color: Colors.red)),
                    backgroundColor: Colors.black);
                  ScaffoldMessenger.of(context).showSnackBar(toast);
    }
    showSnackbar2() {
      final toast = SnackBar( content: Text("Delete cancelled ", style: TextStyle(fontSize: 17, color: Colors.black)),
                    backgroundColor: Colors.redAccent.shade100);
                  ScaffoldMessenger.of(context).showSnackBar(toast);
    }

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        
        information(BuildContext context, String message) {
          return showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(message),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      deleteContact(id.toString());
                      refreshList();
                      showSnackbar();
                    },
                    child: Text("Yes", style: TextStyle(color: Colors.red, fontSize: 20)),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        refreshList();
                        showSnackbar2();
                      },
                      child: Text("No", style: TextStyle(color: Colors.red, fontSize: 20))
                  ),
                ],
              );
            },
        );
      }
      information(context, "Are you sure you want to delete?");
    },
      background: deleteBackGround(),
      child: Card(
        color: Colors.white,
          child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListTile(
          onTap: ()  {
           Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => EditContact(passid: id, pfirstname: firstname, plastname: lastname, phonenum: nums),
              ),
            );
          },
            leading: CircleAvatar(
              child: Text(
                initalsName,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              backgroundColor: color,
              radius: 35.0,
            ),
            title: Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      firstname + " " + lastname,
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                    width: 200,
                    height: 35,
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(top: 2),
                    child: Text(
                      "Contact #: \n" + nums.toString() + "\n",
                      style: TextStyle(fontSize: 12.5, color: Colors.blueGrey),
                    ),
                    width: 200,
                  ),
                ]),
              ],
            )),
      )),
    );
  }
}