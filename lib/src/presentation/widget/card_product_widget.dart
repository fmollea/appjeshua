import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/services/apiFavourite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CardProductWidget extends StatefulWidget {
  Product item;

  CardProductWidget({@required this.item});

  @override
  _CardProductWidgetState createState() => _CardProductWidgetState(item: item);
}

class _CardProductWidgetState extends State<CardProductWidget> {
  Product item;
  _CardProductWidgetState({@required this.item});

  @override
  Widget build(BuildContext context) {
    return _drawCard(context);
  }

  Widget _drawCard(BuildContext context) {
    return InkResponse(
      child: _drawChild(),
      onTap: () => _navToProduct(),
    );
  }

  _navToProduct() {
    Navigator.pushNamed(context, 'products_detail_page', arguments: item.id);
  }

  Widget _drawChild() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_drawHeader(), _drawContent(), _drawFooter()],
    );
  }

  Widget _drawHeader() {
    return FadeInImage.assetNetwork(
        placeholder: 'assets/not_found.png',
        image: item.path,
        width: 100,
        height: 100,
        fit: BoxFit.fill);
  }

  Widget _drawContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          Container(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$' + item.price,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                    fontSize: 18),
              ),
              Text(
                '\$' + item.pricePublic,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                    fontSize: 18),
              ),
            ],
          ),
          Container(
            height: 4.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Neto',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                    fontSize: 14),
              ),
              Text(
                'Público',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                    fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _drawFooter() {
    return Row(
      children: [
        item.isAvaiable
            ? Icon(FlutterIcons.check_circle_faw, color: Colors.green)
            : Icon(FlutterIcons.error_outline_mdi, color: Utils.redColor),
        item.isAvaiable
            ? Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Disponible', style: TextStyle(fontSize: 13)))
            : Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('No disponible', style: TextStyle(fontSize: 13))),
        Expanded(child: Container()),
        _favourite(),
      ],
    );
  }

  _favourite() {
    return InkResponse(
      child: _drawIconFav(),
      onTap: _addFavouriteProduct,
    );
  }

  _addFavouriteProduct() async {
    final apiFav = ApiFavourite();
    ResponseDto response;

    if (item.isFav) {
      response = await apiFav.removeProducFavourite(item.id);
      if (NetworkUtils.isReqSuccess(response.code)) {
        item.isFav = false;
      }
    } else {
      response = await apiFav.addProducFavourite(item.id);
      if (NetworkUtils.isReqSuccess(response.code)) {
        item.isFav = true;
      }
    }

    _drawIconFav();
    setState(() {});
  }

  Widget _drawIconFav() {
    final utils = Utils();
    if (item.isFav) {
      return utils.getIcon("is_fav", Utils.redColor);
    } else {
      return utils.getIcon("not_fav", Utils.redColor);
    }
  }
}
