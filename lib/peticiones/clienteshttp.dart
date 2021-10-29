import 'dart:async';
import 'dart:convert';
import 'package:lavaupar/modelos/servicios.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


Future<List<Servicio>> listarPost(http.Client client) async {
  final response = await http.get(Uri.parse(
      'https://pmproyecto.000webhostapp.com/proyectolavauparapi/listar.php')
      );

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListas, response.body);
}
Future<List<Servicio>> listarServiciosClientePost(http.Client client, idusuario) async {
  final response = await http.post(Uri.parse(
      'https://pmproyecto.000webhostapp.com/proyectolavauparapi/listaservicioscliente.php'), body: {
      'idusuario': idusuario,
  });

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListas, response.body);
}

// Una función que convierte el body de la respuesta en un List<Photo>
List<Servicio> pasaraListas(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Servicio>((json) => Servicio.fromJson(json)).toList();
}

void adicionarServicio(
    String nombre,
    String direccion,
    String fecha,
    String cliente,
    String estado) async {
  var url = Uri.parse(
      "https://pmproyecto.000webhostapp.com/proyectolavauparapi/adicionar.php");

  await http.post(url, body: {
    'nombre': nombre,
    'direccion': direccion,
    'fecha': fecha,
    'cliente': cliente,
    'estado': estado,
  });
}

void adicionarUsuario(
    String idusuario,
    String tipousuario,
    String nombre,
    String apellido,
    String direccion,
    String telefono,
    String contrasena) async {
  var url = Uri.parse(
      "https://pmproyecto.000webhostapp.com/proyectolavauparapi/adicionarusuario.php");

  await http.post(url, body: {
    'idusuario': idusuario,
    'tipousuario': tipousuario,
    'nombre': nombre,
    'apellido': apellido,
    'direccion': direccion,
    'telefono': telefono,
    'contrasena': contrasena,
  });
}

void editarUsuario(
    String idusuario,
    String nombre,
    String apellido,
    String direccion,
    String telefono) async {
  var url = Uri.parse(
      "https://pmproyecto.000webhostapp.com/proyectolavauparapi/modificarusuario.php");

  await http.post(url, body: {
    'idusuario': idusuario,
    'nombre': nombre,
    'apellido': apellido,
    'direccion': direccion,
    'telefono': telefono,
  });
}

void editarServicio(
    String idservicio,
    String nombre,
    String direccion,
    String fecha,
    String cliente,
    String estado) async {
  var url = Uri.parse(
      "https://pmproyecto.000webhostapp.com/proyectolavauparapi/modificar.php");

  await http.post(url, body: {
    'idservicio': idservicio,
    'nombre': nombre,
    'direccion': direccion,
    'fecha': fecha,
    'cliente': cliente,
    'estado': estado,
  });
}

void eliminarServicio(idservicio) async {
  var url = Uri.parse(
      "https://pmproyecto.000webhostapp.com/proyectolavauparapi/eliminar.php");

  await http.post(url, body: {
    'ideliminar': idservicio,
  });
}
/*
void ingresar (idusuario,contrasena) async{
    var url = Uri.parse('https://pmproyecto.000webhostapp.com/proyectolavauparapi/consultarlogueo.php');
    var response = await http.post(url,
    body:{
      'idusuario': idusuario,
      'contrasena': contrasena
    } 
    ).timeout(const Duration(seconds: 90));
    
    var datos = jsonDecode(response.body);

    if(datos != 0){
      print('Bienvenido/a'+' '+datos[0]['nombre']+' '+datos[0]['apellido']);
    }else{
      print('usuario y/o contraseña incorrecto(s)');
    }
}
*/
