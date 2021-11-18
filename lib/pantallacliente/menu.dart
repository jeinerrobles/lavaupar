import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lavaupar/pantallacliente/lavadoenfrio.dart';
import 'package:lavaupar/pantallacliente/lavadoenseco.dart';
import 'package:lavaupar/pantallacliente/tinturado.dart';
import 'package:lavaupar/widgets/constants.dart';

class MenuServicios2 extends StatefulWidget {
  final String idusuario;
  MenuServicios2(this.idusuario);

  @override
  _MenuServiciosState createState() => _MenuServiciosState();
}

class _MenuServiciosState extends State<MenuServicios2> {
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
            miCard(),
            enfrio(),
            miCardDesign(),
            enseco(),
            cardTinturado(),
            tinturado()
          ],
        ));
  }

  Card miCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('LAVADO EN FRIO'),
            subtitle: Text(
                'Servicio de lavado en frio por libras, secado + doblado  para ropa interior, medias, camisetas, sabanas, fundas y toallas.'
                ,style: TextStyle( color: Colors.white)
                ),
            leading: Icon(Icons.info_outline,  color: Colors.white),
          ),
          
        ],
      ),
    );
  }

  Card enfrio() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: new InkWell(
         child: new Column(children: <Widget>[
          Image(
            image: new AssetImage("assets/icons/enfrio.png"),
            height: 120,
            width: 120,
          ),
          Container(
           child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Solicitar lavado en frio'),
                    onPressed: () {
                      enviarDireccionLavadoEnFrio(widget.idusuario);
                    }),
                    padding: EdgeInsets.all(10),
          ),
        ],
      ),
    ));
  }
 Card enseco() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: new InkWell(
         child: new Column(children: <Widget>[
          Image(
            image: new AssetImage("assets/icons/seco.png"),
            height: 120,
            width: 120,
          ),
          Container(
            child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Solicitar lavado en seco'),
                    onPressed: () {
                      enviarDireccionLavadoEnSeco(widget.idusuario);
                    }),
                    padding: EdgeInsets.all(10),
          ),
        ],
      ),
    ));
  }
  Card tinturado() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: new InkWell(
         child: new Column(children: <Widget>[
          Image(
            image: new AssetImage("assets/icons/tintura.png"),
            height: 120,
            width: 120,
          ),
          Container(
           child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Solicitar tinturado'),
                    onPressed: () {
                      enviarDireccionTinturado(widget.idusuario);
                    }),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    ));
  }

  Card miCardDesign() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      color: Colors.orange,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('LAVADO EN SECO'),
            subtitle: Text(
                'Servicio de lavado en seco + planchado al vapor.'
                ,style: TextStyle( color: Colors.white)
                ),
            leading: Icon(Icons.info_outline, color: Colors.white),
          ),
          
        ],
      ),
    );
  }
  Card cardTinturado() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      color: Colors.deepPurple,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('TINTURADO'),
            subtitle: Text(
                'Servicio de tinturado y limpieza impecable.'
                ,style: TextStyle( color: Colors.white)
                ),
            leading: Icon(Icons.info_outline, color: Colors.white),
          ),
          
        ],
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