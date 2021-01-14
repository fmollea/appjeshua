import 'dart:convert';
import 'package:appjeshua/src/core/models/cart.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/api.dart';
import 'package:http/http.dart' as http;

class ApiCart {
  Api api = Api();
  User user = User();
 
  Future<ResponseDto> addProductCart(int quantity, int id) async {
    final url = Uri.https(api.urlBase, api.urlAddCart, {"user_id": user.userId.toString(),"product_id": id.toString(), 
      "quantity": quantity.toString()});

    final response = await http.post(url);
 
    var decodedData = {'status': 'ok', 'code': 200, 'message': 'ok'};
    final responseDto = ResponseDto.fromJson(decodedData);
    user.cantCarts++;

    return responseDto;
  }

  Future<Carts> getProductsCart() async {
    final buildPath = '${api.urlGetProductCart}/${user.userId}';
    final url = Uri.https(api.urlBase, buildPath);

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final responseDto = Carts.fromJsonList(decodedData);
    user.cantCarts = responseDto.list.length;
    
    
    return responseDto;
  }

  Future<ResponseDto> removeProducCart(int id) async {
    final url = Uri.https(api.urlBase, api.urlDeleteCart, {"user_id": user.userId.toString(),"product_id": id.toString()});

    final response = await http.post(url);
 
    var decodedData = {'status': 'ok', 'code': 200, 'message': 'ok'};
    final responseDto = ResponseDto.fromJson(decodedData);
    user.cantCarts--;
    

    return responseDto;
  }

  Future<ResponseDto> emptyCart() async {
    final url = Uri.https(api.urlBase, api.urlEmptyCart, {"user_id": user.userId.toString()});

    final response = await http.post(url);
 
    var decodedData = {'status': 'ok', 'code': 200, 'message': 'ok'};
    final responseDto = ResponseDto.fromJson(decodedData);
    user.cantCarts = 0;
    

    return responseDto;
  }
}