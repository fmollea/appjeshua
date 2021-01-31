import 'dart:convert';
import 'dart:io';
import 'package:appjeshua/src/core/models/OrderDto.dart';
import 'package:appjeshua/src/core/models/paymentMethod.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'api.dart';
import 'package:http/http.dart' as http;

class ApiPayments {
  final api = Api();
  User user = User();

  Future<PaymentMethods> listPaymentMethods() async {
    final path = api.urlPaymentMethods;
    final url = Uri.https(api.urlBase, path);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    PaymentMethods listPayments =
        PaymentMethods.fromJsonList(decodedData);

    return listPayments;
  }

  Future<OrderDto> processPayment() async {
    var params = toParams(); 
    var body = json.encode(params);
    print(body);
    final url = Uri.https(api.urlBase, api.urlPaymentProcess);
    final response = await http.post(url,
      headers: {"Content-Type": "application/json; charset=utf-8"},
      body: body);
    final decodedData = json.decode(response.body);

    final responseDto = OrderDto.fromJson(decodedData);

    user.lastOrder = responseDto.id;
    user.cantCarts = 0;
    
    return responseDto; 
  }

  Map<String, dynamic> toParams() => {
      "products": List<dynamic>.from(user.carts.map((cart) => cart.toJson())),  
      "paymentMethod": user.paymentId,
      "comment": "",
      "totalAmount": user.obtainTotal(),
      "clientId": user.userId,
      "shippingAddress": user.billingId,
      "billingAddress": user.deliveryId,
      "typeBilling": "factura",
      "typeShipping": "acude",
      "sucursalId": 1,
    };
}
