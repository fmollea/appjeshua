import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/services/apiCart.dart';
import 'package:appjeshua/src/core/services/apiFavourite.dart';
import 'package:appjeshua/src/core/services/apiProduct.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:flutter/material.dart';

class DetailProductPage extends StatefulWidget {
  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int _idProduct;
  String _title = "Detalle del producto";
  Product _product;
  int _quantitySelected = 0;
  List<int> _listQuantity = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    _idProduct = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(_title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold))),
      body: drawScreen(),
    );
  }

  Widget drawScreen() {
    if (_product == null) {
      _fetchData();
      return Center(child: CircularProgressIndicator());
    } else {
      return drawBody();
    }
  }

  void _fetchData() async {
    ApiProduct _api = ApiProduct();
    _product = await _api.showProduct(_idProduct);
    drawScreen();
    _title = _product.name;
    setState(() {});
  }

  Widget setTitleScreen() {
    if (_product == null) {
      Text("Detalle del producto",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold));
    } else {
      Text(_product.name,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold));
    }
  }

  Widget drawBody() {
    return Padding(
        padding: EdgeInsets.only(right: 12.0, left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('', style: TextStyle(fontSize: 24.0)),
            Text(_product.name,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            Text('', style: TextStyle(fontSize: 8.0)),
            Text(_product.name,
                style: TextStyle(color: Colors.black54, fontSize: 16.0)),
            Text('', style: TextStyle(fontSize: 8.0)),
            Center(
                child: FadeInImage.assetNetwork(
                    placeholder: Utils.placeHolderPath,
                    image: _product.path,
                    fit: BoxFit.fill,
                    height: 250)),
            Text('', style: TextStyle(fontSize: 8.0)),
            _rowPriceFav(),
            Text('', style: TextStyle(fontSize: 8.0)),
            _selectCant(),
            Text('', style: TextStyle(fontSize: 8.0)),
            Text("Descripcion:",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            Text('', style: TextStyle(fontSize: 8.0)),
            Text(_product.description,
                style: TextStyle(color: Colors.black87, fontSize: 18.0)),
            Expanded(child: Text('', style: TextStyle(fontSize: 8.0))),
            ButtonWidget(
                addProductCart, Utils.primaryColor, "Agregar al carrito"),
            Text('', style: TextStyle(fontSize: 8.0)),
            ButtonWidget(navToPage, Colors.redAccent, "Comprar"),
            Text('', style: TextStyle(fontSize: 8.0)),
          ],
        ));
  }

  navToPage() {
    Navigator.pushNamed(context, 'purchase_summary_page');
  }

  addProductCart() async {
    if (_quantitySelected == 0) {
      Utils.showToast(
          "Seleccione la cantidad de " +
              _product.name +
              " quiere agregar al carrito.",
          Colors.white,
          Colors.red);
    } else {
      final apiCart = ApiCart();
      final response =
          await apiCart.addProductCart(_quantitySelected, _idProduct);
      if (NetworkUtils.isReqSuccess(response.code)) {
        Utils.showToast(_product.name + " agregado al carrito.", Colors.white,
            Colors.green);
      } else {
        Utils.showToast(_product.name + " no se pudo agregar al carrito.",
            Colors.white, Colors.red);
      }
    }
  }

  _rowPriceFav() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(
          '\$ ' + _product.price,
          style: TextStyle(
              color: Colors.redAccent,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        )),
        _favourite()
      ],
    );
  }

  _selectCant() {
    return DropdownButton(
      style: TextStyle(color: Colors.black87, fontSize: 18),
      isExpanded: true,
      value: _quantitySelected,
      hint: Text('Cantidad: ' + _quantitySelected.toString(),
          style: TextStyle(color: Colors.black54)),
      items: _listQuantity.map((quantity) {
        return DropdownMenuItem(
          child: new Text(quantity.toString()),
          value: quantity,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _quantitySelected = value;
        });
      },
    );
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

    if (_product.isFav) {
      response = await apiFav.removeProducFavourite(_product.id);
      if (NetworkUtils.isReqSuccess(response.code)) {
        _product.isFav = false;
      }
    } else {
      response = await apiFav.addProducFavourite(_product.id);
      if (NetworkUtils.isReqSuccess(response.code)) {
        _product.isFav = true;
      }
    }

    _drawIconFav();
    setState(() {});
  }

  Widget _drawIconFav() {
    final utils = Utils();
    if (_product.isFav) {
      return utils.getIcon("is_fav", Utils.redColor);
    } else {
      return utils.getIcon("not_fav", Utils.redColor);
    }
  }
}
