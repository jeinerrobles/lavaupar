import 'package:lavaupar/modelos/servicios.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lavaupar/peticiones/clienteshttp.dart';
import 'package:lavaupar/widgets/constants.dart';

//import 'adicionar.dart';

class ServiciosCliente extends StatefulWidget {
  final String idusuario;

  ServiciosCliente(this.idusuario);
  @override
  _ServiciosClienteState createState() => _ServiciosClienteState();
}

class _ServiciosClienteState extends State<ServiciosCliente> {
  final List<Servicio> servicios =[];
  var idusuario;
  @override
  void initState() {
    super.initState();
    idusuario = widget.idusuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado Servicios'),
        backgroundColor: fondoazuloscuro,
        actions: [],
      ),

      body: FutureBuilder(
    future: listarServiciosClientePost(http.Client(),idusuario), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.done:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? ListView.builder(
        itemCount: snapshot.data.length == 0 ? 0 : snapshot.data.length,
        itemBuilder: (context, posicion) {
          return Card(
          child: ListTile(
            onLongPress: () {
                  
                    confirmaeliminar(context, snapshot.data[posicion].idservicio);
                  
                },
            leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/icons/icono.png"),
                ), 
            title: Text(snapshot.data[posicion].nombre),
            subtitle: Text(snapshot.data[posicion].direccion,
                style: TextStyle(
                  color: Colors.orange
                ),),
            trailing: Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                snapshot.data[posicion].fecha + ' - ' + snapshot.data[posicion].estado,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
              );
        })
              : Text('Sin Datos');

        /*
             Text(
              snapshot.data != null ?'ID: ${snapshot.data['id']}\nTitle: ${snapshot.data['title']}' : 'Vuelve a intentar', 
              style: TextStyle(color: Colors.black, fontSize: 20),);
            */

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  ),
      backgroundColor: fondoazuloscuro,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            FutureBuilder(
    future: listarServiciosClientePost(http
        .Client(),idusuario), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.done:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? ListView.builder(
        itemCount: snapshot.data.length == 0 ? 0 : snapshot.data.length,
        itemBuilder: (context, posicion) {
          return ListTile(
            
            leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/icons/icono.png"),
                ),
            title: Text(snapshot.data[posicion].nombre),
            subtitle: Text(snapshot.data[posicion].direccion,
                style: TextStyle(
                  color: Colors.orange,
                ),),
            trailing: Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                servicios[posicion].fecha + ' - ' + servicios[posicion].estado,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        })
              : Text('Sin Datos');

        /*
             Text(
              snapshot.data != null ?'ID: ${snapshot.data['id']}\nTitle: ${snapshot.data['title']}' : 'Vuelve a intentar', 
              style: TextStyle(color: Colors.black, fontSize: 20),);
            */

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
          });
        },
        tooltip: 'Refrescar',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void confirmaeliminar(context, ideliminar) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text('Realmente Desea Cancelar La Solicitud?'),
        actions: <Widget>[
          ElevatedButton(
             style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
            child: Icon(Icons.cancel),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: Icon(Icons.check_circle),
            onPressed: () {
              setState(() {
                    eliminarServicio(ideliminar);
                  });
              
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
}