import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  var data;

  Future getData() async {
    final url = 'http://192.168.0.105:4000/books';

    try {
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken();
      print('$token');
      final response = await http.get(
        Uri.parse(url),
        // Send authorization headers to the backend.
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('respond : ${response.body}');
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Text('$data'),
      floatingActionButton: FloatingActionButton(
        onPressed: getData,
        child: Icon(Icons.add),
      ),
    );
  }
}
