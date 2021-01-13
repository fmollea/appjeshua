class PaymentMethod {
  int id;
  String name;
  int status;
  bool isSelected;

  PaymentMethod.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    status = snapshot['status'];
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
