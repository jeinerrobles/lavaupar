import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lavaupar/pantallaadmin/datosusuario.dart';
import 'package:lavaupar/peticiones/adminhttp.dart';
import 'package:lavaupar/peticiones/clienteshttp.dart';
import 'package:lavaupar/widgets/constants.dart';

class ConsultarUsuarios extends StatefulWidget {

  @override
  _ConsultarUsuariosState createState() => _ConsultarUsuariosState();
}

class _ConsultarUsuariosState extends State<ConsultarUsuarios> {
  var colorestado = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fondoazuloscuro,
       appBar: AppBar(
        title: Text('Clientes'),
        backgroundColor: fondoazuloscuro,
      ),
        body:  FutureBuilder(
    future: listarUsuariosPost(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.done:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          return snapshot.data != null
      ? ListView.builder(
        itemCount: snapshot.data.length == 0 ? 0 : snapshot.data.length,
        itemBuilder: (context, posicion) {
          return Card(
          child: ListTile(
            onTap: () {
              consultarusuario(snapshot.data[posicion].idusuario);
        },
    leading: CircleAvatar(
          backgroundImage: AssetImage("assets/icons/perfil.png"),
        ), 
    title: Text(snapshot.data[posicion].nombre),
    trailing: Text('TI/C.C: '+snapshot.data[posicion].idusuario,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    
          ),
      );
        })
      : Text('Sin Datos');

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  ),
          );
  }
  void consultarusuario(idusuario) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarpersona.php');
    var response = await http.post(url, body: {'idusuario': idusuario});

    var url2 = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarcantidadsolicitudescliente.php');
    var response2 = await http.post(url2, body: {'idusuario': idusuario});

    var datos = jsonDecode(response.body);
    var cantidad = jsonDecode(response2.body);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                DatosUsuario(datos[0]['idusuario'], datos[0]['nombre'], datos[0]['email'],
                 datos[0]['direccion'], datos[0]['telefono'],  int.parse(cantidad[0]['cantidad']))));
                 
  }
}

