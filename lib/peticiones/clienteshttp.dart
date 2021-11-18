import 'dart:async';
import 'dart:convert';
import 'package:lavaupar/modelos/servicios.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lavaupar/modelos/usuarios.dart';


Future<List<Usuario>> listarUsuariosPost(http.Client client) async {
  final response = await http.get(Uri.parse(
      'https://pmproyecto.000webhostapp.com/proyectolavauparapi/listarusuarios.php')
      );

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListasUsuarios, response.body);
}

List<Usuario> pasaraListasUsuarios(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Usuario>((json) => Usuario.fromJson(json)).toList();
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
    String email,
    String direccion,
    String telefono,
    String contrasena) async {
  var url = Uri.parse(
      "https://pmproyecto.000webhostapp.com/proyectolavauparapi/adicionarusuario.php");

  await http.post(url, body: {
    'idusuario': idusuario,
    'tipousuario': tipousuario,
    'nombre': nombre,
    'email': email,
    'direccion': direccion,
    'telefono': telefono,
    'contrasena': contrasena,
  });
}

void editarUsuario(
    String idusuario,
    String nombre,
    String email,
    String direccion,
    String telefono) async {
  var url = Uri.parse(
      "https://pmproyecto.000webhostapp.com/proyectolavauparapi/modificarusuario.php");

  await http.post(url, body: {
    'idusuario': idusuario,
    'nombre': nombre,
    'email': email,
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

