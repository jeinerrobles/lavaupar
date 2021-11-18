import 'dart:async';
import 'dart:convert';
import 'package:lavaupar/modelos/precios.dart';
import 'package:lavaupar/modelos/servicios.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


Future<List<Servicio>> listarPendientesPost(http.Client client) async {
  final response = await http.get(Uri.parse(
      'https://pmproyecto.000webhostapp.com/proyectolavauparapi/listarpendientes.php')
      );

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListas, response.body);
}

Future<List<Servicio>> listarEnProcesoPost(http.Client client) async {
  final response = await http.get(Uri.parse(
      'https://pmproyecto.000webhostapp.com/proyectolavauparapi/listarenproceso.php')
      );

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListas, response.body);
}

// Una función que convierte el body de la respuesta en un List<Photo>
List<Servicio> pasaraListas(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Servicio>((json) => Servicio.fromJson(json)).toList();
}

List<Precio> pasaraListasPrecio(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Precio>((json) => Precio.fromJson(json)).toList();
}

Future<List<Precio>> listarPreciosPost(http.Client client) async {
  final response = await http.get(Uri.parse(
      'https://pmproyecto.000webhostapp.com/proyectolavauparapi/listarprecios.php')
      );

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(pasaraListasPrecio, response.body);
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

void adicionarPrecio(
    String nombre,
    String precio,
    String tipo) async {
  var url = Uri.parse(
      "https://pmproyecto.000webhostapp.com/proyectolavauparapi/adicionar.php");

  await http.post(url, body: {
    'nombre': nombre,
    'precio': precio,
    'tipo': tipo,
  });
}

void editarPrecio(
    String idprecio,
    String nombre,
    String precio,
    String tipo) async {
  var url = Uri.parse(
      "https://pmproyecto.000webhostapp.com/proyectolavauparapi/modificar.php");

  await http.post(url, body: {
    'idprecio': idprecio,
    'nombre': nombre,
    'precio': precio,
    'tipo': tipo,
  });
}

void eliminarPrecio(idprecio) async {
  var url = Uri.parse(
      "https://pmproyecto.000webhostapp.com/proyectolavauparapi/eliminar.php");

  await http.post(url, body: {
    'idprecio': idprecio,
  });
}