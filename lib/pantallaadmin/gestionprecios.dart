import 'package:flutter/material.dart';
import 'package:lavaupar/peticiones/adminhttp.dart';
import 'package:lavaupar/widgets/constants.dart';
import 'package:lavaupar/widgets/messagewidget.dart';


class GestionPrecios extends StatefulWidget {
  final String idprecio;
  final String nombre;
  final String precio;
  final String tipo;
  final String boton;

  GestionPrecios(this.idprecio, this.nombre,this.precio, this.tipo, this.boton);
  @override
  _GestionPreciosState createState() => _GestionPreciosState();
}

class _GestionPreciosState extends State<GestionPrecios> {
  var idprecio;
  String boton;
   TextEditingController nombre;
   TextEditingController precio;
  

  String tipo;
  var _tipo = ["LAVADO EN FRIO", "LAVADO EN SECO", "TINTURADO"];

  @override
  void initState() {
    idprecio = widget.idprecio;
    nombre = TextEditingController(text:widget.nombre);
    precio = TextEditingController(text:widget.precio);
    tipo = widget.tipo;
    boton = widget.boton;
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestionar Precio'),
        backgroundColor: fondoazuloscuro,
        actions: [],
      ),
      backgroundColor: Color(0xff251F34),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
              ContainerTextos('Descripción',nombre,'assets/icons/ropa.png',TextInputType.text,true),
              ContainerTextos('Precio',precio,'assets/icons/etiquetaprecio.png',TextInputType.number,true),
              
             
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tipo de servicio',
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
                      value: tipo,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconDisabledColor: Colors.red,
                      iconEnabledColor: Colors.blue,
                      items: _tipo.map((String items) {
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
                    child: Text(boton),
                    onPressed: () {
                      if (nombre.text.isNotEmpty && precio.text.isNotEmpty) {
                        if (idprecio == '') {
                          adicionarPrecio(nombre.text, precio.text, tipo);
                          Navigator.of(context).pop();
                        } else {
                          editarPrecio(
                              idprecio, nombre.text, precio.text, tipo);
                          Navigator.of(context).pop();
                        }
                      }else{
                        MessageWidget.advertencia(
                            context, "Hay campos vacios", 3);
                      }
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
    );
  }
  void changedDropDownItem(selectedTipo) {
    setState(() {
      tipo = selectedTipo;
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
          ),
        ],
      ),
    );
  }
}