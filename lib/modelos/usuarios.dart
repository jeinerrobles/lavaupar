class Usuario {
  final String idusuario;
  final String tipousuario;
  final String nombre;
  final String apellido;
  final String direccion;
  final String telefono;
  final String contrasena;
  

  Usuario({
    required this.idusuario,
    required this.tipousuario,
    required this.nombre,
    required this.apellido,
    required this.direccion,
    required this.telefono,
    required this.contrasena,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idusuario: json['idusuario'],
      tipousuario: json['tipousuario'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      contrasena: json['contrasena'],
    );
  }
}
