import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lavaupar/pantallaadmin/editarservicioenproceso.dart';
import 'package:lavaupar/peticiones/adminhttp.dart';
import 'package:lavaupar/widgets/constants.dart';

//import 'adicionar.dart';

class ServiciosEnProceso extends StatefulWidget {
  @override
  _ServiciosEnProcesoState createState() => _ServiciosEnProcesoState();
}

class _ServiciosEnProcesoState extends State<ServiciosEnProceso> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado Servicios En Proceso'),
        backgroundColor: fondoazuloscuro,
        actions: [],
      ),

      body: FutureBuilder(
    future: listarEnProcesoPost(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
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
            onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => EditarServicioEnProceso(snapshot.data[posicion].idservicio,
                      snapshot.data[posicion].nombre, snapshot.data[posicion].direccion, 
                      snapshot.data[posicion].fecha, snapshot.data[posicion].cliente, snapshot.data[posicion].estado))).then((value) {
                  setState(() {
                    Refrescar();
                  });
                });
                         
                },
            leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/icons/icono.png"),
                ), 
            title: Text(snapshot.data[posicion].nombre),
            subtitle: Text(snapshot.data[posicion].direccion,
                style: TextStyle(
                  color: Colors.green
                ),),
            trailing: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                snapshot.data[posicion].cliente + ' - ' + snapshot.data[posicion].fecha,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
              );
        })
              : Text('Sin Datos');

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  ),
      backgroundColor: fondoazuloscuro,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Refrescar();
          });
        },
        tooltip: 'Refrescar',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Refrescar extends StatelessWidget {
  const Refrescar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: listarEnProcesoPost(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
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
          color: Colors.green,
        ),),
    trailing: Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Text(
        snapshot.data[posicion].cliente + ' - ' + snapshot.data[posicion].fecha,
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
  }
}