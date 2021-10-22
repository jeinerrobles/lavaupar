import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lavaupar/peticiones/clienteshttp.dart';
import 'package:lavaupar/widgets/constants.dart';

class Tinturado extends StatefulWidget {
  @override
  _TinturadoState createState() => _TinturadoState();
}

class _TinturadoState extends State<Tinturado> {
  var dateInput;
  var anionacimiento;
  var mesnacimiento;
  TextEditingController controldireccion = TextEditingController();
  TextEditingController controlfecha = TextEditingController();

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
                image: AssetImage("assets/images/meditation_bg.png"),
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
                      "Tinturado",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Servicio de tinturado",
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
                              'TINTURADO',
                              controldireccion.text,
                              controlfecha.text,
                              '1003242749',
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
