import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lavaupar/pantallaadmin/editarservicioenproceso.dart';
import 'package:lavaupar/peticiones/adminhttp.dart';
import 'package:lavaupar/widgets/constants.dart';


class ServiciosEnProceso extends StatefulWidget {
  @override
  _ServiciosEnProcesoState createState() => _ServiciosEnProcesoState();
}

class _ServiciosEnProcesoState extends State<ServiciosEnProceso> {
  var colorestado = Colors.green;
  var foto;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado Servicios En Lavanderia'),
        backgroundColor: fondoazuloscuro,
        actions: [],
      ),

      body: Column(
        children: [
          SizedBox(
                height: 5,
              ),
          Container(
            color: Colors.greenAccent,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('En lavanderia',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    Text('En entrega',
                        style: TextStyle(
                            color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
      
      Expanded(
            child: FutureBuilder(
    future: listarEnProcesoPost(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
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
          if(snapshot.data[posicion].estado == 'En lavanderia'){
                                colorestado = Colors.green;
                              }else{
                                if(snapshot.data[posicion].estado == 'En entrega'){
                                colorestado = Colors.blueGrey;
                                }
                              }
                              if(snapshot.data[posicion].nombre == 'LAVADO EN FRIO'){
                                foto = "assets/icons/enfrio.png";
                              }else{
                                if(snapshot.data[posicion].nombre == 'LAVADO EN SECO'){
                                  foto = "assets/icons/enseco.png";
                                }else{
                                  if(snapshot.data[posicion].nombre == 'TINTURADO'){
                                    foto = "assets/icons/tintura.png";
                                  }
                                }
                              }
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
                  backgroundImage: AssetImage(foto),
                ), 
            title: Text(snapshot.data[posicion].nombre),
            subtitle: Text(snapshot.data[posicion].direccion,style: TextStyle(
                                  color: Colors.grey[600],
                                ),),
            trailing: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
              color: colorestado,
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
  ),)
        ],
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
      ), 
    );
  }
}

class Refrescar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var colorestado = Colors.green;
    var foto;                          
    return FutureBuilder(
    future: listarEnProcesoPost(http.Client()), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
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
          if(snapshot.data[posicion].estado == 'En lavanderia'){
                                colorestado = Colors.green;
                              }else{
                                if(snapshot.data[posicion].estado == 'En entrega'){
                                colorestado = Colors.blueGrey;
                                }
                              }
                              if(snapshot.data[posicion].nombre == 'LAVADO EN FRIO'){
                                foto = "assets/icons/enfrio.png";
                              }else{
                                if(snapshot.data[posicion].nombre == 'LAVADO EN SECO'){
                                  foto = "assets/icons/enseco.png";
                                }else{
                                  if(snapshot.data[posicion].nombre == 'TINTURADO'){
                                    foto = "assets/icons/tintura.png";
                                  }
                                }
                              }
          return Card(
          child: ListTile(
            
            leading: CircleAvatar(
                  backgroundImage: AssetImage(foto),
                ), 
            title: Text(snapshot.data[posicion].nombre),
            subtitle: Text(snapshot.data[posicion].direccion,style: TextStyle(
                                  color: Colors.grey[600],
                                ),),
            trailing: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
              color: colorestado,
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
  );
  }
}