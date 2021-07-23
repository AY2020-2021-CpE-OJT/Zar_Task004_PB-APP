
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import './Model/data_model.dart';
import 'Auth/token.dart';

Future<Contacts> createContact(
    String firstname, String lastname, List<dynamic> phonenumbers) async {
  Uri url = Uri.http('firstappdeployment.herokuapp.com', '/router/create');
  
  final res = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'Bearer $token'
      },
      body: jsonEncode(<dynamic, dynamic>{
        'firstname': firstname,
        'lastname': lastname,
        'phonenumbers': phonenumbers,
      }));
  if (res.statusCode == 201) {
    final String resposeString = res.body;
    return Contacts.fromJson(jsonDecode(resposeString));
  } else {
    throw Exception('Failed to create Contact.');
  }
}
Future<Contacts> deleteContact(String id) async {
  Uri url = Uri.http('firstappdeployment.herokuapp.com', '/router/delete/$id');
  final res = await http.delete(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization' : 'Bearer $token'
  });
  
  if (res.statusCode == 200) {
    return Contacts.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to create Contact.');
  }
}

Future<Contacts> editContact(String id, String firstname, String lastname, List<dynamic> phonenumbers) async {
  Uri url = Uri.http('firstappdeployment.herokuapp.com', '/router/edit/$id');
  
  final res = await http.put(url,
      headers: <String, String>{
        'Authorization' : 'Bearer $token'
      },
      body: jsonEncode(<dynamic, dynamic>{
        'firstname': firstname,
        'lastname': lastname,
        'phonenumbers': phonenumbers,
      }));

  if (res.statusCode == 200) {
    final String resposeString = res.body;
    return Contacts.fromJson(jsonDecode(resposeString));
  } else {
    throw Exception('Failed to create Contact.');
  }
}
