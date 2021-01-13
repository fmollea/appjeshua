class DeliveryAddress {

  DeliveryAddress._private();

  static final DeliveryAddress _instance = DeliveryAddress._private();

  factory DeliveryAddress() {
    return _instance;
  }

  String street;
  String city;
  String colony;
  String country;
  String inside;
  String outside;
  String postal;
  String state;

  Map<String, dynamic> toJson() => {
        "city": city,
        "colony": colony,
        "country": country,
        "exterior": outside,
        "interior": inside,
        "postal": postal,
        "state": state,
        "street": street,
    };

 changeNullToEmpty() {
    city = city == null ? "" : city;
    colony = colony == null ? "" : colony;
    country = country == null ? "" : country;
    outside = outside == null ? "" : outside;
    inside = inside == null ? "" : inside;
    postal = postal == null ? "" : postal;
    state = state == null ? "" : state;
    street = street == null ? "" : street;
 } 

}