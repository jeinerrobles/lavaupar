import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lavaupar/peticiones/clienteshttp.dart';
import 'package:lavaupar/widgets/constants.dart';



class ServiciosCliente extends StatefulWidget {
  final String idusuario;

  ServiciosCliente(this.idusuario);
  @override
  _ServiciosClienteState createState() => _ServiciosClienteState();
}

class _ServiciosClienteState extends State<ServiciosCliente> {
  var colorestado = Colors.orange;
  var foto;
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

      body: Column( 
        children: [
          SizedBox(
                height: 5,
              ),
          Container(
            color: Colors.greenAccent,
            padding: const EdgeInsets.all(5),
            child: ListTile(
              title: Text(
                'Mantén presionado para cancelar un servicio pendiente',
                style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400
                    ),
              ),
              leading: Icon(Icons.info_outline,  color: Colors.white),
            ),
          ),
        
       Expanded(
            child:FutureBuilder(
        future: listarServiciosClientePost(http.Client(),
            idusuario), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {

            //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return snapshot.data != null
                  ? ListView.builder(
                      itemCount:
                          snapshot.data.length == 0 ? 0 : snapshot.data.length,
                      itemBuilder: (context, posicion) {
                        if(snapshot.data[posicion].estado == 'En lavanderia'){
                                colorestado = Colors.green;
                              }else{
                                if(snapshot.data[posicion].estado == 'Finalizado'){
                                colorestado = Colors.blue;
                                }else{
                                  if(snapshot.data[posicion].estado == 'Pendiente'){
                                    colorestado = Colors.orange;
                                  }else{
                                    if(snapshot.data[posicion].estado == 'En camino'){
                                      colorestado = Colors.deepPurple;
                                    }else{
                                      if(snapshot.data[posicion].estado == 'En entrega'){
                                        colorestado = Colors.blueGrey;
                                      }else{
                                        if(snapshot.data[posicion].estado == 'Rechazado'){
                                          colorestado = Colors.red;
                                        }
                                      }
                                    }
                                  }
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
                            onLongPress: () {
                              if(snapshot.data[posicion].estado == 'Pendiente'){
                                confirmaeliminar(
                                  context, snapshot.data[posicion].idservicio);
                              }
                              
                            },
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage(foto),
                            ),
                            title: Text(snapshot.data[posicion].nombre),
                            subtitle: Text(
                              snapshot.data[posicion].direccion,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                            ),
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
                                snapshot.data[posicion].fecha +
                                    ' -  ' +
                                    snapshot.data[posicion].estado,
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
      ),),
            ],
      ),
      backgroundColor: fondoazuloscuro,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            FutureBuilder(
              future: listarServiciosClientePost(http.Client(),
                  idusuario), //En esta línea colocamos el el objeto Future que estará esperando una respuesta
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {

                  //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());

                  case ConnectionState.done:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    return snapshot.data != null
                        ? ListView.builder(
                            itemCount: snapshot.data.length == 0
                                ? 0
                                : snapshot.data.length,
                            itemBuilder: (context, posicion) {
                              if(snapshot.data[posicion].estado == 'En lavanderia'){
                                colorestado = Colors.green;
                              }else{
                                if(snapshot.data[posicion].estado == 'Finalizado'){
                                colorestado = Colors.blue;
                                }else{
                                  if(snapshot.data[posicion].estado == 'Pendiente'){
                                    colorestado = Colors.orange;
                                  }else{
                                    if(snapshot.data[posicion].estado == 'En camino'){
                                      colorestado = Colors.deepPurple;
                                    }else{
                                      if(snapshot.data[posicion].estado == 'En entrega'){
                                        colorestado = Colors.blueGrey;
                                      }else{
                                        if(snapshot.data[posicion].estado == 'Rechazado'){
                                          colorestado = Colors.red;
                                        }
                                      }
                                    }
                                  }
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
                                  onLongPress: () {
                                    if(snapshot.data[posicion].estado == 'Pendiente'){
                                confirmaeliminar(
                                  context, snapshot.data[posicion].idservicio);
                              }
                                    
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(foto),
                                  ),
                                  title: Text(snapshot.data[posicion].nombre),
                                  subtitle: Text(
                                    snapshot.data[posicion].direccion,
                                    style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                                  ),
                                  trailing: 
                                  Container(
                                    width: 150,
                                    height: 150,
                                    
                                    decoration: BoxDecoration(
                                      color: colorestado,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.data[posicion].fecha +
                                          ' -  ' +
                                          snapshot.data[posicion].estado,
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
          content: Text('¿Desea cancelar la solicitud?'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
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
