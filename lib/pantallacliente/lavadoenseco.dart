import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lavaupar/peticiones/clienteshttp.dart';
import 'package:lavaupar/widgets/constants.dart';
import 'package:lavaupar/widgets/messagewidget.dart';


class LavadoEnSeco extends StatefulWidget {
  final String idusuario;
  final String direccion;

  LavadoEnSeco(this.idusuario,this.direccion);
  @override
  _LavadoEnSecoState createState() => _LavadoEnSecoState();
}

class _LavadoEnSecoState extends State<LavadoEnSeco> {
  var dateInput;
  var anionacimiento;
  var mesnacimiento;
  var idusuario;

  TextEditingController controldireccion;
  TextEditingController controlfecha = TextEditingController();
  @override
  void initState() {
    controldireccion = TextEditingController(text: widget.direccion);
    idusuario = widget.idusuario;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Solicitar Lavado En Seco"),
        backgroundColor: fondoazuloscuro,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: fondoazuloscuro,
              image: DecorationImage(
                image: AssetImage("assets/icons/seco.png"),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    
                    SizedBox(height: 30),
                    Text(
                      "Servicio de lavado en seco + planchado al vapor.",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                    ),
                    SizedBox(height: 130),
                    Column(children: [
                      SizedBox(
                        height: 85,
                      ),

                      ContainerTextos('Dirección y barrio',controldireccion,'assets/icons/direccion.png',TextInputType.text, true),
              
                      SizedBox(
                        height: 10,
                      ),

                      // Boton seleccionar fecha .
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              OutlinedButton.icon(
                                onPressed: calendario,
                                icon: Icon(
                                  Icons.calendar_today_rounded,
                                  size: 18,
                                ),
                                label: Text('Seleccionar Fecha de recolección'),
                              ),
                            ],
                          )),

                      //controlador fecha
                      ContainerTextos('Fecha de recolección',controlfecha,'assets/icons/fecharecoleccion.png',TextInputType.text, false),

                      ElevatedButton(
                        child: Text("Agendar servicio"),
                        onPressed: () {
                          if (controldireccion.text.isNotEmpty &&
                              controlfecha.text.isNotEmpty) {
                            adicionarServicio(
                                'LAVADO EN SECO',
                                controldireccion.text,
                                controlfecha.text,
                                idusuario,
                                'Pendiente');
                            limpiarDatos();
                            MessageWidget.confirmacion(context,
                                "Se realizó la solicitud correctamente", 3);
                          } else {
                            MessageWidget.advertencia(context,
                                "Debe completar toda la información", 3);
                          }
                        },
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void calendario() {
    var date = new DateTime.now();
    showDatePicker(
            context: context,
            initialDate: new DateTime(date.year, date.month, date.day + 1),
            firstDate: new DateTime(date.year, date.month, date.day + 1),
            lastDate: DateTime(2050))
        .then((value) {
      if (value == null) {
        dateInput = '';
      } else {
        setState(() {
          dateInput = value;
          anionacimiento = value.year;
          mesnacimiento = value.month;
          controlfecha.text = DateFormat.yMEd().format(dateInput).toString();
        });
      }
    });
  }
  void limpiarDatos(){
    controlfecha.text = '';
  }
}

class ContainerTextos extends StatelessWidget {
final  texto;
final  controlador;
final  icono;
final  teclado;
final  campo;

ContainerTextos(this.texto,this.controlador, this.icono, this.teclado, this.campo);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.texto,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            enabled: this.campo,
            controller: this.controlador,
            style: (TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400
            )),
            //keyboardType: TextInputType.emailAddress,
            keyboardType: this.teclado,
            obscureText: false,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              border: InputBorder.none,
              //fillColor: Color(0xfff3B324E),
              filled: true,
              prefixIcon: Image.asset(this.icono),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff14DAE2), width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
