import 'package:flutter/material.dart';
import 'package:lavaupar/widgets/constants.dart';


class DatosUsuario extends StatelessWidget {
  final idusuario;
  final nombre;
  final email;
  final direccion;
  final telefono;
  int cantidad;

  DatosUsuario( this.idusuario, this.nombre, this.email, this.direccion, this.telefono, this.cantidad);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondoazuloscuro,
        appBar: AppBar(
          title: Text('Datos Del Cliente'),
          backgroundColor: fondoazuloscuro,
        ),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
            height: 460,
            width: double.maxFinite,
            child: Card(
              color: fondoazuloscuro,
              elevation: 5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    left: (MediaQuery.of(context).size.width / 2) - 55,
                    child: Container(
                      height: 100,
                      width: 100,
                      //color: Colors.blue,
                      child: Card(
                        color: fondoazuloscuro,
                        elevation: 2,
                        child: Image.asset('assets/icons/perfil.png'),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Text(
                                this.nombre,
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              Text('TI/C.C '+this.idusuario,style: TextStyle(color: Colors.white)),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Correo',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                              Text(this.email,style: TextStyle(color: Colors.white)),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('Dirección y barrio',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      Text(this.direccion,style: TextStyle(color: Colors.white)),
                                      
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Telefono',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      Text(this.telefono,style: TextStyle(color: Colors.white)),
                                      
                                    ],
                                  ),
                                  
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                             Column(
                              children: [
                                Text('SERVICIOS SOLICITADOS',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                CircleAvatar(
                                  child: Text(this.cantidad.toString(),
                                      style: TextStyle(color: Colors.white)),
                                  backgroundColor: this.cantidad < 1
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ],
                            ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      );
  }
}


