class BillingAddress {

  BillingAddress._private();

  static final BillingAddress _instance = BillingAddress._private();

  factory BillingAddress() {
    return _instance;
  }  

  String type;
  String street;
  String city;
  String colony;
  String country;
  String outside; //exterior
  String inside; //interior
  String postal;
  String razon;
  String rfc;
  String state;
  bool ticket;

  Map<String, dynamic> toJson() => {
        "city": city,
        "colony": colony,
        "country": country,
        "exterior": outside,
        "interior": inside,
        "postal": postal,
        "razon": razon,
        "rfc": rfc,
        "state": state,
        "street": street,
        "type": type,
        "ticket": ticket,
    };

  changeNullToEmpty() {
    city = city == null ? "" : city;
    colony = colony == null ? "" : colony;
    country = country == null ? "" : country;
    outside = outside == null ? "" : outside;
    inside = inside == null ? "" : inside;
    postal = postal == null ? "" : postal;
    razon = razon == null ? "" : razon;
    rfc = rfc == null ? "" : rfc;
    state = state == null ? "" : state;
    street = street == null ? "" : street;
    type = type == null ? "" : type;
    ticket = ticket == null ? false : ticket;
  }  
}
