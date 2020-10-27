import 'dataProduct.dart';

class ProductDto {

  int code;
  DataProduct data;

  ProductDto();

  ProductDto.fromJson(List<dynamic> snapshot) {
    if (snapshot == null) {
      code = 500;
    } else {
      code = 200;
      data = DataProduct.fromJson(snapshot);
    }   
  }
}