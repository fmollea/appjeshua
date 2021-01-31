class DeliveryAddress {

  int id;
  String nombre;
  String apellido;
  String rfc;
  String razon;
  String type;
  String address;
  String noExt;
  String noInt;
  dynamic colony;
  dynamic municipality;
  String state;
  String city;
  dynamic phone;
  String postal;
  int predeterminada;

  DeliveryAddress();

  DeliveryAddress.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot["id"];
    nombre = snapshot["nombre"];
    apellido = snapshot["apellido"];
    rfc = snapshot["rfc"];
    razon = snapshot["razon"];
    type = snapshot["type"];
    address = snapshot["address"];
    noExt = snapshot["no_ext"];
    noInt = snapshot["no_int"];
    colony = snapshot["colony"];
    municipality = snapshot["municipality"];
    state = snapshot["state"];
    city = snapshot["city"];
    phone = snapshot["phone"];
    postal = snapshot["postal"];
    predeterminada = snapshot["predeterminada"];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "apellido": apellido,
    "rfc": rfc,
    "razon": razon,
    "type": type,
    "address": address,
    "no_ext": noExt,
    "no_int": noInt,
    "colony": colony,
    "municipality": municipality,
    "state": state,
    "city": city,
    "phone": phone,
    "postal": postal,
    "predeterminada": predeterminada,
  };

 changeNullToEmpty() {
    id = id == null ? 0 : id;
    nombre = nombre == null ? "" : nombre;
    apellido = apellido == null ? "" : apellido;
    rfc = rfc == null ? "" : rfc;
    razon = razon == null ? "" : razon;
    type = type == null ? "" : type;
    address = address == null ? "" : address;
    noExt = noExt == null ? "" : noExt;
    noInt = noInt == null ? "" : noInt;
    colony = colony == null ? "" : colony;
    municipality = municipality == null ? "" : municipality;
    state = state == null ? "" : state;
    city = city == null ? "" : city;
    phone = phone == null ? "" : phone;
    postal = postal == null ? "" : postal;
    predeterminada = predeterminada == null ? 0 : predeterminada;
  } 
}

class DeliveryAddresses {

  List<DeliveryAddress> list = List();

  DeliveryAddresses();

  DeliveryAddresses.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null ) return;


    jsonList.forEach((item) {
      final deliveryAddress = DeliveryAddress.fromJson(item);
      list.add(deliveryAddress);
    });
  }
}