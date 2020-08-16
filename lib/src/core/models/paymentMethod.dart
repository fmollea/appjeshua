class PaymentMethod {
  int id;
  String name;
  String description;
  int status;
  bool isSelected;

  PaymentMethod.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    description = snapshot['description'];
    status = int.parse(snapshot['status']);
    isSelected = false;
  }
}

class PaymentMethods {
  List<PaymentMethod> list = List();

  PaymentMethods();

  PaymentMethods.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final paymentMethod = PaymentMethod.fromJson(item);
      list.add(paymentMethod);
    });
  }
}
