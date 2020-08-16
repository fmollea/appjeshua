class Product {
  int id;
  String name;
  String code;
  String brandId;
  String description;
  String path;
  String stock;
  String price;
  String pricePublic;
  bool isFav;
  bool isAvaiable;

  Product.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    code = snapshot['code'];
    brandId = snapshot['brand_id'];
    description = snapshot['description'];
    path = snapshot['path'];
    price = snapshot['precio'];
    pricePublic = snapshot['precio_pub'];
    stock = snapshot['cantidad'];
    isFav = snapshot['is_fav'];
    isAvaiable = snapshot['is_avaiable'];
  }

  Product(
      this.id,
      this.name,
      this.code,
      this.brandId,
      this.description,
      this.stock,
      this.price,
      this.pricePublic,
      this.path,
      this.isFav,
      this.isAvaiable);
}

class Products {
  List<Product> list = List();

  Products();

  Products.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final product = Product.fromJson(item);
      list.add(product);
    });
  }
}
