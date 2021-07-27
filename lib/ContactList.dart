import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_mobileapp/API.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:convert';
import './Model/data_model.dart';
import './Contact/newContact.dart';
import 'API.dart';
import 'Auth/token.dart';
import './Contact/displayContact.dart';

class ViewContact extends StatefulWidget {
  @override
  _ViewContactState createState() => _ViewContactState();
}


Random random = new Random();
int limit = random.nextInt(10);

class _ViewContactState extends State<ViewContact> {
  late Future<Contacts> futureContacts;
  List contacts = [];
  bool isLoading = false;
  var keyRefresh = GlobalKey<RefreshIndicatorState>();

  
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
        backgroundColor: Colors.redAccent.shade100,
        leading: Center(),
        title:Text("Contacts",
            style: TextStyle(fontSize: 20, color: Colors.black)),
      ),
      body: RefreshIndicator(
        key: keyRefresh,
        onRefresh: refreshList,
        child: getBody(),
      ),
      backgroundColor: Colors.blue[50],
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
          child: CircularProgressIndicator());
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
  //  _searchBar() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: TextField(
  //       decoration: InputDecoration(
  //         hintText: 'Search....'
  //       ),
  //       // onChanged: (text) {
  //       //   text = text.toLowerCase();
  //       //   item = item.where((item) {
  //       //     var notetitle = item["firstname"].toLowerCase();
  //       //     return notetitle.contains(text);
  //       //   });
          
  //       // },
  //     ),
  //   );
  // }
  Widget getCard(item) {
    String firstname = item["firstname"].substring(0, 1).toUpperCase() + item["firstname"].substring(1).toLowerCase();
    Color color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    String lastname = item["lastname"].substring(0, 1).toUpperCase() + item["lastname"].substring(1).toLowerCase();
    var initalsName = item['firstname'].substring(0, 1).toUpperCase() + item['lastname'].substring(0, 1).toUpperCase();
    String id = item["_id"];
    List<dynamic> list =item["phonenumbers"];
    
     
    showSnackbar() {
      String x = firstname + " " + lastname +  " deleted";
      Toast.show(x, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.grey, textColor: Colors.black);
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
          color: Colors.blue[50],
            child: Padding(
          padding: const EdgeInsets.all(0),
          child: ListTile(
            onTap: ()  {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Display(id: id, firstnames: firstname, lastnames: lastname, phonenum: list),
                ),
              );
            },
            leading: CircleAvatar(
              child: Text(
                initalsName,
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
              backgroundColor: color,
              radius: 15.0,
            ),
            title: Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      firstname + " " + lastname,
                      style: TextStyle(fontSize: 17, color: Colors.black87),
                    ),
                    width: 200,
                    height: 35,
                  ),
                  SizedBox(height: 10),   
              ]),
            ].toList(),
        )),
      )),
    );
  }
}