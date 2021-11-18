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
        body: Stack(
          children: <Widget>[
            SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   SizedBox(
                      height: 15,
                    ),
                  Text(
                      "Seleccione el servicio que desea solicitar y el dia, nosotros nos encargamos del resto!",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                 SizedBox(
                      height: 40,
                    ),
                     Container(
                        width: 150,
                        alignment: Alignment.center,
                      child: Card(
                          margin: EdgeInsets.only(),
                          elevation: 2.0,
                          color: fondoblanco,
                          child: new InkWell(
                            highlightColor: Colors.white.withAlpha(30),
                            splashColor: Colors.white.withAlpha(20),
                            child: new Column(children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              new Image(
                                  image: new AssetImage("assets/icons/enfrio.png"),
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center),
                              SizedBox(
                                height: 10,
                              ),
                              new Center(
                                child: new Text('LAVADO EN FRIO',style: TextStyle( color: Colors.blue)),
                              )
                            ]),
                            onTap: () {
                              enviarDireccionLavadoEnFrio(widget.idusuario);
                            },
                          ),
                      ),
                        ), 
                        SizedBox(
                                height: 20,
                              ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        Card(
                          elevation: 2.0,
                          color: fondoblanco,
                          child: new InkWell(
                            highlightColor: Colors.white.withAlpha(30),
                            splashColor: Colors.white.withAlpha(20),
                            child: new Column(children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              new Image(
                                  image: new AssetImage("assets/icons/seco.png"),
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center),
                              SizedBox(
                                height: 10,
                              ),
                              new Center(
                                child: new Text('LAVADO EN SECO',style: TextStyle( color: Colors.orange)),
                              )
                            ]),
                            onTap: () {
                              enviarDireccionLavadoEnSeco(widget.idusuario);
                            },
                          ),
                        ),  
                        Card(
                          elevation: 2.0,
                          color: fondoblanco,
                          child: new InkWell(
                            highlightColor: Colors.white.withAlpha(30),
                            splashColor: Colors.white.withAlpha(20),
                            child: new Column(children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              new Image(
                                  image: new AssetImage("assets/icons/tintura.png"),
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center),
                              SizedBox(
                                height: 10,
                              ),
                              new Center(
                                child: new Text('TINTURADO',style: TextStyle( color: Colors.black)),
                              )
                            ]),
                            onTap: () {
                              enviarDireccionTinturado(widget.idusuario);
                            },
                          ),
                        ), 

                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          ],
        ));
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

