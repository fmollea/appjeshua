class BillingAddress {

  int id;
  String nombre;
  String apellido;
  String address;
  String nroExt;
  String nroInt;
  String colony;
  String municipality;
  String state;
  String city;
  String rfc;
  String phone;
  String postal;
  int billingDefault;

  BillingAddress();

  BillingAddress.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot["id"];
    nombre = snapshot["nombre"];
    apellido = snapshot["apellido"];
    address = snapshot["address"];
    nroExt = snapshot["nro_ext"];
    nroInt = snapshot["nro_int"];
    rfc = snapshot['rfc'];
    colony = snapshot["colony"];
    municipality = snapshot["municipality"];
    state = snapshot["state"];
    city = snapshot["city"];
    phone = snapshot["phone"];
    postal = snapshot["postal"];
    billingDefault = snapshot["default"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "address": address,
        "nro_ext": nroExt,
        "nro_int": nroInt,
        "colony": colony,
        "municipality": municipality,
        "state": state,
        "rfc": rfc,
        "city": city,
        "phone": phone,
        "postal": postal,
        "default": billingDefault,
    };

  changeNullToEmpty() {
    id = id == null ? 0 : id;
    rfc = rfc == null ? "" : rfc;
    nombre = nombre == null ? "" : nombre;
    apellido = apellido == null ? "": apellido;
    address = address == null ? "" : address;
    nroExt = nroExt == null ? "" : nroExt;
    nroInt = nroInt == null ? "" : nroInt;
    colony = colony == null ? "" : colony;
    municipality = municipality == null ? "" : municipality;
    state = state == null ? "" : state;
    city = city == null ? "" : city;
    phone = phone == null ? "" : phone;
    postal = postal == null ? "" : postal;
    billingDefault = billingDefault == null ? 0 : billingDefault;
  }  
}

class BillingAddresses {

  List<BillingAddress> list = List();

  BillingAddresses();

  BillingAddresses.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null ) return;

    jsonList.forEach((item) {
      final deliveryAddress = BillingAddress.fromJson(item);
      list.add(deliveryAddress);
    });
  }
}