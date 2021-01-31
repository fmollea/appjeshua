import 'package:appjeshua/src/core/services/apiCart.dart';
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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              FadeInImage(
                image: NetworkImage(Utils.getProductImage(item.path, item.id)),
                placeholder: AssetImage('assets/not_found.png'),
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              _drawInfo(),
              _favourite()
            ]),
          _drawButtonAddtoCart()  
          ],
        )),
      onTap: () => _onTileClicked(item.slug),
    );
  }

  _drawInfo() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(item.name,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)
            ),
            Container(height: 4),
            Text(item.description,
              style: TextStyle(color: Colors.black54, fontSize: 14.0), maxLines: 2),
            Container(height: 8),
            _drawPrice()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
          ),
      ),
    );
  }

  _drawPrice() {
    return Text(
      '\$ ${item.price} MXN',
      style: TextStyle(
          color: Colors.redAccent,
          fontSize: 18.0,
          fontWeight: FontWeight.bold),
    );
  }

  _onTileClicked(String slug) {
    Navigator.pushNamed(context, 'products_detail_page', arguments: slug);
  }

  // TODO recordar quitar esta parte y usar el widget favourite. El problema es que no hace update de la lista.
  _favourite() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkResponse(
        child: _drawIconFav(),
        onTap: _addFavouriteProduct,
      ),
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

  _drawButtonAddtoCart() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 12),
      child: InkResponse(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.shopping_cart, color: Utils.primaryColor,),
              Text('  Agregar', style: TextStyle(color: Utils.primaryColor, fontWeight: FontWeight.bold, fontSize: 18))
            ]     
        ),
        onTap: addCart,
      ),
    );
  }

  void addCart() async {
    if (item.isAvaiable) {
      Utils.showLoading(context);
      final apiCart = ApiCart();
      final response =
          await apiCart.addProductCart(1, item.id);
      if (NetworkUtils.isReqSuccess(response.code)) {
        Utils.showToast("¡Se agregó al carrito!",
            Colors.white, Colors.green);
        Utils.hideLoading(context);   
      } else {
        Utils.showToast(item.name + " no se pudo agregar al carrito.",
            Colors.white, Colors.red);
        Utils.hideLoading(context);
      } 
    } else {
      Utils.showToast("Producto no disponible.", Colors.white, Colors.red);
    }
  }
}
