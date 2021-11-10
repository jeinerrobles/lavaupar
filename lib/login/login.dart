import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lavaupar/create_account/create_account.dart';
import 'package:lavaupar/pantallaadmin/principaladmin.dart';
import 'package:lavaupar/pantallacliente/principalusuario.dart';
import 'package:http/http.dart' as http;
import 'package:lavaupar/peticiones/peticioneslogin.dart';
import 'package:lavaupar/widgets/messagewidget.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController usuario = TextEditingController();
  TextEditingController clave = TextEditingController();
  bool showSpinner = false;
  var usuarior;

  void ingreso() {
    Peticioneslogin().ingresarEmail(usuario.text, clave.text).then((user) {
      setState(() {
        print(user);
        if (user == '1') {
          usuarior = 'Correo No Existe';
          MessageWidget.error(context, "El correo no existe", 3);
        } else {
          if(user == '2'){
            usuarior = 'Contraseña Invalida';
            MessageWidget.error(context, "La contraseña es invalida", 3);
          }else{
            usuarior = user.user.email;
          }
        }
      });
    }); 
  }

  void ingoogle() {
    Peticioneslogin().ingresarGoogle().then((user) {
      setState(() {
        print(user);
       // usuarior = user.user.metadata.lastSignInTime;
       print('nombre'+' '+user.user.displayName);
        print('email'+' '+user.user.email);
        usuarior = user.user.email;
      });
    }); // print(resul);
    // print('OBTENER');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xff251F34),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                height: 20,
              ),
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
                          'Correo',
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
                          keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.white,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xfff3B324E),
                                filled: true,
                            prefixIcon: Image.asset('assets/icons/icon_email.png'),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff14DAE2), width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              ),
                        ),
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(

                    child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //Ingresar
                children: [
                   OutlinedButton.icon(
                       style: OutlinedButton.styleFrom(
                       primary: Colors.white,
                       backgroundColor: Colors.teal,
                       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                      label: Text('Ingresar'),
                      icon: Icon(
                      Icons.login_outlined,
                       size: 40,
                      ),
                      
                      onPressed: ()  {
                        if (usuario.text.isNotEmpty &&
                            clave.text.isNotEmpty) {
                        
                             ingresar(usuario.text);
                           } else {
                            MessageWidget.advertencia(
                            context, "Complete los campos correo y contraseña para ingresar", 4);
                      }
                       },
                    ),
                    OutlinedButton.icon(
                       style: OutlinedButton.styleFrom(
                       primary: Colors.white,
                       backgroundColor: Colors.orange,
                       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                      label: Text('Registrar'),
                      icon: Icon(
                      Icons.account_circle_rounded,
                       size: 40,
                      ),
                      
                      onPressed: () {
                        if (usuario.text.isNotEmpty &&
                            clave.text.isNotEmpty) {
                        
                            registrar(usuario.text);
                           } else {
                            MessageWidget.advertencia(
                            context, "Complete el correo y la contraseña a registrar", 4);
                      }
                      },
                    ),
                ],
                    ),
                  ),
                ),
                SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))
                  ),
                  onPressed: () {
                    ingresargoogle();
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                  label: Text('Ingresar con Google')),
              
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        
                      },
                      child: Text('¿Olvidaste tu contraseña?',
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
  void ingresar(email) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarlogueo.php');
    var response = await http
        .post(url, body: {'email': email}).timeout(const Duration(seconds: 90));

    var datos = jsonDecode(response.body);

    Peticioneslogin().ingresarEmail(usuario.text, clave.text).then((user) {
      setState(() {
        print(user);
        if (user == '1') {
          MessageWidget.error(context, "El correo no existe", 3);
        } else {
          if (user == '2') {
            MessageWidget.error(context, "La contraseña es invalida", 3);
          } else {
            if(datos == 0){
               Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CreateAccount(' ',usuario.text, clave.text)));
            }else{
            if (datos[0]['tipousuario'] == 'Cliente') {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyAppp(datos[0]['idusuario'])));
              print('Bienvenido/a' +
                  ' ' +
                  datos[0]['nombre'] +
                  ' - ' +
                  datos[0]['email']);
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PrincipalAdmin(datos[0]['idusuario'])));
              print('Bienvenido/a Admin' +
                  ' ' +
                  datos[0]['nombre'] +
                  ' - ' +
                  datos[0]['email']);
            }
          }
          }
        }
      });
    });
  }

   void registrar(email) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarlogueo.php');
    var response = await http
        .post(url, body: {'email': email}).timeout(const Duration(seconds: 90));

    var datos = jsonDecode(response.body);

    Peticioneslogin().crearRegistroEmail(usuario.text, clave.text).then((user) {
      setState(() {
        print(user);
        if (user == '1') {
         MessageWidget.error(context, "El correo ya existe", 3);
        } else {
          if (user == '2') {
           MessageWidget.error(context, "La contraseña es debil", 3);
          } else {
            if(datos == 0){
               Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CreateAccount(' ',usuario.text, clave.text)));
            }else{
            if (datos[0]['tipousuario'] == 'Cliente') {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyAppp(datos[0]['idusuario'])));
              print('Bienvenido/a' +
                  ' ' +
                  datos[0]['nombre'] +
                  ' - ' +
                  datos[0]['email']);
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PrincipalAdmin(datos[0]['idusuario'])));
              print('Bienvenido/a Admin' +
                  ' ' +
                  datos[0]['nombre'] +
                  ' - ' +
                  datos[0]['email']);
            }
          }
          }
        }
      });
    });
  }

  void ingresargoogle(){
  Peticioneslogin().ingresarGoogle().then((user) {
      setState(() async {
        print(user);
       // usuarior = user.user.metadata.lastSignInTime;
       usuarior = user.user.email;
       print('Nombre: '+' '+user.user.displayName);
        print('Email: '+' '+user.user.email);
        
        var url = Uri.parse(
            'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarlogueo.php');
        var response = await http.post(url,
            body: {'email': usuarior}).timeout(const Duration(seconds: 90));

        var datos = jsonDecode(response.body);
       
          if(datos == 0){
               Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CreateAccount(user.user.displayName,user.user.email,' ')));
            }else{
            if (datos[0]['tipousuario'] == 'Cliente') {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyAppp(datos[0]['idusuario'])));
              print('Bienvenido/a' +
                  ' ' +
                  datos[0]['nombre'] +
                  ' - ' +
                  datos[0]['email']);
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PrincipalAdmin(datos[0]['idusuario'])));
              print('Bienvenido/a Admin' +
                  ' ' +
                  datos[0]['nombre'] +
                  ' - ' +
                  datos[0]['email']);
            }
          }
         
      });
    });
  }
}
