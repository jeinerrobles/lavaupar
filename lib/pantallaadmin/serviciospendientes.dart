import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lavaupar/pantallaadmin/editarserviciopendiente.dart';
import 'package:lavaupar/peticiones/adminhttp.dart';
import 'package:lavaupar/widgets/constants.dart';


class ServiciosPendientes extends StatefulWidget {
  @override
  _ServiciosPendientesState createState() => _ServiciosPendientesState();
}

class _ServiciosPendientesState extends State<ServiciosPendientes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado Servicios Pendientes'),
        backgroundColor: fondoazuloscuro,
        actions: [],
      ),

      body: FutureBuilder(
    future: listarPendientesPost(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.done:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
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
                      builder: (BuildContext context) => EditarServicioPendiente(snapshot.data[posicion].idservicio,
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
              color: Colors.orange,
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
    future: listarPendientesPost(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.done:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
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
      color: Colors.orange,
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

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
  }
}

