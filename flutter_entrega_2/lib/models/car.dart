class Car {
  int id;
  String patente;
  String marca;
  String precio;

  Car(this.id, this.patente, this.marca, this.precio);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'patente': patente,
      'marca': marca,
      'precio': precio,
    };
    return map;
  }

  Car.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    patente = map['patente'];
    marca = map['marca'];
    precio = map['precio'];
  }
}
