import 'package:flutter/material.dart';
import 'package:flutter_mobileapp/ContactList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Auth/token.dart';


class Login {

  String email;
  String password;

  Login({required this.email,required this.password});

   factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        email: json['username'],
        password: json['password']);
  }
}


class Todo {
  final String email;
  final String password;


  Todo(this.email, this.password);
}


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isHidden = true;
  final List<Todo> _list = <Todo>[];
  Future<Login>? _futureContacts;
  String tokens = "";

  // @override
  // void initState() {
  //   super.initState();
  //   this.getToken(String username, String password);
  // }
  void _togglePasswordView () {
      setState(() {
        _isHidden = !_isHidden;
      });
    }


  Future<Login> getToken(String email, String password) async {
    Uri url = Uri.http('firstappdeployment.herokuapp.com', '/auth/login');
    final res = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'email' : email,
        'password' : password
      }));
      
      if (res.statusCode == 201) {
        final String token = jsonDecode(res.body)['token'];
        return Login.fromJson(jsonDecode(token));
      } else {
        throw Exception('Failed to login.');
      }
  }

  bool _isLoading = false;

//  signIn(String email, String password) async {

//    SharedPreferences sp = await SharedPreferences.getInstance();
//    Map body = {"email" : email, "password" : password};
//    Uri url = Uri.http('firstappdeployment.herokuapp.com', '/auth/login');
//     final res = await http.post(url, body: body);
//     var jResponse;
//     jResponse = jsonDecode(res.body)['token'];
//     sp.setString("token", jResponse['token']);
//     print(jResponse);



//     // if (res.statusCode == 200) {
//     //   jResponse = jsonDecode(res.body);
//     //   print(jResponse);

//     //   if (jResponse != null){
//     //     setState(() {
//     //       _isLoading = false;
//     //     });
//     //     sp.setString("token", jResponse['token']);
//     //     print(sp);
//     //     Navigator.push(
//     //         context,
//     //         MaterialPageRoute(builder: (context) => ViewContact()),
//     //       );
//     //     }
//     // }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Log in page"))),
      body: Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(25, 150, 25 ,25),
        child: TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            border: OutlineInputBorder(),
            hintText: "Email"),
            controller: _email,
            keyboardType: TextInputType.name,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 25 ,25),
        child: TextField(
          obscureText: _isHidden,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            border: OutlineInputBorder(),
            fillColor: Colors.white.withOpacity(0),
            hintText: "Password",
            suffix: InkWell(
              onTap: _togglePasswordView,
              child: Icon(
                _isHidden ? Icons.visibility : Icons.visibility_off
              ),
            )),
            controller: _password,
            keyboardType: TextInputType.visiblePassword,
          ),
        ),
        ElevatedButton(
          onPressed: _email.text == "" || _password.text == "" ? null : () {
            setState(() {
              _isLoading = true;
            });
            // signIn();
          },
          child: Text("Sign-in"),
        ),
        Center(
          child: Text(tokens.toString()),
        )
      ]));
  }
}