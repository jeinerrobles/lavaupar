import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lavaupar/pantallacliente/lavadoenseco.dart';
import 'package:lavaupar/pantallacliente/tinturado.dart';
import 'package:lavaupar/widgets/constants.dart';
import 'lavadoenfrio.dart';

class MenuServicios extends StatefulWidget {
  final String idusuario;
  MenuServicios(this.idusuario);

  @override
  _MenuServiciosState createState() => _MenuServiciosState();
}

class _MenuServiciosState extends State<MenuServicios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fondoazuloscuro,
       appBar: AppBar(
        title: Text('Servicios'),
        backgroundColor: fondoazuloscuro,
      ),
        body: ListView(
          children: <Widget>[
            lavadoEnFrio(),
            lavadoEnSeco(),
            tinturado(),
          ],
        ));
  }


  Card lavadoEnFrio() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.only(left: 30,right: 30, top: 20),
      elevation: 10,
      child: new InkWell(
      child: Column(
        children: <Widget>[
           Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage("assets/icons/enfrio.png"),
                ),
              ),
              padding: EdgeInsets.all(10),
            ),
          Text('SERVICIO DE LAVADO EN FRIO',style: TextStyle(color: Colors.blue ,fontWeight: FontWeight.w400))
        ],
      ),
      onTap: () {
          enviarDireccionLavadoEnFrio(widget.idusuario);
        },
    ),
    );
  }
  Card lavadoEnSeco() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.only(left: 30,right: 30, top: 20),
      elevation: 10,
      child: new InkWell(
      child: Column(
        children: <Widget>[
           Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage("assets/icons/seco.png"),
                ),
              ),
              padding: EdgeInsets.all(10),
            ),
          Text('SERVICIO DE LAVADO EN SECO',style: TextStyle(color: Colors.orange,fontWeight: FontWeight.w400))
        ],
      ),
      onTap: () {
          enviarDireccionLavadoEnSeco(widget.idusuario);
        },
    ),
    );
  }

   Card tinturado() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.only(left: 30,right: 30, top: 20),
      elevation: 10,
      child: new InkWell(
      child: Column(
        children: <Widget>[
           Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage("assets/icons/tintura.png"),
                ),
              ),
              padding: EdgeInsets.all(10),
            ),
          Text('SERVICIO DE TINTURADO',style: TextStyle(color: Colors.black ,fontWeight: FontWeight.w400))
        ],
      ),
      onTap: () {
          enviarDireccionTinturado(widget.idusuario);
        },
    ),
    );
  }


  void enviarDireccionLavadoEnFrio(idusuario) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarpersona.php');
    var response = await http.post(url, body: {'idusuario': idusuario});

    var datos = jsonDecode(response.body);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                LavadoEnFrio(idusuario, datos[0]['direccion'])));
  }
  void enviarDireccionLavadoEnSeco(idusuario) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarpersona.php');
    var response = await http.post(url, body: {'idusuario': idusuario});

    var datos = jsonDecode(response.body);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                LavadoEnSeco(idusuario, datos[0]['direccion'])));
  }
  void enviarDireccionTinturado(idusuario) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarpersona.php');
    var response = await http.post(url, body: {'idusuario': idusuario});

    var datos = jsonDecode(response.body);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                Tinturado(idusuario, datos[0]['direccion'])));
  }
}
