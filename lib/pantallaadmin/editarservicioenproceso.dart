import 'package:flutter/material.dart';
import 'package:lavaupar/peticiones/adminhttp.dart';
import 'package:lavaupar/widgets/constants.dart';


class EditarServicioEnProceso extends StatefulWidget {
  final String idservicio;
  final String nombre;
  final String direccion;
  final String fecha;
  final String cliente;
  final String estado;

  EditarServicioEnProceso(this.idservicio, this.nombre,this.direccion, this.fecha, this.cliente, this.estado);
  @override
  _EditarServicioEnProcesoState createState() => _EditarServicioEnProcesoState();
}

class _EditarServicioEnProcesoState extends State<EditarServicioEnProceso> {
  var idservicio;
   TextEditingController nombre;
   TextEditingController direccion;
   TextEditingController fecha;
   TextEditingController cliente;

  String estado = 'Finalizado';
  var _estados = ["Finalizado"];

  @override
  void initState() {
    idservicio = widget.idservicio;
    nombre = TextEditingController(text:widget.nombre);
    direccion = TextEditingController(text:widget.direccion);
    fecha = TextEditingController(text:widget.fecha);
    cliente = TextEditingController(text:widget.cliente);

    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Estado '),
        backgroundColor: fondoazuloscuro,
        actions: [],
      ),
      backgroundColor: Color(0xff251F34),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
              ContainerTextos('Nombre del servicio',nombre,'assets/icons/servicioeditar.png',TextInputType.text,false),
              ContainerTextos('Fecha de la recolección',fecha,'assets/icons/fechaeditar.png',TextInputType.datetime,false),
              ContainerTextos('Cliente',cliente,'assets/icons/clienteeditar.png',TextInputType.number,false),
              ContainerTextos('Dirección y barrio',direccion,'assets/icons/direccion.png',TextInputType.text,true),
              
             
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Estado',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButton(
                      isExpanded: true,
                      value: estado,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconDisabledColor: Colors.red,
                      iconEnabledColor: Colors.blue,
                      items: _estados.map((String items) {
                        return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                  color: Colors.blue),
                            ));
                      }).toList(),
                      onChanged: changedDropDownItem,
                    ),
                  ],
                ),
              ),
            ),
                      
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: OutlinedButton(
                       style: OutlinedButton.styleFrom(
                       primary: Colors.white,
                       backgroundColor: Colors.teal,
                       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                    child: Text('ATUALIZAR SERVICIO'),
                    onPressed: () {
                      editarServicio(
                      idservicio, 
                      nombre.text,
                      direccion.text,
                      fecha.text,
                      cliente.text,
                      estado);
                      Navigator.of(context).pop();
                      }
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void changedDropDownItem(selectedCity) {
    setState(() {
      estado = selectedCity;
    });
  }
}

class ContainerTextos extends StatelessWidget {
final  texto;
final  controlador;
final  icono;
final  teclado;
final  enabled;

ContainerTextos(this.texto,this.controlador, this.icono, this.teclado, this.enabled);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.texto,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            enabled: this.enabled,
            controller: this.controlador,
            style: (TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400
            )),
            //keyboardType: TextInputType.emailAddress,
            keyboardType: this.teclado,
            obscureText: false,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3B324E),
              filled: true,
              prefixIcon: Image.asset(this.icono),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff14DAE2), width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
           /* onChanged: (value) {
              email = value;
            },*/
          ),
        ],
      ),
    );
  }
}