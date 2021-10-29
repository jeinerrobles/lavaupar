import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lavaupar/peticiones/clienteshttp.dart';
import 'package:lavaupar/widgets/messagewidget.dart';
import 'package:http/http.dart' as http;

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool showSpinner = false;
 

  @override
  Widget build(BuildContext context) {
    TextEditingController idusuario = TextEditingController();
    TextEditingController nombre = TextEditingController();
    TextEditingController apellido = TextEditingController();
    TextEditingController direccion = TextEditingController();
    TextEditingController telefono = TextEditingController();
    TextEditingController contrasena = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
            leading: _goBackButton(context),
          backgroundColor: Color(0xff251F34),
        ),
        backgroundColor: Color(0xff251F34),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text('Crear Cuenta',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25
                  ),),
              ),
              Text('     Tu identificación sera el usuario al ingresar',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400
                    ),),
              ContainerTextos('Identificación',idusuario,'assets/icons/id.png',TextInputType.number),
              ContainerTextos('Nombre',nombre,'assets/icons/nombre.png',TextInputType.text),
              ContainerTextos('Apellido',apellido,'assets/icons/nombre.png',TextInputType.text),
              ContainerTextos('Dirección y barrio',direccion,'assets/icons/direccion.png',TextInputType.text),
              ContainerTextos('Telefono',telefono,'assets/icons/telefono.png',TextInputType.number),
              ContainerTextos('Contraseña',contrasena,'assets/icons/contrasena.png',TextInputType.text),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    child: Text('CREAR CUENTA'),
                    onPressed: () {
                      if (idusuario.text.isNotEmpty &&
                          nombre.text.isNotEmpty &&
                          apellido.text.isNotEmpty &&
                          direccion.text.isNotEmpty &&
                          telefono.text.isNotEmpty &&
                          contrasena.text.isNotEmpty) {
                        consultarUsuario(idusuario.text, 'Cliente', nombre.text, apellido.text,
                         direccion.text, telefono.text, contrasena.text);
                      } else {
                        MessageWidget.advertencia(
                            context, "Debe llenar todos los campos", 3);
                      }
                    }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ya tienes una cuenta?',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400
                    ),),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ingresar',
                        style: TextStyle(
                          color: Color(0xff14DAE2),)
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
  void consultarUsuario(idusuario,tipousuario,nombre,apellido,direccion,telefono,contrasena) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/verificarnuevousuario.php');
    var response = await http.post(url, body: {'idusuario': idusuario});

    var datos = jsonDecode(response.body);

     if (datos != 0) {
      MessageWidget.error(context, "Ya existe un usuario con la identificación"+' '+idusuario, 3);
      
    } else {
      
      adicionarUsuario(idusuario, tipousuario, nombre, apellido, direccion, telefono, contrasena);
      MessageWidget.confirmacion(context, "Usuario creado correctamente", 3);
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
           /* onChanged: (value) {
              email = value;
            },*/
          ),
        ],
      ),
    );
  }
}

Widget _goBackButton(BuildContext context) {
  return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.grey[350]),
      onPressed: () {
        Navigator.of(context).pop(true);
      });
}
