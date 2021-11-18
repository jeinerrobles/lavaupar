import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lavaupar/pantallaadmin/consultarusuarios.dart';
import 'package:lavaupar/pantallaadmin/precios.dart';
import 'package:lavaupar/pantallaadmin/serviciosenproceso.dart';
import 'package:lavaupar/pantallaadmin/serviciospendientes.dart';
import 'package:lavaupar/widgets/constants.dart';

import '../main.dart';



class PrincipalAdmin extends StatelessWidget {

  final String idusuario;
  final String nombre;

  PrincipalAdmin(this.idusuario, this.nombre);
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
      home: HomeScreen( this.idusuario, this.nombre),
    );
  }
}

class HomeScreen extends StatelessWidget {

  final String idusuario;
  final String nombre;

  HomeScreen(this.idusuario, this.nombre);
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
                    "¡Bienvenido(a),"+' '+this.nombre+'!',
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
                        CardP("assets/icons/programar.png", 'Servicios solicitados',
                            fondoblanco, ServiciosPendientes()),
                        CardP("assets/icons/lavadora.png", 'En lavanderia', 
                            fondoblanco, ServiciosEnProceso()),
                        CardP("assets/icons/precios.png", 'Modificar precios',
                            fondoblanco, Precio()),
                        CardP("assets/icons/usuarios.png",'Consultar usuarios',
                            fondoblanco, ConsultarUsuarios()),
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
                     print('Sesión cerrada');
              },
              backgroundColor: Colors.red,
              tooltip: 'Salir',
              child: Icon(Icons.logout)),
         
        ]),
      ],
    );
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
