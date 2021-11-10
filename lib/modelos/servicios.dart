class Servicio {
  final String idservicio;
  final String nombre;
  final String direccion;
  final String fecha;
  final String cliente;
  final String estado;
   

  Servicio({
     this.idservicio,
     this.nombre,
     this.direccion,
     this.fecha,
     this.cliente,
     this.estado,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) {
    return Servicio(
      idservicio: json['idservicio'],
      nombre: json['nombre'],
      direccion: json['direccion'],
      fecha: json['fecha'],
      cliente: json['cliente'],
      estado: json['estado'],
    );
  }
}
