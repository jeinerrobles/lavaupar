import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lavaupar/login/login.dart';
import 'package:lavaupar/pantallaadmin/consultarusuarios.dart';
import 'package:lavaupar/pantallacliente/menu.dart';
import 'package:lavaupar/pantallaadmin/precios.dart';
import 'package:lavaupar/pantallacliente/precioscliente.dart';
import 'package:lavaupar/pantallacliente/servicioscliente.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lavaupar',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Login(),
    );
  }
}
