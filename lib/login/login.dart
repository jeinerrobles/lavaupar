import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lavaupar/create_account/create_account.dart';
import 'package:lavaupar/pantallaadmin/principaladmin.dart';
import 'package:lavaupar/pantallacliente/principalusuario.dart';
import 'package:http/http.dart' as http;
import 'package:lavaupar/widgets/messagewidget.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    TextEditingController usuario = TextEditingController();
    TextEditingController clave = TextEditingController();
    return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xff251F34),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child:Image.asset('assets/icons/icono.png',width:175,height:175),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 8),
                  child: Text('Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Usuario',
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: usuario,
                          style: (TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.w400
                          )),
                          keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xfff3B324E),
                                filled: true,
                            prefixIcon: Image.asset('assets/icons/id.png'),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff14DAE2), width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              ),
                        ),
                         /* onChanged: (usuario) {
                            usuario.text = usuario;
                          },*/
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Contraseña',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: clave,
                        style: (TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        )),
                        obscureText: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3B324E),
                          filled: true,
                          prefixIcon: Image.asset('assets/icons/icon_lock.png'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff14DAE2), width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                       /* onChanged: (value) {
                          password = value;
                        },*/
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: OutlinedButton.icon(
                       style: OutlinedButton.styleFrom(
                       primary: Colors.white,
                       backgroundColor: Colors.teal,
                       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                      label: Text('INGRESAR'),
                      icon: Icon(
                      Icons.login_outlined,
                       size: 40,
                      ),
                      
                      onPressed: ()  {
                        if (usuario.text.isNotEmpty &&
                            clave.text.isNotEmpty) {
                        
                                ingresar(usuario.text, clave.text);
                           } else {
                            MessageWidget.advertencia(
                            context, "Debe completar los campos usuario y contraseña", 3);
                      }
                       },
                    ),
                  ),
                ),
              
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('¿No estás registrado?',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400
                      ),),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccount()));
                      },
                      child: Text('Crear cuenta',
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
  void ingresar(idusuario, contrasena) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarlogueo.php');
    var response = await http.post(url, body: {
      'idusuario': idusuario,
      'contrasena': contrasena
    }).timeout(const Duration(seconds: 90));

    var datos = jsonDecode(response.body);

    if (datos != 0) {
      if(datos[0]['tipousuario'] == 'Cliente'){
          Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MyAppp(datos[0]['idusuario'])));
          print('Bienvenido/a' +' '+datos[0]['nombre'] +' '+datos[0]['apellido']);
      }else{
         Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => PrincipalAdmin(datos[0]['idusuario'],datos[0]['tipousuario'],
          datos[0]['nombre'],datos[0]['apellido'],datos[0]['direccion'],datos[0]['telefono'],datos[0]['contrasena'])));
          print('Bienvenido/a Admin' +' ' +datos[0]['nombre'] +' ' +datos[0]['apellido']);
      }
      
    } else {
      
      MessageWidget.error(context, "Usuario y/o contraseña incorrecto(s)", 3);
    }
  }
}
