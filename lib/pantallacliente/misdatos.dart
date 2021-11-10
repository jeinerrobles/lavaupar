import 'package:flutter/material.dart';
import 'package:lavaupar/peticiones/clienteshttp.dart';
import 'package:lavaupar/widgets/constants.dart';
import 'package:lavaupar/widgets/messagewidget.dart';


class MisDatos extends StatefulWidget {
  final String idusuario;
  final String nombre;
  final String email;
  final String direccion;
  final String telefono;

  MisDatos(this.idusuario, this.nombre, this.email, this.direccion, this.telefono);
  @override
  _MisDatosState createState() => _MisDatosState();
}

class _MisDatosState extends State<MisDatos> {

   TextEditingController idusuario;
   TextEditingController nombre;
   TextEditingController email;
   TextEditingController direccion;
   TextEditingController telefono;


  @override
  void initState() {

    idusuario = TextEditingController(text:widget.idusuario);
    nombre = TextEditingController(text:widget.nombre);
    email = TextEditingController(text:widget.email);
    direccion = TextEditingController(text:widget.direccion);
    telefono = TextEditingController(text:widget.telefono);

    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos Personales'),
        backgroundColor: fondoazuloscuro,
        actions: [],
      ),
      backgroundColor: Color(0xff251F34),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text('     La identificación y correo no se permiten cambiar',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400
                    ),),
              ContainerTextos('Identificación',idusuario,'assets/icons/id.png',TextInputType.number,false),
              ContainerTextos('Correo',email,'assets/icons/icon_email.png',TextInputType.text,false),
              ContainerTextos('Nombre',nombre,'assets/icons/nombre.png',TextInputType.text,true),
              ContainerTextos('Dirección y barrio',direccion,'assets/icons/direccion.png',TextInputType.text,true),
              ContainerTextos('Telefono',telefono,'assets/icons/telefono.png',TextInputType.number,true),
              
             
            
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    child: Text('GUARDAR DATOS'),
                    onPressed: () {
                      if (idusuario.text.isNotEmpty &&
                          nombre.text.isNotEmpty &&
                          email.text.isNotEmpty &&
                          direccion.text.isNotEmpty &&
                          telefono.text.isNotEmpty) {
                        editarUsuario(idusuario.text, nombre.text,
                            email.text, direccion.text, telefono.text);
                            MessageWidget.confirmacion(
                            context, "Se guardaron los datos correctamente", 3);
                      } else {
                        MessageWidget.advertencia(
                            context, "Hay campos vacios", 3);
                      }
                    }),
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