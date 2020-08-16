import 'dart:convert';
import 'dart:io';
import 'package:appjeshua/src/core/models/paymentMethod.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'package:http/http.dart' as http;

class ApiPayments {
  final api = Api();
  User user = User();

  final _billingId = "billing_id";
  final _deliveryId = "delivery_id";
  final _paymentId = "payment_id";
  final _billingType = "billing_type";

  Future<PaymentMethods> listPaymentMethods() async {
    /*
    final path = api.urlPaymentMethods;
    final url = Uri.http(api.urlBase, path);
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: user.token});
    final decodedData = json.decode(response.body);
    PaymentMethods listPayments =
        PaymentMethods.fromJsonList(decodedData['payment']);

    return listPayments; */

    var data = [
      {
        'id': 1,
        'name': 'Trasnferencia eléctronica',
        'description': 'Transfiere el dinero de manera electrónica',
        'status': '200',
      },
      {
        'id': 2,
        'name': 'Efectivo contra entrega',
        'description': 'Nos pagas el pedido cuando lo recibas',
        'status': '200',
      },
      {
        'id': 3,
        'name': 'Tarjeta de crédito',
        'description': 'Paga con tu tatjeta de crédito',
        'status': '200',
      },
      {
        'id': 4,
        'name': 'Tarjeta de débito',
        'description': 'Paga con tu tarjeta de débito',
        'status': '200',
      },
      {
        'id': 5,
        'name': 'Transferencia bancaria',
        'description':
            'Paga por transferencia bancaria y envíanos el comprobante',
        'status': '200',
      }
    ];

    return PaymentMethods.fromJsonList(data);
  }

  Future<ResponseDto> processPayment() async {
    /*
    final url = Uri.http(api.urlBase, api.urlPaymentProcess, {
      _billingId: user.billingId.toString(),
      _deliveryId: user.deliveryId.toString(),
      _paymentId: user.paymentId.toString(),
      _billingType: "0"
    });

    final response = await http.post(
      url,
      headers: {HttpHeaders.authorizationHeader: user.token},
    );
    final decodedData = json.decode(response.body);

    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;*/
    var decodedData = {'status': 'ok', 'code': 200, 'message': 'ok'};
    final responseDto = ResponseDto.fromJson(decodedData);

    return responseDto;
  }
}
