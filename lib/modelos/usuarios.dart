class Usuario {
  final String idusuario;
  final String tipousuario;
  final String nombre;
  final String email;
  final String direccion;
  final String telefono;
  final String contrasena;
   

  Usuario({
     this.idusuario,
     this.tipousuario,
     this.nombre,
     this.email,
     this.direccion,
     this.telefono,
     this.contrasena,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idusuario: json['idusuario'],
      tipousuario: json['tipousuario'],
      nombre: json['nombre'],
      email: json['email'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      contrasena: json['contrasena'],
    );
  }
}
