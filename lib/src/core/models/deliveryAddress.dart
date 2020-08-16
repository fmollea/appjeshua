class DeliveryAddress {
  int id;
  String name;
  String days;
  String address;
  String city;
  String postalCode;
  String additional;
  int isDefault;
  String stateId;
  String customerId;

  DeliveryAddress.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    days = snapshot['days'];
    address = snapshot['address'];
    city = snapshot['city'];
    postalCode = snapshot['postal_code'];
    additional = snapshot['additional'];
    isDefault = int.parse(snapshot['default']);
    stateId = snapshot['state_id'];
    customerId = snapshot['customer_id'];
  }

  DeliveryAddress(
      this.id,
      this.name,
      this.days,
      this.address,
      this.city,
      this.postalCode,
      this.additional,
      this.isDefault,
      this.stateId,
      this.customerId);
}

class DeliveryAddresses {
  List<DeliveryAddress> list = List();

  DeliveryAddresses();

  DeliveryAddresses.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final deliveryAddress = DeliveryAddress.fromJson(item);
      list.add(deliveryAddress);
    });
  }
}
