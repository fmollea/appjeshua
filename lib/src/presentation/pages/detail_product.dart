import 'package:appjeshua/src/commons/NetworkUtils.dart';
import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/product.dart';
import 'package:appjeshua/src/core/models/responseDto.dart';
import 'package:appjeshua/src/core/models/user.dart';
import 'package:appjeshua/src/core/services/apiCart.dart';
import 'package:appjeshua/src/core/services/apiFavourite.dart';
import 'package:appjeshua/src/core/services/apiProduct.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:appjeshua/src/presentation/widget/container_with_border.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class DetailProductPage extends StatefulWidget {
  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  String _slugProduct;
  String _title = "Detalle del producto";
  Product _product;
  int _quantitySelected = 0;
  ResponseDto response;
  User user = User();


  @override
  Widget build(BuildContext context) {
    _slugProduct = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
        actions: <Widget>[
          GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Badge(
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(user.cantCarts.toString(), style: TextStyle(color: Colors.white)),
                  child: Icon(Icons.shopping_cart, color: Colors.white)),
              ),
              onTap: () {
                navToPage();
              },
            ),
          Container(width: 8),  
        ],
      ),
      body: drawScreen(),
    );
  }

  drawScreen() {
    ApiProduct _api = ApiProduct();
    return FutureBuilder(
      future: _api.showProduct(_slugProduct),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _product = snapshot.data;
          _title = _product.name;
          return drawContent();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget drawContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _drawName(),
          _drawCode(),
          _drawImage(),
          Container(height: 8),
          _drawDescription(),
          _drawCodeAndAvailable(),
          Container(height: 8),
          _drawRowPrices(),
          _drawAmount(),
          _drawButtonAdd(),
        ],
      ),
    );
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
      if (response == null) {
        showLoading();
        response =
          await apiCart.addProductCart(_quantitySelected, _product.id);
        setState(() {
          addProductCart();
        });  
      } else {
        Navigator.pop(context);
      
        if (NetworkUtils.isReqSuccess(response.code)) {
          Utils.showToast(_product.name + " agregado al carrito.",
              Colors.white, Colors.green);  
        } else {
          Utils.showToast(_product.name + " no se pudo agregar al carrito.",
              Colors.white, Colors.red);
        }
      }
    }
  }

  showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
          ));
        });
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
      return utils.getIcon("is_fav", Colors.red);
    } else {
      return utils.getIcon("not_fav", Colors.red);
    }
  }

  Widget _drawImage() {
    try {
      return FadeInImage.assetNetwork(
        placeholder: Utils.placeHolderPath,
        image: Utils.getProductImage(_product.path, _product.id),
        fit: BoxFit.fill);
    } catch(e) {
      return Image.asset(Utils.placeHolderPath);
    }
  }

  _drawName() {
    return Text(_product.name,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.bold));
  }

  Widget _drawCodeAndAvailable() {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          _favourite(),
          Expanded(child:Container(width: 16)),
           _disponible()
        ],
      ),
    );
  }

  _disponible() => Row(
        children: [
          _product.isAvaiable
              ? Icon(Icons.check, color: Colors.green)
              : Icon(Icons.close, color: Colors.red),
          _product.isAvaiable
              ? Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text('Disponible', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)))
              : Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text('No disponible', style: TextStyle(fontSize: 14))),
        ],
      );

  Widget _drawDescription() {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Descripción', style: TextStyle(color: Utils.secondaryColor, fontWeight: FontWeight.bold)),
          Container(height: 8),
          Text(_product.description),
          Container(height: 8),
          Row(children: [
            Text('LABORATORIO: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_product.department),
          ]),
          Container(height: 8)
        ],
    );
  }

  Widget _drawRowPrices() {
    return Row(
      children: [_labelPrecio('Precio Neto', _product.price), 
      VerticalDivider(width: 2),
      _labelPrecio('Precio P{ublico', _product.priceWithOutIva)],
    );
  }

  Widget _labelPrecio(String label, String price) {
    return Row(
      children: [
        _precio(price),
        Text(
        '  $label',
        style: TextStyle(
            color: Utils.secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14),
      )
      ],
    );
  }

  Widget _precio(String price) => Text(
        '\$ ' + price,
        style: TextStyle(
            color: Utils.secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      );

  _drawAmount() {
    var controller = TextEditingController();
    if (_quantitySelected == null) {
      _quantitySelected = 1;
    }
    controller.text = _quantitySelected.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          ContainerWidthBorder(
            content: FlatButton(
              child: Text('-', style: TextStyle(fontSize: 16)),
              onPressed: () {
                setState(() {
                  if (_quantitySelected > 0) _quantitySelected--;
                });
              },
            ),
          ),
          Expanded(
              child: Container(
          height: 42,
          child: Center(
            child: Focus(
              onFocusChange: (hasFocus) {
                  if(hasFocus) {
                    controller.text = "";
                  } else {
                    checkTextField(controller);
                  }
              },
              child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              onChanged: (value) {
                if (value != null && int.parse(value) > 0) {
                    _quantitySelected = int.parse(value);
                }
              },
              onEditingComplete: () {
                  checkTextField(controller);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
              )),
            ),
          ),
        ),
    )),
          ContainerWidthBorder(
              content: FlatButton(
            child: Text('+', style: TextStyle(fontSize: 16)),
            onPressed: () {
              setState(() {
                _quantitySelected++;
              });
            },
          )),
        ],
      ),
    );
  }

  checkTextField(TextEditingController controller) {
    if (controller.text == "") controller.text = "0";
    setState(() {});
    FocusScope.of(context).unfocus();
  }

  Widget _drawButtonAdd() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ButtonWidget(() {
          addProductCart();
        }, Utils.redColor, 'Agregar al carrito'),
      );

  _drawCode() {
    return Text('Código ${_product.sku}',
        style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0));
  }
}