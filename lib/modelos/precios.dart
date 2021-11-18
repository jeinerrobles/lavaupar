class Precio {
  final String idprecio;
  final String nombre;
  final String precio;
  final String tipo;
   

  Precio({
     this.idprecio,
     this.nombre,
     this.precio,
     this.tipo
  });

  factory Precio.fromJson(Map<String, dynamic> json) {
    return Precio(
      idprecio: json['idprecio'],
      nombre: json['nombre'],
      precio: json['precio'],
      tipo: json['tipo']
    );
  }
}
