import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lavaupar/modelos/usuarios.dart';
import 'package:lavaupar/pantallaadmin/datosusuario.dart';
import 'package:lavaupar/widgets/constants.dart';

class ConsultarUsuarios extends StatefulWidget {

  @override
  _ConsultarUsuariosState createState() => _ConsultarUsuariosState();
}

class _ConsultarUsuariosState extends State<ConsultarUsuarios> {
  var colorestado = Colors.orange;
   TextEditingController controller = new TextEditingController();

  Future<Null> getUserDetails() async {
    final response = await http.get(Uri.parse(
      'https://pmproyecto.000webhostapp.com/proyectolavauparapi/listarusuarios.php')
      );
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map user in responseJson) {
        _userDetails.add(Usuario.fromJson(user));
      }
    });
  }


  List<Usuario> _searchResult = [];
  List<Usuario> _userDetails = [];

   onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.nombre.toUpperCase().contains(text.toUpperCase()) || 
      userDetail.idusuario.toUpperCase().contains(text.toUpperCase()))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }

@override
  void initState() {
    super.initState();

    getUserDetails();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fondoazuloscuro,
       appBar: AppBar(
        title: Text('Clientes'),
        backgroundColor: fondoazuloscuro,
      ),
        body:  Column(
        children: [
          SizedBox(
                height: 5,
              ),
              Container(
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Buscar', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },),
                ),
              ),
            ),
          ),
        SizedBox(
                height: 5,
              ),
        Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? new ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return new Card(
                  child: new ListTile(
                    onTap: () {
                      consultarusuario(_searchResult[i].idusuario);
                    },
                    leading: CircleAvatar(backgroundImage: AssetImage("assets/icons/perfil.png")),
                    title: Text(_searchResult[i].nombre),
                    trailing:Text( _searchResult[i].idusuario),
                  ),
                  margin: const EdgeInsets.all(0.0),
                );
              },
            )
                : new ListView.builder(
              itemCount: _userDetails.length,
              itemBuilder: (context, index) {
                return new Card(
                  child: new ListTile(
                    onTap: () {
                      consultarusuario(_userDetails[index].idusuario);
                    },
                    leading: CircleAvatar(backgroundImage: AssetImage("assets/icons/perfil.png")),
                    title:  Text(_userDetails[index].nombre),
                    trailing:Text(_userDetails[index].idusuario),
                  ),
                  margin: const EdgeInsets.all(0.0),
                );
              },
            ),)
        ],
        )
          );
  }
  void consultarusuario(idusuario) async {
    var url = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarpersona.php');
    var response = await http.post(url, body: {'idusuario': idusuario});

    var url2 = Uri.parse(
        'https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarcantidadsolicitudescliente.php');
    var response2 = await http.post(url2, body: {'idusuario': idusuario});

    var datos = jsonDecode(response.body);
    var cantidad = jsonDecode(response2.body);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                DatosUsuario(datos[0]['idusuario'], datos[0]['nombre'], datos[0]['email'],
                 datos[0]['direccion'], datos[0]['telefono'],  int.parse(cantidad[0]['cantidad']))));
                 
  }
}


