import 'package:flutter/material.dart';
import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/services/apiFavourite.dart';

class RowProductWidget extends StatefulWidget {
  final Product item;

  RowProductWidget({@required this.item});

  @override
  _RowProductWidgetState createState() => _RowProductWidgetState(item: item);
}

class _RowProductWidgetState extends State<RowProductWidget> {
  final Product item;
  final Utils utils = Utils();

  _RowProductWidgetState({@required this.item});

  @override
  Widget build(BuildContext context) {
    return _drawCard(context);
  }

  Widget _drawCard(BuildContext context) {
    return InkResponse(
      child: Card(
          child: Row(children: <Widget>[
        FadeInImage.assetNetwork(
            placeholder: 'assets/not_found.png',
            image: item.path,
            width: 100,
            height: 100,
            fit: BoxFit.fill),
        Expanded(
            child: SizedBox(
                height: 120,
                child: Center(
                    child: ListTile(
                        title: Text(item.name),
                        subtitle: Text("Código " + item.code),
                        trailing: _favourite()))))
      ])),
      onTap: () => _onTileClicked(item.id),
    );
  }

  _onTileClicked(int id) {
    Navigator.pushNamed(context, 'products_detail_page', arguments: id);
  }

  // TODO recordar quitar esta parte y usar el widget favourite. El problema es que no hace update de la lista.
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
