import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lavaupar/pantallacliente/principalusuario.dart';
import 'package:lavaupar/peticiones/clienteshttp.dart';
import 'package:lavaupar/widgets/messagewidget.dart';
import 'package:http/http.dart' as http;

class CreateAccount extends StatefulWidget {
  final String email;
  final String contrasena;
  final String nombre;

  CreateAccount(this.nombre, this.email, this.contrasena);
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool showSpinner = false;
 var usuarior;
    TextEditingController idusuario = TextEditingController();
    TextEditingController nombre = TextEditingController();
    TextEditingController direccion = TextEditingController();
    TextEditingController telefono = TextEditingController();

@override
  void initState() {
    nombre = TextEditingController(text:widget.nombre);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff251F34),
        ),
        backgroundColor: Color(0xff251F34),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerTextos('Nombre y apellido*',nombre,'assets/icons/nombre.png',TextInputType.text),
              ContainerTextos('Identificación*',idusuario,'assets/icons/id.png',TextInputType.number),
              ContainerTextos('Dirección y barrio*',direccion,'assets/icons/direccion.png',TextInputType.text),
              ContainerTextos('Telefono*',telefono,'assets/icons/telefono.png',TextInputType.number),

            
            ],
          ),
        ),
        persistentFooterButtons: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    child: Text('Continuar'),
                    onPressed: () {
                      if (idusuario.text.isNotEmpty &&
                          nombre.text.isNotEmpty &&
                          direccion.text.isNotEmpty &&
                          telefono.text.isNotEmpty) {
                         consultarUsuario(idusuario.text, 'Cliente', nombre.text, widget.email,
                         direccion.text, telefono.text, widget.contrasena);
                      } else {
                        MessageWidget.advertencia(
                            context, "Debe llenar todos los campos", 3);
                      }
                    }),
         
        ]),
      ],
      );
  }
  void consultarUsuario(idusuario,tipousuario,nombre,email,direccion,telefono,contrasena) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/verificarnuevousuario.php');
    var response = await http.post(url, body: {'idusuario': idusuario});

    var datos = jsonDecode(response.body);
     if (datos != 0) {
      MessageWidget.error(context, "Ya existe un usuario con la identificación"+' '+idusuario, 3);
      
    } else {
      adicionarUsuario(idusuario, tipousuario, nombre, email, direccion, telefono, contrasena);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyAppp(idusuario)));
    }
  }
}

class ContainerTextos extends StatelessWidget {
final  texto;
final  controlador;
final  icono;
final  teclado;

ContainerTextos(this.texto,this.controlador, this.icono, this.teclado);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.texto,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: this.controlador,
            style: (TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400
            )),
            //keyboardType: TextInputType.emailAddress,
            keyboardType: this.teclado,
            obscureText: false,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3B324E),
              filled: true,
              prefixIcon: Image.asset(this.icono),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff14DAE2), width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          ),
        ],
      ),
    );
  }
}


