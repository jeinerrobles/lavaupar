import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lavaupar/peticiones/clienteshttp.dart';
import 'package:lavaupar/widgets/constants.dart';

class LavadoEnFrio extends StatefulWidget {
  final String idusuario;
  final String direccion;

  LavadoEnFrio(this.idusuario, this.direccion);
  @override
  _LavadoEnFrioState createState() => _LavadoEnFrioState();
}

class _LavadoEnFrioState extends State<LavadoEnFrio> {
  var dateInput;
  var anionacimiento;
  var mesnacimiento;
  var idusuario;
  late TextEditingController controldireccion;
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
        title: Text("Solicitar Servicio"),
        backgroundColor: fondoazuloscuro,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: kShadowColor,
              image: DecorationImage(
                image: AssetImage("assets/images/lavado.png"),
                fit: BoxFit.fitWidth,
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
                    Text(
                      "Lavado en frio",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Servicio de lavado en frio por libras, secado + doblado  para ropa interior, medias, camisetas, sabanas, fundas y toallas.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 130),
                    Column(children: [
                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextField(
                          controller: controldireccion,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              labelText: 'Dirección',
                              suffix: GestureDetector(
                                child: Icon(Icons.close),
                              )),
                        ),
                      ),

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
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextField(
                          enabled: false,
                          controller: controlfecha,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Fecha recolección',
                          ),
                        ),
                      ),

                      ElevatedButton(
                        child: Text("Agendar servicio"),
                        onPressed: () {
                          adicionarServicio(
                              'LAVADO EN FRIO',
                              controldireccion.text,
                              controlfecha.text,
                              idusuario,
                              'pendiente');

                          Navigator.of(context).pop();
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
}
