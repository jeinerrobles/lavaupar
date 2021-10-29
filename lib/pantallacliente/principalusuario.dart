import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lavaupar/pantallacliente/menuservicios.dart';
import 'package:lavaupar/pantallacliente/misdatos.dart';
import 'package:lavaupar/pantallacliente/servicioscliente.dart';
import 'package:lavaupar/widgets/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';



class MyAppp extends StatelessWidget {
  // This widget is the root of your application.
  final String idusuario;
  MyAppp(this.idusuario);
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
      home: HomeScreen(this.idusuario),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String idusuario;
 
  HomeScreen(this.idusuario);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    "¡Bienvenido(a) a LavaUpar!",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
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
                        CardP("assets/icons/agendar1.png", 'Agendar servicio', fondoblanco,
                            MenuServicios(this.widget.idusuario)),
                        CardP("assets/icons/misservicios.png", 'Mis solicitudes', fondoblanco,
                            ServiciosCliente(this.widget.idusuario)),
                        CardP("assets/icons/precios.png", 'Precios',
                            fondoblanco, ServiciosCliente(this.widget.idusuario)),

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

  void enviardatoscliente(idusuario) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarpersona.php');
    var response = await http.post(url, body: {'idusuario': idusuario});

    var datos = jsonDecode(response.body);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                MisDatos(widget.idusuario, datos[0]['nombre'], datos[0]['apellido'],
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
