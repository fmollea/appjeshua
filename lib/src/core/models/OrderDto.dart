class OrderDto {
  int id;
  String total;
  String subtotal;
  String status;
  String open;
  String paid;
  DateTime create;

  OrderDto.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    total = snapshot['total'];
    subtotal = snapshot['subtotal'];
    status = snapshot['status'];
    open = snapshot['open'];
    create = snapshot['s'] == 'n'
        ? DateTime.parse(snapshot['created_at'])
        : DateTime.now();
    paid = snapshot['paid'];
  }
}

class Orders {
  List<OrderDto> list = List();

  Orders();

  Orders.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final order = OrderDto.fromJson(item);
      list.add(order);
    });
  }
}
