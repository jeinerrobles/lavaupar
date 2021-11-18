
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lavaupar/peticiones/adminhttp.dart';
import 'package:lavaupar/widgets/constants.dart';

class Precio extends StatefulWidget {

  @override
  _PrecioState createState() => _PrecioState();
}

class _PrecioState extends State<Precio> {
  var colorestado = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fondoazuloscuro,
       appBar: AppBar(
        title: Text('Modificar precios'),
        backgroundColor: fondoazuloscuro,
        actions: [
          IconButton(
              tooltip: 'Agregar precio',
              icon: Icon(Icons.add),
              onPressed: () {
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AgregarMensajero())).then((value) {
                  setState(() {
                    getInfo(context);
                  });
                }); */
              })
        ],
      ),
        body:  FutureBuilder(
    future: listarPreciosPost(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
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
          if(snapshot.data[posicion].tipo == 'LAVADO EN FRIO'){
                                colorestado = Colors.blue;
                              }else{
                                if(snapshot.data[posicion].tipo == 'LAVADO EN SECO'){
                                colorestado = Colors.orange;
                                }else{
                                  if(snapshot.data[posicion].tipo == 'TINTURADO'){
                                    colorestado = Colors.deepPurple;
                                  }
                                }
                              }
          return Card(
          child: ListTile(
           /* onTap: () {
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
                 
        },*/
    leading: CircleAvatar(
          backgroundImage: AssetImage("assets/icons/peso.png"),
        ), 
    title: Text(snapshot.data[posicion].nombre),
    subtitle: Text(snapshot.data[posicion].tipo, style: TextStyle(color: colorestado)),
    trailing: Text(snapshot.data[posicion].precio,
        style: TextStyle(
          color: Colors.black,
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
  )
          );
  }
}

