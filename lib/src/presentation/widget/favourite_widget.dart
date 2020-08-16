import 'package:flutter/material.dart';
import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/services/apiFavourite.dart';

class FavouriteWidget extends StatefulWidget {
  final int idProduct;
  final bool isFav;

  FavouriteWidget({@required this.idProduct, @required this.isFav});

  @override
  _FavouriteWidgetState createState() =>
      _FavouriteWidgetState(idProduct: idProduct, isFav: isFav);
}

class _FavouriteWidgetState extends State<FavouriteWidget> {
  int idProduct;
  bool isFav;

  _FavouriteWidgetState({@required this.idProduct, @required this.isFav});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: _drawIconFav(),
      onTap: _addFavouriteProduct,
    );
  }

  _addFavouriteProduct() async {
    final apiFav = ApiFavourite();
    ResponseDto response;

    if (isFav) {
      response = await apiFav.removeProducFavourite(idProduct);
      if (NetworkUtils.isReqSuccess(response.code)) {
        isFav = true;
      }
    } else {
      response = await apiFav.addProducFavourite(idProduct);
      if (NetworkUtils.isReqSuccess(response.code)) {
        isFav = false;
      }
    }

    _drawIconFav();
    setState(() {});
  }

  Widget _drawIconFav() {
    final utils = Utils();
    if (isFav) {
      return utils.getIcon("is_fav", Utils.primaryColor);
    } else {
      return utils.getIcon("not_fav", Utils.primaryColor);
    }
  }
}
