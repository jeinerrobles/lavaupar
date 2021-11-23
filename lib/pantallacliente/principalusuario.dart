import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lavaupar/pantallacliente/menu.dart';
import 'package:lavaupar/pantallacliente/menuservicios.dart';
import 'package:lavaupar/pantallacliente/misdatos.dart';
import 'package:lavaupar/pantallacliente/precioscliente.dart';
import 'package:lavaupar/pantallacliente/servicioscliente.dart';
import 'package:lavaupar/widgets/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';



class MyAppp extends StatelessWidget {
  final String idusuario;
  final String nombre;
  MyAppp(this.idusuario, this.nombre);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LavaUpar',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: fondoblanco,
        textTheme: Theme.of(context).textTheme.apply(displayColor: fondoblanco),
      ),
      home: HomeScreen(this.idusuario, this.nombre),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String idusuario;
  final String nombre;
  HomeScreen(this.idusuario, this.nombre);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; 
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: fondoazuloscuro,
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => MyApp()));
                        print('Sesión cerrada');
                      },
                      tooltip: 'Salir',
                      icon: const Icon(Icons.logout),
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "¡Bienvenido(a),"+' '+this.widget.nombre+'!',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CardP("assets/icons/agendar1.png", 'Agendar servicio', fondoblanco,
                            MenuServicios2(this.widget.idusuario)),
                        CardP("assets/icons/misservicios.png", 'Mis solicitudes', fondoblanco,
                            ServiciosCliente(this.widget.idusuario)),
                        CardP("assets/icons/precios.png", 'Precios',
                            fondoblanco, PrecioCliente()),

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
                                  image: new AssetImage("assets/icons/informacionpersonal.png"),
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center),
                              SizedBox(
                                height: 10,
                              ),
                              new Center(
                                child: new Text('Mis datos'),
                              )
                            ]),
                            onTap: () {
                              enviardatoscliente(widget.idusuario);
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
      ),
    );
  }

  void enviardatoscliente(idusuario) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarpersona.php');
    var response = await http.post(url, body: {'idusuario': idusuario});

    var datos = jsonDecode(response.body);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                MisDatos(widget.idusuario, datos[0]['nombre'], datos[0]['email'],
                 datos[0]['direccion'], datos[0]['telefono'])));
  }
}

class CardP extends StatelessWidget {
  final imagen;
  final texto;
  final color;
  final ruta;
  const CardP(this.imagen, this.texto, this.color, this.ruta);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: this.color,
      child: new InkWell(
        highlightColor: Colors.white.withAlpha(30),
        splashColor: Colors.white.withAlpha(20),
        child: new Column(children: <Widget>[
          SizedBox(
            height: 40,
          ),
          new Image(
              image: new AssetImage(this.imagen),
              height: 100,
              width: 100,
              alignment: Alignment.center),
          SizedBox(
            height: 10,
          ),
          new Center(
            child: new Text(this.texto),
          )
        ]),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return this.ruta;
          }));
        },
      ),
    );
  }
}
