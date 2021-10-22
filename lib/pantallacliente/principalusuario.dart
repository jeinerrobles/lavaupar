import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lavaupar/pantallacliente/servicioscliente.dart';
import 'package:lavaupar/widgets/constants.dart';
import 'package:lavaupar/pantallacliente/lavadoenfrio.dart';

import '../main.dart';



class MyAppp extends StatelessWidget {
  // This widget is the root of your application.
  final String idusuario;
  final String tipousuario;
  final String nombre;
  final String apellido;
  final String direccion;
  final String telefono;
  final String contrasena;

  MyAppp(this.idusuario, this.tipousuario, this.nombre, this.apellido, this.direccion, this.telefono, this.contrasena);
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
      home: HomeScreen(this.idusuario, this.tipousuario, this.nombre, this.apellido, this.direccion, this.telefono, this.contrasena),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String idusuario;
  final String tipousuario;
  final String nombre;
  final String apellido;
  final String direccion;
  final String telefono;
  final String contrasena;

  HomeScreen(this.idusuario, this.tipousuario, this.nombre, this.apellido, this.direccion, this.telefono, this.contrasena);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      //bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
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
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: fondoazuloscuro,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ),
                  Text(
                    "¡Bienvenido(a) a LavaUpar!",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  //SearchBar(),
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
                        card("assets/icons/agendar.png", 'Agendar servicio',
                            fondoblanco, LavadoEnFrio(this.idusuario,this.direccion)),
                        card("assets/icons/citas.png", 'Mis solicitudes', fondoblanco,
                            ServiciosCliente(this.idusuario)),
                        card("assets/icons/perfil.png", 'Precios',
                            fondoblanco, LavadoEnFrio(this.idusuario,this.direccion)),
                        card(
                            "assets/icons/informacion.png",
                            'Mis datos',
                            fondoblanco,
                            LavadoEnFrio(this.idusuario,this.direccion)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      persistentFooterButtons: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyApp()));
              },
              backgroundColor: Colors.red,
              tooltip: 'Salir',
              child: Icon(Icons.logout)),
         
        ]),
      ],
    );
  }
}

class card extends StatelessWidget {
  final imagen;
  final texto;
  final color;
  final ruta;
  const card(this.imagen, this.texto, this.color, this.ruta);

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
