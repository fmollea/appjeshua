class BillingAddress {
  int id;
  String rfc;
  String businessName;
  String type;
  String address;
  String city;
  String postalCode;
  String outside;
  String inside;
  int isDefault;
  String stateId;
  String customerId;

  BillingAddress.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    rfc = snapshot['rfc'];
    businessName = snapshot['business_name'];
    type = snapshot['type'];
    address = snapshot['address'];
    city = snapshot['city'];
    postalCode = snapshot['postal_code'];
    outside = snapshot['outside'];
    inside = snapshot['inside'];
    isDefault = int.parse(snapshot['default']);
    stateId = snapshot['state_id'];
    customerId = snapshot['customer_id'];
  }

  BillingAddress(
      this.id,
      this.rfc,
      this.businessName,
      this.type,
      this.address,
      this.city,
      this.postalCode,
      this.outside,
      this.inside,
      this.isDefault,
      this.stateId,
      this.customerId);
}

class BillingAddresses {
  List<BillingAddress> list = List();

  BillingAddresses();

  BillingAddresses.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final deliveryAddress = BillingAddress.fromJson(item);
      list.add(deliveryAddress);
    });
  }
}
