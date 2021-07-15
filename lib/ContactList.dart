import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_mobileapp/API.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Model/data_model.dart';
import './Contact/newContact.dart';
import './Contact/searchList.dart';
import 'API.dart';
import 'Dialogue.dart';

class ViewContact extends StatefulWidget {
  @override
  _ViewContactState createState() => _ViewContactState();
}

var keyRefresh = GlobalKey<RefreshIndicatorState>();
Random random = new Random();
int limit = random.nextInt(10);

class _ViewContactState extends State<ViewContact> {
  Dialogue dialogs = new Dialogue();
  late Future<Contacts> futureContacts;
  List contacts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    Uri url = Uri.http('firstappdeployment.herokuapp.com', '/router/get');
    http.Response res = await http.get(url, headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.brown.shade400,
        title: Text("Contact List",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        // actions: [
        //   FlatButton(child: Icon(Icons.search), onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => SearchList()));
        //   }),
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: keyRefresh,
        child: getBody(),
      ),
      backgroundColor: Colors.orange.shade50,
      floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.person_add),
          backgroundColor: Colors.brown.shade400,
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

    // void _delete() {
    //   setState(() {
    //     deleteContact(id.toString());
    //   });
    // }

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        dialogs.information(context, "Are you sure you want to delete?");
        //deleteContact(id.toString());
      
        information (BuildContext context, String message) {
        return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(message),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    contacts.removeAt(item["_id"]);
                    deleteContact(item["_id"].toString());
                  },
                  child: Text("Yes"),
                ),
                FlatButton(
                    onPressed: () => Navigator.pop(context), child: Text("No"))
              ],
            );
          },
        );
       }
    },
      child: Card(
        color: Colors.red[200],
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
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
class Dialogue {
  information(BuildContext context, String message) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                deleteContact("_id".toString());
              },
              child: Text("Yes"),
            ),
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text("No"))
          ],
        );
      },
    );
  }
}