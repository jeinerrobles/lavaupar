import 'package:flutter/material.dart';
import 'package:lavaupar/pantallacliente/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Programacion Movil',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Login(),
    );
  }
}