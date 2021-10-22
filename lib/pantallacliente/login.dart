import 'dart:convert';
import 'package:lavaupar/pantallacliente/principalusuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lavaupar/widgets/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var usuarior;
  var claver;
  String ingreso = '';

  @override
  Widget build(BuildContext context) {
    TextEditingController usuario = TextEditingController();
    TextEditingController clave = TextEditingController();

    return Scaffold(
      backgroundColor: fondoazuloscuro,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(color: Colors.green),
                controller: usuario,
                decoration: InputDecoration(hintText: "Digite el Usuario"),
              ),
              TextField(
                style: TextStyle(color: Colors.green),
                controller: clave,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Digite la Contraseña",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    ingresar(usuario.text, clave.text);
                  },
                  splashColor: Colors.transparent,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.login)),
            ],
          ),
        ),
      ),
    );
  }

  void ingresar(idusuario, contrasena) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarlogueo.php');
    var response = await http.post(url, body: {
      'idusuario': idusuario,
      'contrasena': contrasena
    }).timeout(const Duration(seconds: 90));

    var datos = jsonDecode(response.body);

    if (datos != 0) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MyAppp(datos[0]['idusuario'],datos[0]['tipousuario'],
          datos[0]['nombre'],datos[0]['apellido'],datos[0]['direccion'],datos[0]['telefono'],datos[0]['contrasena'])));
      print('Bienvenido/a' +
          ' ' +
          datos[0]['nombre'] +
          ' ' +
          datos[0]['apellido']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          //title: Text('Porfavor complete todos los campos'),
          content: Text('Usuario y/o contraseña incorrectos(s)'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(_);
              },
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      );
      print('Usuario y/o contraseña incorrecto(s)');
    }
  }
}
