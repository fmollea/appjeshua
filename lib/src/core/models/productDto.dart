import 'dataProduct.dart';

class ProductDto {

  String status;
  int code;
  String message;
  DataProduct data;

  ProductDto.fromJson(Map<String, dynamic> snapshot) {
    status = snapshot['status'];
    code = snapshot['code'];
    message = snapshot['message'];
    if (code < 290) data = DataProduct.fromJson(snapshot['products']);
    else data = null;
  }
}